//
//  CityLocation.h
//  CityLocation
//
//  Created by xiazer on 15/5/12.
//  Copyright (c) 2015年 xiazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityInfo.h"


typedef NS_ENUM(NSInteger, CityLocationStatus) {
    CityLocationForSuccussWithCityInfo = 0, //定位成功并获得cityInfo
    CityLocationForSuccussWithoutCityInfo = 1, //定位成功但不在当前city列表
    CityLocationForIng = 2, //定位中
    CityLocationForFailForNoPermission = 3, //定位失败，无权限
    CityLocationForFailForNoNet = 4, //定位查询位置是啊比
    CityLocationForFailForGps = 5 //定位失败

};

@interface CityLocation : NSObject

- (void)restartLocation;
- (void)startLocation;
- (void)stopLocation;

@property (nonatomic, copy) void(^locationBlock)(CityLocationStatus status, CityInfo *cityInfo);

- (void)locationForCityInfo:(void(^)(CityLocationStatus status, CityInfo *cityInfo))locationBlock;

@end


