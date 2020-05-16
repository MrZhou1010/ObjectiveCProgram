//
//  MZCodeVC.m
//  ObjectiveCProgram
//
//  Created by Mr.Z on 2020/5/14.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

#import "MZCodeVC.h"
#import "MyQRCodeVC.h"
#import "MZCode.h"

@interface MZCodeVC ()

@property (nonatomic, strong) MZCodeScanView *scanView;
@property (nonatomic, strong) MZCodeScanTool *scanTool;

@end

@implementation MZCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"二维码扫描";
    [self setupUI];
}

- (void)setupUI {
    UIView *preview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:preview];
    // 构建扫描样式视图
    self.scanView = [[MZCodeScanView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.scanView.backgroundColor = UIColor.clearColor;
    self.scanView.scanRect = CGRectMake(80, 180, (self.view.frame.size.width - 2 * 80),  (self.view.frame.size.width - 2 * 80));
    self.scanView.angleColor = [UIColor blueColor];
    self.scanView.isShowBorder = NO;
    self.scanView.borderColor = [UIColor whiteColor];
    self.scanView.notRecoginitonAreaColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.scanView.animationImage = [UIImage imageNamed:@"MZCode.bundle/scanLine"];
    self.scanView.isShowMyCode = YES;
    self.scanView.tipDescription = @"将二维码放于框内\n即可自动扫描";
    [self.view addSubview:self.scanView];
    __weak typeof(self) weakSelf = self;
    self.scanView.codeScanBlock = ^{
        MyQRCodeVC *myQRCodeVC = [[MyQRCodeVC alloc] init];
        [weakSelf.navigationController pushViewController:myQRCodeVC animated:YES];
    };
    self.scanTool = [[MZCodeScanTool alloc] initWithPreview:preview andScanFrame:self.scanView.scanRect];
    self.scanTool.scanFinishedBlock = ^(NSString *scanString) {
        NSLog(@"扫描结果 %@", scanString);
        [weakSelf.scanTool sessionStopRunning];
    };
    self.scanTool.monitorLightBlock = ^(float brightness) {
        NSLog(@"当前亮度 %lf", brightness);
        if (brightness < -2.0) {
            // 环境太暗，显示闪光灯开关按钮
            [weakSelf.scanView showFlashSwitch:YES];
        } else if (brightness > 0) {
            // 环境亮度可以,且闪光灯处于关闭状态时，隐藏闪光灯开关
            if(weakSelf.scanView.flashOpen) {
                [weakSelf.scanView showFlashSwitch:NO];
            }
        }
    };
    [self.scanTool sessionStartRunning];
    [self.scanView startScanAnimation];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.scanTool sessionStopRunning];
}

@end