//
//  NSObject+Swizzling.m
//  BeiKo_Doctor
//
//  Created by Lion•Neo on 2017/6/29.
//  Copyright © 2017年 com.alensic.www. All rights reserved.
//

#import "NSObject+Swizzling.h"
#import "ReactiveObjC/ReactiveObjC.h"
#import <YYKit/NSObject+YYModel.h>
#import "NSString+LNStaticString.h"
#import <OpenGLES/ES1/gl.h>
#ifdef DEBUG
/**
 打印不带时间的log
 */
#define PLog(FORMAT, ...) fprintf(stderr,"%s\n",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define PLog(...)
#endif

@implementation NSObject (Swizzling)

#pragma mark - =============================  函数  =============================

void LNSwitchSelector(SEL originSEL,SEL newSEL){
    [NSObject methodSwizzlingWithOriginalSelector:originSEL bySwizzledSelector:newSEL];
}

bool LNHasProperty(id objc, NSString *property){
    return [objc hasProperty:property];
}

void LNPrintfAllProperties(NSDictionary *dic){
    [NSObject printfFromDictionary:dic];
}
void LNPrintfAllPropertiesFrom(id objc){
    [NSObject printfAllPropertiesFrom:objc];
}


BOOL LNCheckInt(NSString *number){
    
    NSScanner* scan = [NSScanner scannerWithString:number];
    long val;
    return[scan scanInteger:&val] && [scan isAtEnd];
    
}
BOOL LNCheckFloat(NSString *number){
    
    NSScanner* scan = [NSScanner scannerWithString:number];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

#pragma mark - =============================  OC接口部分  =============================
+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector bySwizzledSelector:(SEL)swizzledSelector{
    Class class = [self class];
    //原有方法
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    //替换原有方法的新方法
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    //先尝试給源SEL添加IMP，这里是为了避免源SEL没有实现IMP的情况
    BOOL didAddMethod = class_addMethod(class,originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {//添加成功：说明源SEL没有实现IMP，将源SEL的IMP替换到交换SEL的IMP
        class_replaceMethod(class,swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {//添加失败：说明源SEL已经有IMP，直接将两个SEL的IMP交换即可
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

-(BOOL)hasProperty:(NSString *)property {
    BOOL flag = NO;
    u_int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        const char *propertyName = ivar_getName(ivars[i]);
        NSString *propertyString = [NSString stringWithUTF8String:propertyName];
        if ([propertyString isEqualToString:property]){
            flag = YES;
        }
        
    }
    return flag;
}
- (void)printfAllProperties{
    [NSObject printfAllPropertiesFrom:self];
}
+ (void)printfAllPropertiesFrom:(id)objc{
    
    PLog(@"=============================  打印开始  =============================");
    double start = CFAbsoluteTimeGetCurrent();
    if ([objc isKindOfClass:[NSString class]]) {
        const char *className = [objc cStringUsingEncoding:NSASCIIStringEncoding];
        objc  = objc_getClass(className);
    }
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([objc class], &outCount);
    
    
    for (i = 0; i<outCount; i++)
    
    {
        
        objc_property_t property = properties[i];
        
        const char* char_f = property_getName(property);
        
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        
        id propertyValue = nil;
        @try{
            
            propertyValue = [objc valueForKey:(NSString *)propertyName];
        }
        @catch(NSException *ex){
            PLog(@"%@",ex);
        }
        @finally{
            
        }
        if (propertyValue == nil) {
            propertyValue = @"值为空";
        }
        PLog(@"key:%@ ---> value:%@;",propertyName,propertyValue);
        //        PLog(@"@property(nonatomic,copy)NSString * %@;",propertyName);
    }
    
    double end = CFAbsoluteTimeGetCurrent();
    PLog(@"=============================  打印结束 共用%.2f秒  =============================",(end - start));
    free(properties);
}


+ (void)printfFromDictionary:(NSDictionary *)dic{
    
    double start = CFAbsoluteTimeGetCurrent();
    PLog(@"=============================  打印开始  =============================");
    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        //        数字（整数或浮点数）
        //        字符串（在双引号中）
        //        逻辑值（true 或 false）
        //        数组（在方括号中）
        //        对象（在花括号中）
        //        null
        
        [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSString *valueName = nil;
            if ([obj isKindOfClass:[NSString class]])  {
                
                valueName = @"@property(nonatomic,copy)NSString *";
            }else if ([obj isKindOfClass:[NSNumber class]]){
                
                if (LNCheckInt([NSString stringWithFormat:@"%@",obj])) {
                    
                    valueName = @"@property(nonatomic,copy)NSInteger";
                }else if (LNCheckFloat([NSString stringWithFormat:@"%@",obj])) {
                    
                    valueName = @"@property(nonatomic,copy)CGFloat";
                }                           
            }else if ([obj isKindOfClass:[NSArray class]]){
                
                valueName = @"@property(nonatomic,copy)NSArray *";
            }else if ([obj isKindOfClass:[NSDictionary class]]){
                
                valueName = @"@property(nonatomic,copy)NSDictionary *";
            }else if (LNIsNullString(obj)){
                
                valueName = @"@property (nonatomic, copy,nullable)NSString *";
            }if ([self judgeBoolType:obj]) {
                valueName = @"@property(nonatomic,assign)BOOL";
            }
            
            PLog(@"%@ %@;\n",valueName,key);
        }];
        [subscriber sendNext:@"=============================  属性名打印完成  ============================="];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            PLog(@"@dynamic %@;\n",key);
            
        }];
        
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *signal3 = [signal1 concat: signal2];
    [signal3 subscribeNext:^(id  _Nullable x) {
        PLog(@"%@",x);
    }];
    double end = CFAbsoluteTimeGetCurrent();
    PLog(@"=============================  打印结束 共用%.2f秒  =============================",(end - start));
}


- (NSString *)LNModelDescription{
    return [self modelDescription];
}

#pragma mark - =============================  私有方法  =============================
+ (BOOL)judgeBoolType:(id)objc{
    
    if ([objc isKindOfClass:[NSString class]]) {
        objc = [(NSString *) objc lowercaseString];
        if ([objc containsString:@"false"] || [objc containsString:@"true"]) {
            return YES;
        }
    }else if ([objc isKindOfClass:[NSNumber class]]) {
        if ([objc isEqual:@1] || [objc isEqual:@0] ) {
            return YES;
        };
    }else{
        return NO;
    }
    return NO;
}
@end
