//
//  UIView+GestureExtension.h
//  BeiKo_Doctor
//
//  Created by Lion•Neo on 2017/7/7.
//  Copyright © 2017年 com.alensic.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GestureExtension)
- (void)addTapGestureWithTapClickBlock:(void(^)(UITapGestureRecognizer *tap))tapClickBlock;
@end
