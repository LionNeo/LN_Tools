//
//  CCLocationManager.h
//  test
//
//  Created by Archy on 16/3/16.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

/**
 *  地理信息获取操作
 */

typedef void (^LocationBlock)(CLLocationCoordinate2D location);

typedef void (^LocationErrorBlock)(NSError *error);

typedef void (^LocationCityNameBlock) (NSString *cityname);

typedef void (^LocationAddressDetailBlock)(NSString *Addressdetail);

@interface LNLocationManager : NSObject <CLLocationManagerDelegate>

@property(nonatomic,strong)UIViewController *vc;

+(LNLocationManager *)shareLocation;
/**
 *  获取坐标
 *
 *  @param locationBlock locationBlock description
 *  @param errorblock    错误回调
 *  @param isOrno        是否显示提示信息
 */
-(void)getLocationCoordinate:(LocationBlock)locationBlock  WithError:(LocationErrorBlock)errorblock  ShowAlter:(BOOL)isOrno;


/**
 *  获取坐标经纬度，城市名
 *
 *  @param locationBlock    locationBlock description
 *  @param locationcityname locationcityname description
 *  @param errorblock       错误回调
 *  @param isOrno           是否提示信息
 */
-(void)getLocationCoordinate:(LocationBlock)locationBlock WithCityname:(LocationCityNameBlock)locationcityname  WithError:(LocationErrorBlock)errorblock ShowAlter:(BOOL)isOrno;

/**
 *  获取详细地址信息
 *
 *  @param addressBlock 地址回调
 *  @param errorblock   错误回调
 *  @param isOrno       是否显示提示信息
 */
-(void)getLocationAddress:(LocationAddressDetailBlock)addressBlock  WithError:(LocationErrorBlock)errorblock ShowAlter:(BOOL)isOrno;


/**
 *  获取详细地址信息及经纬度
 *
 *  @param addressBlock 地址回调
 *  @param errorblock   错误回调
 *  @param isOrno       是否显示提示信息
 */
-(void)getLocationAddress:(LocationAddressDetailBlock)addressBlock WithLocation:(LocationBlock)locationblock WithError:(LocationErrorBlock)errorblock ShowAlter:(BOOL)isOrno;

@end
