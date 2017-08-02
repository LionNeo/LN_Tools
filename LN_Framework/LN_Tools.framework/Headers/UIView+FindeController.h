//
//  UIView+FindeController.h
//  test
//
//  Created by Lion on 2017/5/31.
//  Copyright © 2017年 Lion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FindeController)

/**
 *  找到当前view所在的控制器
 *
 *  @return 返回一个controller
 */
- (UIViewController*)findViewControlle;
/**
 *  UIView上添加图片
 *
 *  @param image image
 *  @param mode  显示方式
 */
- (void)addImageWithImage:(UIImage *)image contentMode:(UIViewContentMode)mode;
- (void)addImageWithImage:(UIImage *)image;

/**
 *  view添加图片
 *
 *  @param imageName 图片名字
 *  @param mode      显示方式
 */
- (void)addImageWithImageName:(NSString *)imageName contentMode:(UIViewContentMode)mode;
- (void)addImageWithImageName:(NSString *)imageName;


@end
