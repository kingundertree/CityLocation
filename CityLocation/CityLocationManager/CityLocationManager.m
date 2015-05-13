//
//  CityLocationManager.m
//  CityLocation
//
//  Created by xiazer on 15/5/12.
//  Copyright (c) 2015年 xiazer. All rights reserved.
//

#import "CityLocationManager.h"

@interface CityLocationManager ()
@property (nonatomic, strong) NSMutableDictionary *cityInfoDic;
@end

@implementation CityLocationManager

+ (instancetype)shareInstance {
    static CityLocationManager *shareSelf = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareSelf = [[self alloc] init];
    });
    
    return shareSelf;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initData];
    };
    
    return self;
}

- (void)initData {
    NSArray *cityInfoArr = @[@{@"A":@[@{@"cityId":@"1",@"cityName":@"鞍山",@"cityPYName":@"Anshan"},
                                        @{@"cityId":@"2",@"cityName":@"安阳",@"cityPYName":@"Anyang"}]},
                               @{@"B":@[@{@"cityId":@"3",@"cityName":@"包头",@"cityPYName":@"Baotou"},
                                        @{@"cityId":@"4",@"cityName":@"北京",@"cityPYName":@"Beijing"}]},
                               @{@"C":@[@{@"cityId":@"5",@"cityName":@"成都",@"cityPYName":@"Chengdu"},
                                        @{@"cityId":@"6",@"cityName":@"重庆",@"cityPYName":@"Chongqing"}]},
                               @{@"D":@[@{@"cityId":@"7",@"cityName":@"大连",@"cityPYName":@"Dalian"},
                                        @{@"cityId":@"8",@"cityName":@"大庆",@"cityPYName":@"Daqing"}]},
                               @{@"E":@[@{@"cityId":@"9",@"cityName":@"鄂尔多斯",@"cityPYName":@"Eerduosi"}]},
                               @{@"F":@[@{@"cityId":@"10",@"cityName":@"阜阳",@"cityPYName":@"Fuyang"},
                                        @{@"cityId":@"11",@"cityName":@"佛山",@"cityPYName":@"Foshan"},
                                        @{@"cityId":@"12",@"cityName":@"福州",@"cityPYName":@"Fuzhou"}]},
                               @{@"G":@[@{@"cityId":@"13",@"cityName":@"广州",@"cityPYName":@"Guangzhou"},
                                        @{@"cityId":@"14",@"cityName":@"桂林",@"cityPYName":@"Guilin"}]},
                               @{@"H":@[@{@"cityId":@"15",@"cityName":@"衡阳",@"cityPYName":@"Hengyang"},
                                        @{@"cityId":@"16",@"cityName":@"杭州",@"cityPYName":@"Hangzhou"}]},
                               @{@"J":@[@{@"cityId":@"19",@"cityName":@"济南",@"cityPYName":@"Jinan"},
                                        @{@"cityId":@"20",@"cityName":@"荆州",@"cityPYName":@"Jingzhou"}]},
                               @{@"K":@[@{@"cityId":@"21",@"cityName":@"昆明",@"cityPYName":@"Kunming"},
                                        @{@"cityId":@"22",@"cityName":@"昆山",@"cityPYName":@"Kunshan"}]},
                               @{@"L":@[@{@"cityId":@"23",@"cityName":@"丽江",@"cityPYName":@"Lijiang"},
                                        @{@"cityId":@"24",@"cityName":@"聊城",@"cityPYName":@"Liaocheng"}]},
                               @{@"M":@[@{@"cityId":@"25",@"cityName":@"马鞍山",@"cityPYName":@"Maanshan"},
                                        @{@"cityId":@"26",@"cityName":@"绵阳",@"cityPYName":@"Mianyang"}]},
                               @{@"N":@[@{@"cityId":@"27",@"cityName":@"南昌",@"cityPYName":@"Nanchang"},
                                        @{@"cityId":@"28",@"cityName":@"南阳",@"cityPYName":@"Nanyang"},
                                        @{@"cityId":@"29",@"cityName":@"南通",@"cityPYName":@"Nantong"},
                                        @{@"cityId":@"30",@"cityName":@"内江",@"cityPYName":@"Neijiang"}]},
                               @{@"P":@[@{@"cityId":@"31",@"cityName":@"莆田",@"cityPYName":@"Putian"},
                                        @{@"cityId":@"32",@"cityName":@"攀枝花",@"cityPYName":@"Panzhihua"}]},
                               @{@"Q":@[@{@"cityId":@"33",@"cityName":@"曲靖",@"cityPYName":@"Qujing"},
                                        @{@"cityId":@"34",@"cityName":@"齐齐哈尔",@"cityPYName":@"Qiqihaer"}]},
                               @{@"R":@[@{@"cityId":@"35",@"cityName":@"日照",@"cityPYName":@"Rizhao"}]},
                               @{@"S":@[@{@"cityId":@"36",@"cityName":@"上海市",@"cityPYName":@"Shanghaishi"},
                                        @{@"cityId":@"37",@"cityName":@"商丘",@"cityPYName":@"Shangqiu"},
                                        @{@"cityId":@"38",@"cityName":@"苏州",@"cityPYName":@"Suzhou"}]},
                               @{@"T":@[@{@"cityId":@"39",@"cityName":@"泰安",@"cityPYName":@"Taian"},
                                        @{@"cityId":@"40",@"cityName":@"天津",@"cityPYName":@"Tianjin"},
                                        @{@"cityId":@"41",@"cityName":@"铁岭",@"cityPYName":@"Tieling"},
                                        @{@"cityId":@"42",@"cityName":@"唐山",@"cityPYName":@"Tangshan"},
                                        @{@"cityId":@"43",@"cityName":@"台州",@"cityPYName":@"Taizhou"},
                                        @{@"cityId":@"44",@"cityName":@"太远",@"cityPYName":@"Taiyuan"}]},
                               @{@"W":@[@{@"cityId":@"45",@"cityName":@"乌鲁木齐",@"cityPYName":@"Wulumuqi"},
                                        @{@"cityId":@"46",@"cityName":@"武汉",@"cityPYName":@"Wuhan"}]},
                               @{@"X":@[@{@"cityId":@"47",@"cityName":@"湘潭",@"cityPYName":@"Xiangtan"},
                                        @{@"cityId":@"48",@"cityName":@"襄阳",@"cityPYName":@"Xiangfan"}]},
                               @{@"Y":@[@{@"cityId":@"49",@"cityName":@"盐城",@"cityPYName":@"Yancheng"},
                                        @{@"cityId":@"50",@"cityName":@"义乌",@"cityPYName":@"Yiwu"}]},
                               @{@"Z":@[@{@"cityId":@"51",@"cityName":@"中山",@"cityPYName":@"Zhongshan"},
                                        @{@"cityId":@"52",@"cityName":@"镇江",@"cityPYName":@"Zhenjiang"},
                                        @{@"cityId":@"53",@"cityName":@"珠海",@"cityPYName":@"Zhuhai"},
                                        @{@"cityId":@"54",@"cityName":@"淄博",@"cityPYName":@"Zibo"}]}
                               ];
    

    self.cityInfoDic = [[NSMutableDictionary alloc] init];
    for (NSInteger i = 0; i < cityInfoArr.count; i++) {
        NSDictionary *cityOneDic = [NSDictionary dictionaryWithDictionary:[cityInfoArr objectAtIndex:i]];
        NSArray *keyArr = [cityOneDic allKeys];
        NSArray *cityOneArr = [cityOneDic objectForKey:[keyArr firstObject]];
        
        NSMutableArray *cityModelArr = [[NSMutableArray alloc] init];
        for (NSInteger j = 0; j < cityOneArr.count; j++) {
            NSDictionary *cityInfo = [[NSDictionary alloc] initWithDictionary:[cityOneArr objectAtIndex:j]];
            
            CityInfo *cityInfoModel = [[CityInfo alloc] init];
            cityInfoModel.cityId = [cityInfo objectForKey:@"cityId"];
            cityInfoModel.cityName = [cityInfo objectForKey:@"cityName"];
            cityInfoModel.cityPYName = [cityInfo objectForKey:@"cityPYName"];
            
            [cityModelArr addObject:cityInfoModel];
        }
        
        [self.cityInfoDic setObject:cityModelArr forKey:[keyArr firstObject]];
    }
    
    
    NSLog(@"allCity---->>%@",self.cityInfoDic);

    NSString *plistPath = [self filePathInDocument:@"CityInfo.plist"];
    NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:self.cityInfoDic];
    if (archiveData) {
        [archiveData writeToFile:plistPath options:NSDataWritingAtomic error:nil];
    }
}

