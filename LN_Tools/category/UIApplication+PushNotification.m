//
//  UIApplication+PushNotification.m
//  根据规则跳转到指定的界面(runtime实用篇一)
//
//  Created by Lion_Neo  on 17/6/23 第174天.
//  Copyright © 2017年 hans. All rights reserved.
//

#import "UIApplication+PushNotification.h"
#import <objc/runtime.h>
/*
 //一句代码实现检测更新,很简单哦 （需要在viewDidAppear完成时，再调用改方法。不然在网速飞快的时候，会出现一个bug，就是当前控制器viewDidLoad调用的话，可能当前视图还没加载完毕就需要推出UIAlertAction）
 */

//1一定要先配置自己项目在商店的APPID,配置完最好在真机上运行才能看到完全效果哦!
#define STOREAPPID @"1104867082"

NSString * const controllerName = @"class";
NSString * const property = @"property";
@implementation UIApplication (PushNotification)


- (void)pushController:(NSString *)vcName{
    [self push:@{controllerName : vcName}];
}
/**
 *  跳转界面
 */
- (void)push:(NSDictionary *)params{
   
    id instance = [self creatController:params];
    // 获取导航控制器
    id pushClassStance = nil;
    
    if ([self.delegate.window.rootViewController isKindOfClass:[UINavigationController class]]) {
        pushClassStance = (UINavigationController *)self.delegate.window.rootViewController;
        
    }else if ([self.delegate.window.rootViewController isKindOfClass:[UITabBarController class]]){
        
         UITabBarController *tabVC = (UITabBarController *)self.delegate.window.rootViewController;
        pushClassStance = (UINavigationController *)tabVC.viewControllers[tabVC.selectedIndex];

    }else{
        return;
    }
   
    [pushClassStance pushViewController:instance animated:YES];
    
}

- (id)creatController:(NSDictionary *)params{
    // 类名
    NSString *class =[NSString stringWithFormat:@"%@", params[controllerName]];
    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    
    // 从一个字串返回一个类
    Class newClass = objc_getClass(className);
    if (!newClass)
    {
        // 创建一个类
        Class superClass = [NSObject class];
        newClass = objc_allocateClassPair(superClass, className, 0);
        // 注册你创建的这个类
        objc_registerClassPair(newClass);
    }
    // 创建对象
    id instance = [[newClass alloc] init];
    
    return instance;
    
}


/**
 属性赋值

 @param instance 实例对象
 @param propertys 数据字典
 */
- (void)setValueFor:(id)instance Frome:(NSDictionary *)propertys{
//    NSDictionary *propertys = params[property];
    
    [propertys enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // 检测这个对象是否存在该属性
        if ([self checkIsExistPropertyWithInstance:instance verifyPropertyName:key]) {
            // 利用kvc赋值
            [instance setValue:obj forKey:key];
        }
    }];
    
}
/**
 *  检测对象是否存在该属性
 */
- (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName
{
    unsigned int outCount, i;
    
    // 获取对象里的属性列表
    objc_property_t * properties = class_copyPropertyList([instance
                                                           class], &outCount);
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        //  属性名转成字符串
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        // 判断该属性是否存在
        if ([propertyName isEqualToString:verifyPropertyName]) {
            free(properties);
            return YES;
        }
    }
    free(properties);
    
    return NO;
}

/**
 *  天朝专用检测app更新
 */
-(void)checkAppHasNewVersion
{
    //2先获取当前工程项目版本号
    NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
    NSLog(@"%@",infoDic);
    NSString *currentVersion=infoDic[@"CFBundleShortVersionString"];
    
    //3从网络获取appStore版本号
    NSError *error;
    NSData *response = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",STOREAPPID]]] returningResponse:nil error:nil];
    if (response == nil) {
        NSLog(@"你没有连接网络哦");
        return;
    }
    NSDictionary *appInfoDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    if (error) {
        NSLog(@"hsUpdateAppError:%@",error);
        return;
    }
    //    NSLog(@"%@",appInfoDic);
    NSArray *array = appInfoDic[@"results"];
    
    if (array.count < 1) {
        NSLog(@"此APPID为未上架的APP或者查询不到");
        return;
    }
    
    NSDictionary *dic = array[0];
    NSString *appStoreVersion = dic[@"version"];
    //打印版本号
    NSLog(@"当前版本号:%@\n商店版本号:%@",currentVersion,appStoreVersion);
    //设置版本号
    currentVersion = [currentVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    if (currentVersion.length==2) {
        currentVersion  = [currentVersion stringByAppendingString:@"0"];
    }else if (currentVersion.length==1){
        currentVersion  = [currentVersion stringByAppendingString:@"00"];
    }
    appStoreVersion = [appStoreVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    if (appStoreVersion.length==2) {
        appStoreVersion  = [appStoreVersion stringByAppendingString:@"0"];
    }else if (appStoreVersion.length==1){
        appStoreVersion  = [appStoreVersion stringByAppendingString:@"00"];
    }
    
    //4当前版本号小于商店版本号,就更新
    if([currentVersion floatValue] < [appStoreVersion floatValue])
    {
        UIAlertController *alercConteoller = [UIAlertController alertControllerWithTitle:@"版本有更新" message:[NSString stringWithFormat:@"检测到新版本(%@),是否更新?",dic[@"version"]] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //此处加入应用在app store的地址，方便用户去更新，一种实现方式如下
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", STOREAPPID]];
            [[UIApplication sharedApplication] openURL:url];
        }];
        UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alercConteoller addAction:actionYes];
        [alercConteoller addAction:actionNo];
        [self.keyWindow.rootViewController presentViewController:alercConteoller animated:YES completion:nil];
    }else{
        NSLog(@"版本号好像比商店大噢!检测到不需要更新");
    }
    
}



@end
