//
//  "LNKeychainUtils.h"
//
//
// https://github.com/beelsebob/F1Pad/commit/66ea68e08eef0a66c706c45583e071f0a032f3c8

#import <UIKit/UIKit.h>


@interface LNKeychainUtils : NSObject {
    
}

+ (NSString *) getPasswordForUsername: (NSString *) username andServiceName: (NSString *) serviceName error: (NSError **) error;

+ (BOOL) storeUsername: (NSString *) username andPassword: (NSString *) password forServiceName: (NSString *) serviceName updateExisting: (BOOL) updateExisting error: (NSError **) error;
+ (BOOL) deleteItemForUsername: (NSString *) username andServiceName: (NSString *) serviceName error: (NSError **) error;
+ (BOOL) purgeItemsForServiceName:(NSString *) serviceName error: (NSError **) error;

@end