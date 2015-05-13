//
//  CityLocation.m
//  CityLocation
//
//  Created by xiazer on 15/5/12.
//  Copyright (c) 2015年 xiazer. All rights reserved.
//

#import "CityLocation.h"
#import "CLLocationManager+FF.h"
#import "CityLocationManager.h"

@interface CityLocation () <CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, strong) CLGeocoder *geocoder;
@end

@implementation CityLocation

- (void)locationForCityInfo:(void(^)(CityLocationStatus status, CityInfo *cityInfo))locationBlock {
    self.locationBlock = locationBlock;

    if (self.locationBlock) {
        self.locationBlock(CityLocationForIng,nil);
    }

    if (![CLLocationManager isLocationServiceEnabled]) {
        if (self.locationBlock) {
            self.locationBlock(CityLocationForFailForNoPermission,nil);
        }
        
        return;
    }

    [self startLocation];
}


#pragma mark - method
- (void)restartLocation {
    if ([CLLocationManager isLocationServiceEnabled]) {
        [self.locationManager stopUpdatingLocation];
        [self.locationManager startUpdatingLocation];
    } else {
        if (self.locationBlock) {
            self.locationBlock(CityLocationForFailForNoPermission,nil);
        }
    }
}

- (void)startLocation {
    if ([CLLocationManager isLocationServiceEnabled]) {
        [self.locationManager startUpdatingLocation];
    } else {
        if (self.locationBlock) {
            self.locationBlock(CityLocationForFailForNoPermission,nil);
        }
    }
}

- (void)stopLocation {
    if ([CLLocationManager isLocationServiceEnabled]) {
        [self.locationManager stopUpdatingLocation];
    } else {
        if (self.locationBlock) {
            self.locationBlock(CityLocationForFailForNoPermission,nil);
        }
    }
}

- (void)recordForCityInfo:(CLLocation *)location {
    __weak typeof(self) this = self;
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *array, NSError *error) {
        if (array.count >= 1) {
            CLPlacemark *placemark = [array objectAtIndex:0];
            
            NSString *region = placemark.subLocality ? placemark.subLocality : @"";
            NSString *address = placemark.name ? placemark.name : @"";
            NSString *city = placemark.administrativeArea ? placemark.administrativeArea : @"";
            NSLog(@"--------->>%@/%@/%@",region,address,city);

            [self analyzeCityInfo:city];
        } else {
            NSLog(@"暂未找到有效地址");
            if (this.locationBlock) {
                this.locationBlock(CityLocationForFailForNoNet,nil);
            }
        }
     }];
}

- (void)analyzeCityInfo:(NSString *)cityName {
    CityInfo *cityInfo = [[CityLocationManager shareInstance] getCityInfoByCityName:cityName];

    if (cityInfo) {
        if (self.locationBlock) {
            self.locationBlock(CityLocationForSuccussWithCityInfo, cityInfo);
        }
    } else {
        if (self.locationBlock) {
            self.locationBlock(CityLocationForSuccussWithoutCityInfo, cityInfo);
        }
    }
}

#pragma mark  - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    [self recordForCityInfo:newLocation];
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (self.locationBlock) {
        self.locationBlock(CityLocationForFailForGps,nil);
    }
}

#pragma mark - get method
- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.distanceFilter = 500;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    
    return _locationManager;
}

- (CLGeocoder *)geocoder {
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    
    return _geocoder;
}

@end
