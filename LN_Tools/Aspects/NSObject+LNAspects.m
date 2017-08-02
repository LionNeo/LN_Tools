//
//  NSObject+LNAspects.m
//  BeiKo_Doctor
//
//  Created by Lion•Neo on 2017/7/10.
//  Copyright © 2017年 com.alensic.www. All rights reserved.
//

#import "NSObject+LNAspects.h"


@implementation NSObject (LNAspects)

+ (id<AspectToken>)LNAspect_hookSelector:(SEL)selector
                           withOptions:(AspectOptions)options
                            usingBlock:(id)block
                                   error:(NSError **)error{
    
    Class temp = objc_getMetaClass(NSStringFromClass([self class]).UTF8String);
    return  [temp aspect_hookSelector:selector withOptions:options usingBlock:block error:error];
    
}
@end
