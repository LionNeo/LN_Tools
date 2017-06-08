//
//  UIImage+Image.m
//  demo
//
//  Created by Lion on 2017/6/8.
//  Copyright © 2017年 com.LionNeo.www. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)
+(UIImage*)drawCornerImageWithOrgImage:(UIImage*)image size:(CGSize)size corner:(CGFloat)corner
{
    
    
    CGFloat scale = [UIScreen mainScreen].scale;
    UIImage *newImage = nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0, size.height);
    CGContextScaleCTM(context, 1, -1);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width,size.height) cornerRadius:corner];
    CGContextAddPath(context, path.CGPath);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, size.width, size.height), image.CGImage);
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGContextRelease(context);
    return newImage;
    
}

- (UIImage *)getOriginImageFrom:(UIImage *)image {
	
    UIImage *originImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return originImage;
}
@end
