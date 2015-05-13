//
//  CityInfo.m
//  CityLocation
//
//  Created by xiazer on 15/5/12.
//  Copyright (c) 2015年 xiazer. All rights reserved.
//

#import "CityInfo.h"

@implementation CityInfo


- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.cityId forKey:@"cityId"];
    [aCoder encodeObject:self.cityName forKey:@"cityName"];
    [aCoder encodeObject:self.cityPYName forKey:@"cityPYName"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    self.cityId = [aDecoder decodeObjectForKey:@"cityId"];
    self.cityName = [aDecoder decodeObjectForKey:@"cityName"];
    self.cityPYName = [aDecoder decodeObjectForKey:@"cityPYName"];
    
    return self;
}
@end
