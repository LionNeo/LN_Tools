//
//  NSObject+LNLog.m
//  test_test
//
//  Created by Lion•Neo on 2017/11/22.
//  Copyright © 2017年 Lion•Neo. All rights reserved.
//

#import "NSObject+LNLog.h"
#import <objc/runtime.h>
#import <objc/message.h>


@implementation NSObject (LNLog)


#if DEBUG
- (NSString *)description {
    NSMutableDictionary *debugInfos = [NSMutableDictionary dictionary];
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(self.class, &count);
    for (unsigned int i = 0; i < count; ++i) {
        Ivar ivar = ivars[i];
        
        const char *name = ivar_getName(ivar);
        NSString *ivarName = [NSString stringWithUTF8String:name];
        NSLog(@"%@", ivarName);
        
        NSString *propertyName = ivarName;
        if ([propertyName hasPrefix:@"_"]) {
            propertyName = [propertyName substringFromIndex:1];
        }
        
        const char *type = ivar_getTypeEncoding(ivar);
        NSString *typeEncoding = [NSString stringWithUTF8String:type];
        id value = nil;
        
        // object
        if ([typeEncoding rangeOfString:@"@"].location != NSNotFound) {
            @try {
                value =  ((id (*)(id, SEL))objc_msgSend)((id)self, NSSelectorFromString(propertyName));
            } @catch (NSException *exception) {
                
            } @finally {
                
            }
            
        } else if ([typeEncoding rangeOfString:@"*"].location != NSNotFound) {
            @try {
                char *v = ((char * (*)(id, SEL))objc_msgSend)((id)self, NSSelectorFromString(propertyName));
                value = [NSString stringWithUTF8String:v];
            } @catch (NSException *exception) {
                
            } @finally {
                
            }
            
        } else if ([typeEncoding rangeOfString:@"#"].location != NSNotFound) {
            @try {
                value = propertyName;
            } @catch (NSException *exception) {
                
            } @finally {
                
            }
            
        } else if ([typeEncoding rangeOfString:@"^"].location != NSNotFound) {
            @try {
                value = @"基本C指针";
            } @catch (NSException *exception) {
                
            } @finally {
                
            }
            
        } else {
            @try {
                value = [self valueForKey:propertyName];
            }
            @catch (NSException *exception) {
                
            }
            @finally {
            }
        }
        
        value = value == nil ? @"<nil>" : value;
        @try {
             [debugInfos setValue:value forKey:propertyName];
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
       
    }
    
    free(ivars);
    
    return debugInfos.description;
}

- (NSString *)debugDescription {
    NSMutableDictionary *debugInfos = [NSMutableDictionary dictionary];
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(self.class, &count);
    for (unsigned int i = 0; i < count; ++i) {
        Ivar ivar = ivars[i];
        
        const char *name = ivar_getName(ivar);
        NSString *ivarName = [NSString stringWithUTF8String:name];
        NSLog(@"%@", ivarName);
    }
    
    free(ivars);
    
    return debugInfos.debugDescription;
}
#endif
@end
