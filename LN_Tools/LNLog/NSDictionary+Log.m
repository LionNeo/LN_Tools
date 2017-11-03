/* 文件 : NSDictionary+Log.h
 * 作者 : 杨云兴
 * 邮箱 : 747616044@qq.com
 * 日期 : 2016/11/13
 * 版权 : COPYRIGHT___
 */

#import "NSDictionary+Log.h"
#import "NSString+unicode.h"
#import <objc/runtime.h>

@implementation NSDictionary (Log)

#ifdef DEBUG
- (NSString *)descriptionWithLocale:(id)locale{
    return self.debugDescription;
}
- (NSString *)debugDescription{
    return [super debugDescription];
}
- (NSString *)ln_debugDescription{
    
    return self.ln_debugDescription.unicodeString;
}

+ (void)load{
    [self swapMethod];
}

+ (void)swapMethod{
    Method method1 = class_getInstanceMethod(self, @selector(debugDescription));
    Method method2 = class_getInstanceMethod(self, @selector(ln_debugDescription));
    
    method_exchangeImplementations(method1, method2);
}
#endif

@end
