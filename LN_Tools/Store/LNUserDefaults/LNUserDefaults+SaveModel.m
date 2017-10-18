//
//  LNUserDefaults+SaveModel.m
//  BeiKo_Health
//
//  Created by Lion•Neo on 2017/10/17.
//  Copyright © 2017年 com.alensic.beikohealth. All rights reserved.
//

#import "LNUserDefaults+SaveModel.h"
#import <objc/runtime.h>


@implementation LNUserDefaults (SaveModel)


#pragma mark - =============================  本地存储model  =============================
- (BOOL)saveDataToDefaultsFrom:(id)model{
    
    if (!model) return NO;
    
    //    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    
    unsigned int outCount, i;
    
    objc_property_t *properties = class_copyPropertyList([model class], &outCount);
    
    for (i = 0; i<outCount; i++)
        
    {
        
        objc_property_t property = properties[i];
        
        const char* char_f =property_getName(property);
        
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        
        id propertyValue = [model valueForKey:(NSString *)propertyName];
        
        
        if (propertyValue == nil && propertyValue == NULL) {
            
            
            //            [props setObject:@"nil" forKey:propertyName];
            [self setValue:@"nil" forKey:propertyName];
            
            
        }else
            
        {
            [self setValue:propertyValue forKey:propertyName];
            //            [props setObject:propertyValue forKey:propertyName];
            
        }
        
        //        LNLog(@"@dynamic %@;",propertyName);
        
    }
    
    free(properties);
    
    
    return YES;
}


- (void)cleanAllProperties{
    unsigned int outCount, i;
    
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for (i = 0; i<outCount; i++)
        
    {
        objc_property_t property = properties[i];
        
        const char* char_f =property_getName(property);
        
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        
        [self setValue:nil forKey:(NSString *)propertyName];
        
    }
    
}

- (void)cleanPropertiesForKeys:(NSArray *)keys{
    for (NSString *key in keys) {
        [self setValue:nil forKey:key];
    }
}
- (void)cleanPropertyForKey:(NSString *)key{
    [self setValue:nil forKey:key];
}
@end