- (NSDictionary *)allCityInfo {
    NSString *plistPath = [self filePathInDocument:@"CityInfo.plist"];
    NSDictionary *cityAllInfoDic = [NSKeyedUnarchiver unarchiveObjectWithFile:plistPath];

    NSArray *sortedKeys = [[cityAllInfoDic allKeys] sortedArrayUsingSelector:@selector(compare:)];

    NSMutableDictionary *orderedDic = [[NSMutableDictionary alloc] init];
    for (NSInteger i = 0; i < sortedKeys.count; i++) {
        [orderedDic setObject:[cityAllInfoDic objectForKey:[sortedKeys objectAtIndex:i]] forKey:[sortedKeys objectAtIndex:i]];
    }
    
    return cityAllInfoDic;
}

- (NSArray *)allCitySectionTitles {
    NSString *plistPath = [self filePathInDocument:@"CityInfo.plist"];
    NSDictionary *cityAllInfoDic = [NSKeyedUnarchiver unarchiveObjectWithFile:plistPath];
    
    NSArray *setionTitles = [[cityAllInfoDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    return setionTitles;
}


- (CityInfo *)getCityInfoByCityId:(NSString *)cityId {
    NSArray *cityInfoArr = [self getAllCityInfoArr];
    
    for (NSInteger i = 0; i < cityInfoArr.count; i++) {
        CityInfo *cityInfo = [cityInfoArr objectAtIndex:i];
        
        if ([cityInfo.cityId isEqualToString:cityId]) {
            return cityInfo;
        }
    }
    
    return nil;
}

- (CityInfo *)getCityInfoByCityName:(NSString *)cityName {
    NSArray *cityInfoArr = [self getAllCityInfoArr];
    
    for (NSInteger i = 0; i < cityInfoArr.count; i++) {
        CityInfo *cityInfo = [cityInfoArr objectAtIndex:i];
        
        NSRange range1 = [cityName rangeOfString:cityInfo.cityName];
        NSRange range2 = [cityName rangeOfString:cityInfo.cityPYName];
        
        if (range1.location != NSNotFound || range2.location != NSNotFound) {
            return cityInfo;
        }
    }
    
    return nil;
}

#pragma mark - method
- (NSArray *)getAllCityInfoArr {
    NSString *plistPath = [self filePathInDocument:@"CityInfo.plist"];
    NSDictionary *cityAllInfoDic = [NSKeyedUnarchiver unarchiveObjectWithFile:plistPath];
    
    NSArray *sortedKeys = [[cityAllInfoDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    NSMutableArray *cityInfoArr = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < sortedKeys.count; i++) {
        NSArray *sectionCityArr = [NSArray arrayWithArray:[cityAllInfoDic objectForKey:[sortedKeys objectAtIndex:i]]];
        for (NSInteger j = 0; j < sectionCityArr.count; j++) {
            [cityInfoArr addObject:[sectionCityArr objectAtIndex:j]];
        }
    }

    return [NSArray arrayWithArray:cityInfoArr];
}

-(NSString *)filePathInDocument:(NSString *)fileName {
    NSString *filePath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:fileName];
    return filePath;
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

@end
