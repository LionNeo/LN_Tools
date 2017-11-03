//
//  UIApplication+PushNotification.h
//  根据规则跳转到指定的界面(runtime实用篇一)
//
//  Created by Lion_Neo  on 17/6/23 第174天.
//  Copyright © 2017年 hans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (PushNotification)
/**
 *  控制器名字跳转
 *
 *  @param vcName 控制器名字,字符串
 */
- (void)pushController:(NSString *)vcName;
/**
 *  王能控制器跳转
 *
 *  @param params 服务器返回的字典
 */
- (void)push:(NSDictionary *)params;
/**
 *  检测app更新
 */
-(void)checkAppHasNewVersion;

@end
