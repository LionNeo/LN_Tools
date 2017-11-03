

#import "NSString+unicode.h"

@implementation NSString (unicode)
- (NSString *)unicodeString{

    NSString *desc = [self description];
    desc = [NSString stringWithCString:[desc cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
    return desc;

}

/**
 *  这种方法也可以使用
 */
//- (NSString *)unicodeString{
//    
//    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
//    
//    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
//    
//    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
//    
//    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
//    
//    
//     NSPropertyListFormat format = NSPropertyListOpenStepFormat;
//    
//     NSString *returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:&format error:nil];
//  
//    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
//    
//  
//}
@end
