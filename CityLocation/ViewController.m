//
//  ViewController.m
//  CityLocation
//
//  Created by xiazer on 15/5/12.
//  Copyright (c) 2015年 xiazer. All rights reserved.
//

#import "ViewController.h"
#import "CityLocationManager.h"
#import "CityInfo.h"
#import "CityLocation.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableList;
@property (nonatomic, strong) NSMutableDictionary *cityInfoDic;
@property (nonatomic, strong) NSMutableArray *sectionTitlesArr;
@property (nonatomic, strong) CityLocation *cityLocation;
@property (nonatomic, assign) CityLocationStatus cityLocationStatus;
@property (nonatomic, strong) CityInfo *cityInfo;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initTable];
    
    [self startLocation];
}

- (void)initData {
    self.cityLocationStatus = CityLocationForIng;
    self.sectionTitlesArr = [NSMutableArray arrayWithArray:[[CityLocationManager shareInstance] allCitySectionTitles]];
    self.cityInfoDic = [NSMutableDictionary dictionaryWithDictionary:[[CityLocationManager shareInstance] allCityInfo]];
}

- (void)initTable {
    self.title = @"城市定位和选择";
    
    [self.view addSubview:self.tableList];
}

- (void)startLocation {
    __weak typeof(self) this = self;
    [self.cityLocation locationForCityInfo:^(CityLocationStatus status, CityInfo *cityInfo) {
        NSLog(@"status--->>%ld",(long)status);
        if (status != this.cityLocationStatus) {
            this.cityLocationStatus = status;
            this.cityInfo = cityInfo;
            [this.tableList reloadData];
        }
    }];
}

#pragma makr  - UITableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionTitlesArr.count + 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"";
    }
    
    return [self.sectionTitlesArr objectAtIndex:section-1];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    
    NSArray *cityArr = [self.cityInfoDic objectForKey:[self.sectionTitlesArr objectAtIndex:section-1]];
    return cityArr.count;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.sectionTitlesArr;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
    }
    
    if (indexPath.section == 0) {
        if (self.cityLocationStatus == CityLocationForIng) {
            cell.textLabel.text = @"正在查找...";
        } else if (self.cityLocationStatus == CityLocationForSuccussWithCityInfo) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@",self.cityInfo.cityName];
        } else if (self.cityLocationStatus == CityLocationForSuccussWithoutCityInfo) {
            cell.textLabel.text = @"你不在当前城市列表";
        } else if (self.cityLocationStatus == CityLocationForFailForNoPermission) {
            cell.textLabel.text = @"请打开地理位置权限";
        } else if (self.cityLocationStatus == CityLocationForFailForNoNet) {
            cell.textLabel.text = @"定位失败，请重试";
        }
    } else {
        NSArray *cityArr = [self.cityInfoDic objectForKey:[self.sectionTitlesArr objectAtIndex:indexPath.section-1]];
        CityInfo *cityInfo = (CityInfo *)[cityArr objectAtIndex:indexPath.row];
        cell.textLabel.text = cityInfo.cityName;
    }
    
    return cell;
}


#pragma makr  - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    self.cityLocationStatus = CityLocationForIng;
    [tableView reloadData];
    [self.cityLocation restartLocation];

//    if (indexPath.section == 0) {
//        if (self.cityLocationStatus != CityLocationForSuccussWithCityInfo) {
//            [self.cityLocation restartLocation];
//        }
//    }
}

#pragma mark - get method
- (UITableView *)tableList {
    if (!_tableList) {
        _tableList = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableList.sectionIndexColor = [UIColor redColor];
        _tableList.dataSource = self;
        _tableList.delegate = self;
    }
    
    return _tableList;
};

- (CityLocation *)cityLocation {
    if (!_cityLocation) {
        _cityLocation = [[CityLocation alloc] init];
    }
    
    return _cityLocation;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
