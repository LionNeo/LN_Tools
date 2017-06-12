//
//  Color.h
//  test
//
//  Created by Lion on 2017/6/2.
//  Copyright © 2017年 Lion. All rights reserved.
//

#ifndef Color_h
#define Color_h
#import <UIKit/UIKit.h>
/**
 从16进制转换为颜色
 
 @param hexValue 16进制数据
 @param alpha 透明度
 @return 转换后的颜色
 */
UIKIT_STATIC_INLINE UIColor * LNColorFromHexValue(NSInteger hexValue, CGFloat alpha){
    
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0 alpha:alpha];
}

UIKIT_STATIC_INLINE UIColor * LNColorFromHex(NSInteger hexValue){
    
    return LNColorFromHexValue(hexValue, 1.0);
}

/**
 把字符串转换为颜色
 
 @param hexStr 16进制字符串
 @param alpha 透明度
 @return 转换后的颜色
 */
UIKIT_STATIC_INLINE UIColor * LNColorWithHexStringValue(NSString *hexStr, CGFloat alpha){
    
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    if ([hexStr hasPrefix:@"#"]) {
        hexStr = [hexStr substringFromIndex:1];
    }
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexStr substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexStr substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexStr substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:alpha];
}
UIKIT_STATIC_INLINE UIColor * LNColorWithHexString(NSString *hexStr){
    
    return LNColorWithHexStringValue(hexStr, 1.0);
}

/**
 随机色
 
 @return 随机色
 */
UIKIT_STATIC_INLINE UIColor * LNRandomColor(){
    
    NSInteger aRedValue = arc4random() % 255;
    NSInteger aGreenValue = arc4random() % 255;
    NSInteger aBlueValue = arc4random() % 255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue / 255.0f green:aGreenValue / 255.0f blue:aBlueValue / 255.0f alpha:1.0f];
    return randColor;
}

UIKIT_STATIC_INLINE UIColor * LNRGB(NSUInteger r, NSUInteger g, NSUInteger b){
    
    return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1.0];
}

UIKIT_STATIC_INLINE UIColor * LNRGBA(NSUInteger r, NSUInteger g, NSUInteger b, CGFloat alpha){
    
    return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:alpha];
}

#endif /* Color_h */
