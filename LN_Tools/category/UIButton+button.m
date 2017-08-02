//
//  UIButton+button.m
//  test
//
//  Created by Lion on 2017/5/26.
//  Copyright © 2017年 Lion. All rights reserved.
//

#import "UIButton+button.h"
#import <objc/runtime.h>

//static char *buttonClickblockKey = "buttonClickblockKey";

@implementation UIButton (button)

#pragma mark - 属性赋值  ********************************************************************
//- (void)setButtonClickblock:(buttonClickblock)buttonClickblock{
//    
//    objc_setAssociatedObject(self, buttonClickblockKey, buttonClickblock, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}
//
//- (buttonClickblock)buttonClickblock{
//    
//    return objc_getAssociatedObject(self, buttonClickblockKey);
//}

#pragma mark - 方法  ********************************************************************
- (void)setHighlighted:(BOOL)highlighted{
    //取消高亮状态
    
}

+ (UIButton *)buttonWithTitle:(NSString *)title ImageName:(NSString *) imageName selectImageName:(NSString *)selImageName target:(id) target action:(SEL)action positon:(CGPoint)origin{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.origin = origin;
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selImageName] forState:UIControlStateSelected];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (title) {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    [btn sizeToFit];
    return btn;
}

+ (UIButton *)buttonWithTitle:(NSString *)title TitleColor:(UIColor *)titleColor  target:(id) target action:(SEL)action{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn sizeToFit];
    if (titleColor) {
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
    }
    return btn;
    
}

+ (UIButton *_Nonnull)buttonWithTitle:(nonnull NSString *)title Positon:(CGPoint)origin ButtonClickBlock:(buttonClickblock)btnClickBlock{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.origin = origin;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn buttonClickBlock:^(__kindof UIControl * _Nullable sender) {
        btnClickBlock(sender);
    }];
    return btn;
}

+ (UIButton *_Nonnull)buttonWithTitle:(nullable NSString *)title ImageName:(nonnull NSString *)imageName Positon:(CGPoint)origin ButtonClickBlock:(buttonClickblock)btnClickBlock{
    UIButton *btn = [self buttonWithTitle:title Positon:origin ButtonClickBlock:^(__kindof UIControl * _Nullable sender) {
        btnClickBlock(sender);
    }];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    return btn;
}

+(UIButton *_Nonnull)buttonWithTitle:(nullable NSString *)title ImageName:(nullable NSString *)imageName SelectImageName:(nullable NSString *)selImageName Positon:(CGPoint)origin BtnClick:(nullable buttonClickblock)btnClickBlock{
    UIButton *btn = [self buttonWithTitle:title ImageName:imageName Positon:origin ButtonClickBlock:^(__kindof UIControl * _Nullable sender) {
        btnClickBlock(sender);
    }];
    [btn setImage:[UIImage imageNamed:selImageName] forState:UIControlStateSelected];
    
    return btn;
}

- (void)buttonClickBlock:(buttonClickblock)btnClickBlock{
    
    [[self rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        !btnClickBlock? : btnClickBlock(x);
    }];
   
}

@end
