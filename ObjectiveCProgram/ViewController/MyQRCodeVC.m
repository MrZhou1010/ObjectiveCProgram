//
//  MyQRCodeVC.m
//  ObjectiveCProgram
//
//  Created by Mr.Z on 2020/5/14.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

#import "MyQRCodeVC.h"
#import "MZCodeScanTool.h"

@interface MyQRCodeVC ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation MyQRCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"二维码生成";
    [self setupUI];
}

- (void)setupUI {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(16, 150, self.view.frame.size.width - 32, 400)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 5;
    bgView.layer.masksToBounds = YES;
    [self.view addSubview:bgView];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 20, CGRectGetWidth(bgView.frame) - 60, 300)];
    NSString *myInfo = @"this is a test!";
    imageView.image = [MZCodeScanTool createQRCodeImageWithString:myInfo andSize:CGSizeMake(CGRectGetWidth(bgView.frame) - 60, 300) andBackColor:[UIColor whiteColor] andFrontColor:[UIColor blackColor] andCenterImage:[UIImage imageNamed:@"MZCode.bundle/scanFlashlight"]];
    [bgView addSubview:imageView];
    self.imageView = imageView;
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 350, CGRectGetWidth(bgView.frame), 50)];
    titleLab.text = @"扫一扫上面的二维码图案添加好友！";
    titleLab.textColor = [UIColor blackColor];
    titleLab.font =[UIFont systemFontOfSize:15];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:titleLab];
}

@end
