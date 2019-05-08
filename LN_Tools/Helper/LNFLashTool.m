//
//  LNFLashTool.m
//  INFINITI
//
//  Created by Lion•Neo on 2019/5/8.
//  Copyright © 2019 com.szlanyou.InfinitiIOVEE. All rights reserved.
//

#import "LNFLashTool.h"
#import <AVFoundation/AVFoundation.h>

@implementation LNFLashTool

+ (instancetype)defaultFlashTool{
    static dispatch_once_t onceToken;
    static LNFLashTool *share ;
    dispatch_once(&onceToken, ^{
        share = [[LNFLashTool alloc] init];
        
    });
    
    return share;
}

- (LNFLashTool* (^)(BOOL))openFlash{
    
    return ^ LNFLashTool* (BOOL open){
        
        [self openFlashLight:open];
        return self;
    };
}


- (void)openFlashLight:(BOOL)open{
    // 根据brightnessValue的值来打开和关闭闪光灯
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    BOOL result = [device hasTorch];// 判断设备是否有闪光灯
    if (!result) return;
    if (open) {// 打开闪光灯
        
        [device lockForConfiguration:nil];
        
        [device setTorchMode: AVCaptureTorchModeOn];//开
        
        [device unlockForConfiguration];
        
    }else {// 关闭闪光灯
        
        [device lockForConfiguration:nil];
        [device setTorchMode: AVCaptureTorchModeOff];//关
        [device unlockForConfiguration];
        
    }
    
}



@end
