//
//  CityLocationManager.h
//  CityLocation
//
//  Created by xiazer on 15/5/12.
//  Copyright (c) 2015年 xiazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityInfo.h"

@interface CityLocationManager : NSObject

@property(nonatomic, strong) NSString *selectedCity;

+ (instancetype)shareInstance;

- (NSDictionary *)allCityInfo;
- (NSArray *)allCitySectionTitles;

- (CityInfo *)getCityInfoByCityId:(NSString *)cityId;
- (CityInfo *)getCityInfoByCityName:(NSString *)cityName;


@end
