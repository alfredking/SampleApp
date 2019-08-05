//
//  GTLocation.m
//  SampleApp
//
//  Created by alfredking－cmcc on 2019/7/27.
//  Copyright © 2019 alfredking. All rights reserved.
//

#import "GTLocation.h"
#import <CoreLocation/CoreLocation.h>
@interface GTLocation()<CLLocationManagerDelegate>

@property (nonatomic,strong,readwrite)CLLocationManager *manager;


@end
@implementation GTLocation

+(GTLocation *)locationManager
{
    static GTLocation *location;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        location = [[GTLocation alloc] init];
    });
    
    return location;
}

-(instancetype)init
{
    self =[super init];
    if (self) {
        self.manager = [[CLLocationManager alloc]init];
        self.manager.delegate = self;
         [self.manager startUpdatingLocation];
    }
    return self;
}

-(void)checkLocationAuthorization
{
    //判断系统是否开启
    if ([CLLocationManager locationServicesEnabled]) {
        //引导弹窗
        
    }
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        
        [self.manager requestWhenInUseAuthorization];
        
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        //
       
    }
    else if (status == kCLAuthorizationStatusDenied)
    {
        //
    }
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations
{
    NSLog(@"");
    CLLocation *location = [locations firstObject];
    CLGeocoder *coder= [[CLGeocoder alloc]init];
    
    [coder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        NSLog(@"placemarks is %@",placemarks);
    }];
    
    [self.manager startUpdatingLocation];
}
@end
