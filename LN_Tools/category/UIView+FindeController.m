//
//  UIView+FindeController.m
//  test
//
//  Created by Lion on 2017/5/31.
//  Copyright © 2017年 Lion. All rights reserved.
//

#import "UIView+FindeController.h"

@implementation UIView (FindeController)

- (UIViewController*)findViewControlle {
    
    for (UIView* nextVC = [self superview]; nextVC; nextVC = nextVC.superview) {
        
        UIResponder* nextResponder = [nextVC nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController*)nextResponder;
            
        }
        
    }
    
    return nil;
    
}
@end
