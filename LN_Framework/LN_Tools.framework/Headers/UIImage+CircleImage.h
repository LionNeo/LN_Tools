//
//  UIImage+CircleImage.h
//  LionNeo
//
//  Created by Lion on 2017/6/19.
//  Copyright © 2017年 com.LionNeo.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CircleImage)


- (UIImage *)circleImage;
+ (UIImage *)circleWithImage:(UIImage *)image;
+ (UIImage *)circleImageName:(NSString *)imageName;
@end
