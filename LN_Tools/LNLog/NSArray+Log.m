

#import "NSArray+Log.h"
#import "NSString+unicode.h"
#import <objc/runtime.h>

@implementation NSArray (Log)

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
