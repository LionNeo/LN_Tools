//
//  NSObject+Swizzling.h
//  BeiKo_Doctor
//
//  Created by Lion•Neo on 2017/6/29.
//  Copyright © 2017年 com.alensic.www. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#pragma mark - =============================  函数  =============================

@interface NSObject (Swizzling)

UIKIT_EXTERN void LNSwitchSelector(SEL originSEL,SEL newSEL);
UIKIT_EXTERN bool LNHasProperty(id objc, NSString *property);
UIKIT_EXTERN void LNPrintfAllProperties(NSDictionary *dic);
UIKIT_EXTERN void LNPrintfAllPropertiesFrom(id objc);
UIKIT_EXTERN BOOL LNCheckInt(NSString * number);
UIKIT_EXTERN BOOL LNCheckFloat(NSString * number);


#pragma mark - =============================  OC接口部分  =============================
/**
 交换方法
 
 @param originalSelector 原方法
 @param swizzledSelector 新方法
 */
+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector
                         bySwizzledSelector:(SEL)swizzledSelector;

/**
 判断类中是否有这个属性
 
 @param property 属性名
 @return bool
 */
-(BOOL)hasProperty:(NSString *)property;

/**
 打印字典,主要是为了获取字典可以,省去创建属性时间
 
 @param dic 出入json或者字典
 */
+ (void)printfFromDictionary:(NSDictionary *)dic;

/**
 获取对象的属性,可以传对象,类或者字符串(类名),类或者类型无法打印key对应的值
 
 @param objc 对象
 */
+ (void)printfAllPropertiesFrom:(id)objc;

/**
 打印所有属性和值
 */
- (void)printfAllProperties;

/**
 用于模型的自我描述
 
 */
- (NSString *)LNModelDescription;

@end
