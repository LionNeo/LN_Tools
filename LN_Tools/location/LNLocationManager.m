//
//  CCLocationManager.m
//  test
//
//  Created by Archy on 16/3/16.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import "LNLocationManager.h"
#import "LNLocationConverter.h"


#define ios_8 [UIDevice currentDevice].systemVersion.integerValue > 8.0

@interface LNLocationManager ()

{
    CLLocationManager *_Manager;
}
@property (nonatomic,copy)LocationBlock locationBlock;
@property (nonatomic,copy)LocationCityNameBlock locationCityNameBlock;
@property (nonatomic,copy)LocationErrorBlock locationErrorBlock;
@property (nonatomic,copy)LocationAddressDetailBlock locationAddressDetailBlock;

@property (nonatomic,assign)BOOL isShow;
@end
@implementation LNLocationManager

+(LNLocationManager *)shareLocation
{
    static dispatch_once_t onece = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&onece, ^{
        _sharedObject =[[self alloc]init];
    });
    return _sharedObject;
}
//获取地理经纬度坐标
-(void)getLocationCoordinate:(LocationBlock)locationBlock WithError:(LocationErrorBlock)errorblock ShowAlter:(BOOL)isOrno
{
    self.locationBlock =[locationBlock copy];
    self.locationErrorBlock =[errorblock copy];
    [self startLocation];
    self.isShow = isOrno;
}

-(void)getLocationCoordinate:(LocationBlock)locationBlock WithCityname:(LocationCityNameBlock)locationcityname WithError:(LocationErrorBlock)errorblock ShowAlter:(BOOL)isOrno
{
    self.locationBlock =[locationBlock copy];
    self.locationErrorBlock =[errorblock copy];
    self.locationCityNameBlock =[locationcityname copy];
    [self startLocation];
    self.isShow = isOrno;
}

-(void)getLocationAddress:(LocationAddressDetailBlock)addressBlock WithError:(LocationErrorBlock)errorblock ShowAlter:(BOOL)isOrno
{
    self.locationAddressDetailBlock =[addressBlock copy];
    self.locationErrorBlock =[errorblock copy];
    self.isShow = isOrno;
    [self startLocation];
}


-(void)getLocationAddress:(LocationAddressDetailBlock)addressBlock WithLocation:(LocationBlock)locationblock WithError:(LocationErrorBlock)errorblock ShowAlter:(BOOL)isOrno
{
    self.locationAddressDetailBlock =[addressBlock copy];
    self.locationErrorBlock =[errorblock copy];
    self.locationBlock =[locationblock copy];
    self.isShow = isOrno;
    [self startLocation];
}


-(void)startLocation
{
    if ([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus]!=kCLAuthorizationStatusDenied) {
        
        _Manager =[[CLLocationManager alloc]init];
        _Manager.delegate = self;
        _Manager.desiredAccuracy = kCLLocationAccuracyBest;
        [_Manager requestAlwaysAuthorization];
        _Manager.distanceFilter = 100;
        [_Manager startUpdatingLocation];
    }
    else
    {
        if (self.isShow) {
#ifdef ios_8
            
          UIAlertController *alterView = [UIAlertController alertControllerWithTitle:@"" message:@"需要开启定位服务,请到设置->隐私,打开定位服务" preferredStyle:UIAlertControllerStyleAlert];
            [self.vc presentViewController:alterView animated:YES completion:nil];

#else
            UIAlertView *alterView =[[UIAlertView alloc]initWithTitle:@"" message:@"需要开启定位服务,请到设置->隐私,打开定位服务" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alterView show];
#endif
        
            

        }
        if (_locationErrorBlock) {
            _locationErrorBlock(nil);
            _locationErrorBlock = nil;
        }

    }
}


-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
   
    
    CLLocationCoordinate2D  coordinate =CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    
    //判断是否在中国
    if (![LNLocationConverter isLocationOutOfChina:coordinate]) {
        //地图坐标转火星坐标
        coordinate =[LNLocationConverter transformFromWGSToGCJ:coordinate];
    }
     CLLocation *location =[[CLLocation alloc]initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    CLGeocoder *gecoder =[[CLGeocoder alloc]init];
    [gecoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count>0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            if (_locationCityNameBlock) {
                _locationCityNameBlock(placemark.locality);
                _locationCityNameBlock = nil;
            }
            if (_locationAddressDetailBlock) {
                _locationAddressDetailBlock(placemark.name);
                _locationAddressDetailBlock = nil;
            }
        }
        if(error)
        {
            if(_locationErrorBlock)
            {
                _locationErrorBlock(error);
                _locationErrorBlock =nil;
            }
            
            
        }

        
    }];
//    [gecoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        
//        if (placemarks.count>0) {
//            CLPlacemark *placemark = [placemarks objectAtIndex:0];
//            if (_locationCityNameBlock) {
//                _locationCityNameBlock(placemark.locality);
//                _locationCityNameBlock = nil;
//            }
//            if (_locationAddressDetailBlock) {
//                _locationAddressDetailBlock(placemark.name);
//                _locationAddressDetailBlock = nil;
//            }
//        }
//        if(error)
//        {
//            self.locationErrorBlock(error);
//
//        }
//    }];
    

    if (_locationBlock) {
        _locationBlock(coordinate);
        _locationBlock = nil;
    }
    
    [_Manager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (_locationErrorBlock) {
        _locationErrorBlock(error);
        _locationErrorBlock = nil;
    }
    [self StopLocation];
}

-(void)StopLocation
{
    [_Manager stopUpdatingLocation];
    _Manager = nil;
}
@end
