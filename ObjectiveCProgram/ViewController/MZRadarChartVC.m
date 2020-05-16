//
//  MZRadarChartVC.m
//  ObjectiveCProgram
//
//  Created by Mr.Z on 2020/5/16.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

#import "MZRadarChartVC.h"
#import "MZRadarChartView.h"
#import "MZRadarChartConfiguration.h"

@interface MZRadarChartVC ()

@end

@implementation MZRadarChartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"雷达图表";
    [self setupUI];
}

- (void)setupUI {
    MZRadarChartConfiguration *configuration = [MZRadarChartConfiguration defaultConfiguration];
    MZRadarChartView *radarChartView = [[MZRadarChartView alloc] initWithFrame:CGRectMake(56, 200, 260, 260) configuration:configuration];
    [self.view addSubview:radarChartView];
    [radarChartView showDescriptions:@[@"智力", @"力量", @"敏捷", @"健康", @"体质"]];
    [radarChartView showValues:@[@(50), @(80), @(77), @(55), @(60)] fillColor:[[UIColor greenColor] colorWithAlphaComponent:0.5]];
    [radarChartView showValues:@[@(90), @(30), @(81), @(76), @(43)] fillColor:[[UIColor blueColor] colorWithAlphaComponent:0.3]];
}

@end
