//
//  ViewController.m
//  ObjectiveCProgram
//
//  Created by Mr.Z on 2020/5/14.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

#import "ViewController.h"
#import "MZCodeVC.h"
#import "MZVersionControlVC.h"
#import "MZPageControlVC.h"
#import "MZToastVC.h"
#import "MZAuthenticationVC.h"
#import "MZRadarChartVC.h"
#import "MZListMenuVC.h"
#import "MZSliderVC.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataSource;

@end

@implementation ViewController

#pragma mark - lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[@"二维码扫描及生成",
                        @"版本控制（版本检测、版本更新）",
                        @"自定义PageControl",
                        @"提示框相关",
                        @"身份认证(指纹、面容)",
                        @"雷达图表",
                        @"带三角的弹框选择视图",
                        @"自定义Slider"];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"ObjectiveCProgram";
    [self setupUI];
}

- (void)setupUI {
    self.tableView.frame = self.view.bounds;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentifier"];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        MZCodeVC *codeVC = [[MZCodeVC alloc] init];
        [self.navigationController pushViewController:codeVC animated:YES];
    } else if (indexPath.row == 1) {
        MZVersionControlVC *codeVC = [[MZVersionControlVC alloc] init];
        [self.navigationController pushViewController:codeVC animated:YES];
    } else if (indexPath.row == 2) {
        MZPageControlVC *codeVC = [[MZPageControlVC alloc] init];
        [self.navigationController pushViewController:codeVC animated:YES];
    } else if (indexPath.row == 3) {
        MZToastVC *codeVC = [[MZToastVC alloc] init];
        [self.navigationController pushViewController:codeVC animated:YES];
    } else if (indexPath.row == 4) {
        MZAuthenticationVC *codeVC = [[MZAuthenticationVC alloc] init];
        [self.navigationController pushViewController:codeVC animated:YES];
    } else if (indexPath.row == 5) {
        MZRadarChartVC *codeVC = [[MZRadarChartVC alloc] init];
        [self.navigationController pushViewController:codeVC animated:YES];
    } else if (indexPath.row == 6) {
        MZListMenuVC *codeVC = [[MZListMenuVC alloc] init];
        [self.navigationController pushViewController:codeVC animated:YES];
    } else if (indexPath.row == 7) {
        MZSliderVC *sliderVC = [[MZSliderVC alloc] init];
        [self.navigationController pushViewController:sliderVC animated:YES];
    }
}

@end
