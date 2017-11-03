//
//  LNUserDefaults+SaveModel.h
//  BeiKo_Health
//
//  Created by Lion•Neo on 2017/10/17.
//  Copyright © 2017年 com.alensic.beikohealth. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "LNUserDefaults.h"


@interface LNUserDefaults (SaveModel)
/**
 *  从模型中保存数据
 *
 *  @param model 模型
 *
 */
- (BOOL)saveDataToDefaultsFrom:(id)model;
/**
 *  删除所有属性值
 */
- (void)cleanAllProperties;
/**
 *  删除数组中的属性值
 *
 *  @param keys 存储属性名的数组 e.g @[@"name",@"age"]
 */
- (void)cleanPropertiesForKeys:(NSArray *)keys;
/**
 *  删除对应key的属性
 *
 */
- (void)cleanPropertyForKey:(NSString *)key;

@end
