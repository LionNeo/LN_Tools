//
//  expandButton.h
//  neo
//
//  Created by Lion•Neo on 2017/10/19.
//  Copyright © 2017年 Lion•Neo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpandButton : UIButton
/**
 *  点击区域扩大的按钮
 *
 *  @param title    按钮 title
 *  @param image    按钮图片
 *  @param selImage 按钮选中图片
 *
 */
+ (instancetype)exButtonWithTitle:(NSString *)title ImageName:(NSString *)image SelectImage:(NSString *)selImage;
@end
