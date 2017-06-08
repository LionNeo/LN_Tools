//
//  UIImage+Image.h
//  demo
//
//  Created by Lion on 2017/6/8.
//  Copyright © 2017年 com.LionNeo.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)
/**
 *  圆角图片
 *
 *  @param image  image
 *  @param size   image`s size
 *  @param corner 圆角
 *
 */
+(UIImage*)drawCornerImageWithOrgImage:(UIImage*)image size:(CGSize)size corner:(CGFloat)corner;
/**
 *  获取未渲染的图片
 *
 *  @param image 原始图片
 *
 */
- (UIImage *)getOriginImageFrom:(UIImage *)image;
@end
