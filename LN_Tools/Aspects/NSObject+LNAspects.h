//
//  NSObject+LNAspects.h
//  BeiKo_Doctor
//
//  Created by Lion•Neo on 2017/7/10.
//  Copyright © 2017年 com.alensic.www. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Aspects.h"

@interface NSObject (LNAspects)

/**
 aspects 实现了对类方法的拦截

 @param selector 只能是类方法名
 
 */
+ (id<AspectToken>)LNAspect_hookSelector:(SEL)selector
                             withOptions:(AspectOptions)options
                              usingBlock:(id)block
                                   error:(NSError **)error;
@end
