//
//  UIView+GOView.h
//  Gone_Rebuild
//
//  Created by  on 2016/11/24.
//  Copyright © 2016年 com.xgx.gworld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (frame)
/**
 *  view的底部
 */
@property (nonatomic) CGFloat bottom;
/**
 *  view的右边
 */
@property (nonatomic, assign) CGFloat right;
/** 
 view的x
 */
@property (nonatomic, assign) CGFloat x;
/** 
 view的y
 */
@property (nonatomic, assign) CGFloat y;
/**
 view的宽度
 */
@property (nonatomic, assign) CGFloat width;
/**
 view的高度
 */
@property (nonatomic, assign) CGFloat height;
/**
 view的中心的x
 */
@property (nonatomic, assign) CGFloat centerX;
/**
 view的中心的y 
 */
@property (nonatomic, assign) CGFloat centerY;
/**
 view的尺寸 
 */
@property (nonatomic, assign) CGSize size;
/** 
 view的原点 
 */
@property (nonatomic, assign) CGPoint origin;

@end
