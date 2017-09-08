//
//  LocalAuthenticationHelper.h
//  BeiKo_Doctor
//
//  Created by Lion•Neo on 2017/9/7.
//  Copyright © 2017年 com.alensic.www. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LN_TouchIDState){
    /**
     *  当前设备不支持TouchID
     */
    LN_TouchIDStateNotSupport = 0,
    /**
     *  TouchID 验证成功
     */
    LN_TouchIDStateSuccess = 1,
    
    /**
     *  TouchID 验证失败
     */
    LN_TouchIDStateFail = 2,
    /**
     *  TouchID 被用户手动取消
     */
    LN_TouchIDStateUserCancel = 3,
    /**
     *  用户不使用TouchID,选择手动输入密码
     */
    LN_TouchIDStateUserFallback = 4,
    /**
     *  TouchID 被系统取消 (如遇到来电,锁屏,按了Home键等)
     */
    LN_TouchIDStateSystemCancel = 5,
    /**
     *  TouchID 无法启动,因为用户没有设置密码
     */
    LN_TouchIDStatePasscodeNotSet = 6,
    /**
     *  TouchID 无法启动,因为用户没有设置TouchID
     */
    LN_TouchIDStateTouchIDNotEnrolled = 7,
    /**
     *  TouchID 无效
     */
    LN_TouchIDStateTouchIDNotAvailable = 8,
    /**
     *  TouchID 被锁定(连续多次验证TouchID失败,系统需要用户手动输入密码)
     */
    LN_TouchIDStateTouchIDLockout = 9,
    /**
     *  当前软件被挂起并取消了授权 (如App进入了后台等)
     */
    LN_TouchIDStateAppCancel = 10,
    /**
     *  当前软件被挂起并取消了授权 (LAContext对象无效)
     */
    LN_TouchIDStateInvalidContext = 11,
    /**
     *  系统版本不支持TouchID (必须高于iOS 8.0才能使用)
     */
    LN_TouchIDStateVersionNotSupport = 12,
 
};

@interface LN_TouchIDHelper : NSObject
/**
 *  指纹解锁功能
 *
 *  @param description   描述信息,不设置,默认显示:指纹解锁
 *  @param cancelTitle   取消button,默认设置:取消
 *  @param FallbackTitle 默认显示:输入密码
 *  @param block         完成后的回调,根据类型进行判断
 */
+ (void)LN_ShowTouchIDWithDescription:(nullable NSString *)description
                          CancelTitle:(nullable NSString *)cancelTitle
                        FallbackTitle:(nullable NSString *)FallbackTitle
                        CompleteBlock:(nonnull void(^)(LN_TouchIDState state, NSError * _Nullable error))block;
@end
