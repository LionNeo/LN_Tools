//
//  LNFLashTool.h
//  INFINITI
//
//  Created by Lion•Neo on 2019/5/8.
//  Copyright © 2019 com.szlanyou.InfinitiIOVEE. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LNFLASH [LNFLashTool defaultFlashTool]
///开启闪光灯
#define LNFLASHOPEN [LNFLashTool defaultFlashTool].openFlash(YES);
///关闭闪光灯
#define LNFLASHCLOSE [LNFLashTool defaultFlashTool].openFlash(NO);
NS_ASSUME_NONNULL_BEGIN

@interface LNFLashTool : NSObject

/*!
 单利
 */
+ (instancetype)defaultFlashTool;

/*!
 是否开启闪光灯
 */
- (LNFLashTool* (^)(BOOL))openFlash;

@end

NS_ASSUME_NONNULL_END
