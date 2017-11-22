//
//  UIButton+button.h
//  test
//
//  Created by Lion on 2017/5/26.
//  Copyright © 2017年 Lion. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  button点击事件
 *
 */
typedef void(^buttonClickblock)(__kindof UIControl * _Nullable sender);
@interface UIButton (button)

/**
 *  快速创建必须有图片,可以没有title
 *
 *  @param title        标题
 *  @param imageName    图片
 *  @param selImageName 选中图片
 *  @param target       target
 *  @param action       action
 *  @param origin       origin
 *
 *  @return UIButton
 */
+ (UIButton *_Nonnull)buttonWithTitle:(nullable NSString *)title ImageName:(nonnull NSString *)imageName selectImageName:(nonnull NSString *)selImageName target:(nullable id) target action:(nullable SEL)action positon:(CGPoint)origin;
/**
 *  创建一个只有文字的按钮
 *
 */
+ (UIButton *_Nonnull)buttonWithTitle:(nonnull NSString *)title TitleColor:(nullable UIColor *)titleColor  target:(nullable id) target action:(nullable SEL)action __deprecated;
/**
 *  快速创建只有文字的button
 *
 *  @param title  title
 *  @param origin origin
 *
 */
+ (UIButton *_Nonnull)buttonWithTitle:(nonnull NSString *)title Positon:(CGPoint)origin ButtonClickBlock:(nullable buttonClickblock)btnClickBlock;
/**
 *  快速创建一个有标题图片的button
 *
 *  @param title         title
 *  @param imageName     imageName
 *  @param origin        origin
 *  @param btnClickBlock 点击事件回调
 *
 */
+ (UIButton *_Nonnull)buttonWithTitle:(nullable NSString *)title ImageName:(nonnull NSString *)imageName Positon:(CGPoint)origin ButtonClickBlock:(nullable buttonClickblock)btnClickBlock;
/**
 *  快速创建button,带有点击回调
 *
 *  @param title         title
 *  @param imageName     imageName
 *  @param selImageName  选中图片,可以为空
 *  @param origin        位置
 *  @param btnClickBlock button点击事件回调
 *
 */
+(UIButton *_Nonnull)buttonWithTitle:(nullable NSString *)title ImageName:(nullable NSString *)imageName SelectImageName:(nullable NSString *)selImageName Positon:(CGPoint)origin BtnClick:(nullable buttonClickblock)btnClickBlock;
/**
 *  button点回调
 *
 */
- (void)buttonClickBlock:(_Nullable buttonClickblock)btnClickBlock;
@end
