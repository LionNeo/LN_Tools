//
//  LocalAuthenticationHelper.m
//  BeiKo_Doctor
//
//  Created by Lion•Neo on 2017/9/7.
//  Copyright © 2017年 com.alensic.www. All rights reserved.
//

#import "LN_TouchIDHelper.h"
#import <LocalAuthentication/LocalAuthentication.h>


@implementation LN_TouchIDHelper

+ (instancetype)sharedInstance {
    static LN_TouchIDHelper *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LN_TouchIDHelper alloc] init];
    });
    return instance;
}

+ (void)LN_ShowTouchIDWithDescription:(nullable NSString *)description
                          CancelTitle:(nullable NSString *)cancelTitle
                        FallbackTitle:(nullable NSString *)FallbackTitle
                        CompleteBlock:(nonnull void(^)(LN_TouchIDState state, NSError *error))block{
    
    [[self sharedInstance] LN_ShowTouchIDWithDescription:description CancelTitle:cancelTitle FallbackTitle:FallbackTitle CompleteBlock:block];
}

- (void)LN_ShowTouchIDWithDescription:(nullable NSString *)description
                          CancelTitle:(nullable NSString *)cancelTitle
                        FallbackTitle:(nullable NSString *)FallbackTitle
                        CompleteBlock:(nonnull void(^)(LN_TouchIDState state, NSError *error))block{
    
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    context.localizedCancelTitle = (cancelTitle == nil || cancelTitle == NULL)? @"取消" : cancelTitle;
    context.localizedFallbackTitle = (FallbackTitle == nil || FallbackTitle == NULL)? @"输入密码" : FallbackTitle;
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                             error:&error]) {
        NSLog(@"支持指纹识别");
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:(description == nil || description == NULL)? @"指纹解锁" : description reply:^(BOOL success, NSError * _Nullable error) {
                    if (success) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"TouchID 验证成功");
                            block(LN_TouchIDStateSuccess,error);
                        });
                    }else if(error){;
            
                        switch (error.code) {
                            case LAErrorAuthenticationFailed:{
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    NSLog(@"TouchID 验证失败");
                                    block(LN_TouchIDStateFail,error);
                                });
                                break;
                            }
                            case LAErrorUserCancel:{
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    NSLog(@"TouchID 被用户手动取消");
                                    block(LN_TouchIDStateUserCancel,error);
                                });
                            }
                                break;
                            case LAErrorUserFallback:{
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    NSLog(@"用户不使用TouchID,选择手动输入密码");
                                    block(LN_TouchIDStateUserFallback,error);
                                });
                            }
                                break;
                            case LAErrorSystemCancel:{
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    NSLog(@"TouchID 被系统取消 (如遇到来电,锁屏,按了Home键等)");
                                    block(LN_TouchIDStateSystemCancel,error);
                                });
                            }
                                break;
                            case LAErrorPasscodeNotSet:{
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    NSLog(@"TouchID 无法启动,因为用户没有设置密码");
                                    block(LN_TouchIDStatePasscodeNotSet,error);
                                });
                            }
                                break;
                            case LAErrorTouchIDNotEnrolled:{
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    NSLog(@"TouchID 无法启动,因为用户没有设置TouchID");
                                    block(LN_TouchIDStateTouchIDNotEnrolled,error);
                                });
                            }
                                break;
                            case LAErrorTouchIDNotAvailable:{
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    NSLog(@"TouchID 无效");
                                    block(LN_TouchIDStateTouchIDNotAvailable,error);
                                });
                            }
                                break;
                            case LAErrorTouchIDLockout:{
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    NSLog(@"TouchID 被锁定(连续多次验证TouchID失败,系统需要用户手动输入密码)");
                                    block(LN_TouchIDStateTouchIDLockout,error);
                                });
                            }
                                break;
                            case LAErrorAppCancel:{
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    NSLog(@"当前软件被挂起并取消了授权 (如App进入了后台等)");
                                    block(LN_TouchIDStateAppCancel,error);
                                });
                            }
                                break;
                            case LAErrorInvalidContext:{
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    NSLog(@"当前软件被挂起并取消了授权 (LAContext对象无效)");
                                    block(LN_TouchIDStateInvalidContext,error);
                                });
                            }
                                break;
                            default:
                                break;
                        }
                    }
                }];
        
    }else{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"当前设备不支持TouchID");
            block(LN_TouchIDStateNotSupport,error);
        });
        
    }}
@end
