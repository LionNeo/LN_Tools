//
//  UIView+GestureExtension.m
//  BeiKo_Doctor
//
//  Created by Lion•Neo on 2017/7/7.
//  Copyright © 2017年 com.alensic.www. All rights reserved.
//

#import "UIView+GestureExtension.h"
#import <objc/runtime.h>

NSString * const tapKey = @"tapKey";
NSString *const blockKey = @"blockKey";

@implementation UIView (GestureExtension)

- (void)addTapGestureWithTapClickBlock:(void(^)(UITapGestureRecognizer *tap))tapClickBlock{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = objc_getAssociatedObject(self, &tapKey);
    if (!tap) tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(privateTapActionClick:)];
    objc_setAssociatedObject(self, &tapKey, tap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addGestureRecognizer:tap];
    
    objc_setAssociatedObject(self, &blockKey, tapClickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

- (void)privateTapActionClick:(UITapGestureRecognizer *)tapGesture{
    
    if (tapGesture.state == UIGestureRecognizerStateRecognized) {
        void(^action)(UITapGestureRecognizer * tap) = objc_getAssociatedObject(self, &blockKey);
        !action? : action(tapGesture);
    };
}
@end
