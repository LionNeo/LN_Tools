//
//  GVUserDefaults.h
//  GVUserDefaults
//
//  Created by Kevin Renskers on 18-12-12.
//  Copyright (c) 2012 Gangverk. All rights reserved.
//

#import <Foundation/Foundation.h>


#define UserDefaults [LNUserDefaults standardUserDefaults]


@interface LNUserDefaults : NSObject

+ (instancetype)standardUserDefaults;

@end
