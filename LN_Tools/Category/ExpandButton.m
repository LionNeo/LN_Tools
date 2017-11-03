//
//  expandButton.m
//  neo
//
//  Created by Lion•Neo on 2017/10/19.
//  Copyright © 2017年 Lion•Neo. All rights reserved.
//

#import "ExpandButton.h"


@interface ExpandButton ()
/**
 *   是否扩大点击区域,默认NO
 */
@property(nonatomic,assign)BOOL isExpandArea;
@end
@implementation ExpandButton


+ (instancetype)exButtonWithTitle:(NSString *)title ImageName:(NSString *)image SelectImage:(NSString *)selImage{
    return [[self alloc] initWithTitle:title ImageName:image SelectImage:selImage];
}

#pragma mark - =============================  私有方法  =============================
- (instancetype)initWithTitle:(NSString *)title ImageName:(NSString *)image SelectImage:(NSString *)selImage{
    if (self = [super init]) {
        
        [self setTitle:!title.length? nil : title forState:UIControlStateNormal];
        self.isExpandArea = YES;
        UIImage *ima = [UIImage imageNamed:image];
        UIImage *selIma = [UIImage imageNamed:selImage];
        [self setImage:ima forState:UIControlStateNormal];
        [self setImage:selIma forState:UIControlStateSelected];
    };
    
    return self;
}

/**
*  扩大点击区域
*/
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    
    if (self.isExpandArea) {
        
        
        CGRect bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        //扩大原热区直径至26，可以暴露个接口，用来设置需要扩大的半径。
        
        CGFloat widthDelta = MAX(44.0 - bounds.size.width, 0);
        CGFloat heightDelta = MAX(44.0 - bounds.size.height, 0);
        
        bounds = CGRectInset(bounds, - 0.5 * widthDelta, -0.5 * heightDelta);
        //    bounds = CGRectInset(bounds, - 80, -50);
        return  CGRectContainsPoint(bounds, point);
        
    };
    
    return YES;

    
    
}



@end
