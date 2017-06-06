//
//  UIView+GetPixelColor.h
//  test
//
//  Created by Lion on 2017/6/2.
//  Copyright © 2017年 Lion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GetPixelColor)
/**
 *  获取图片上一个点的颜色
 *
 *  @param point 点位置
 *  @param image 传入的图片
 *
 */
- (UIColor*) getPixelColorAtLocation:(CGPoint)point inImage:(UIImage *)image;
@end
