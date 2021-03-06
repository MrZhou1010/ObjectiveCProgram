//
//  MZListMenuVC.m
//  ObjectiveCProgram
//
//  Created by Mr.Z on 2020/5/16.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

#import "MZListMenuVC.h"
#import "MZListMenuTableVC.h"
#import "UIView+MZListMenu.h"
#import "UIBarButtonItem+MZListMenu.h"
#import "MZListMenuConfiguration.h"

@interface MZListMenuVC ()

@end

@implementation MZListMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"带三角的弹框选择视图";
    [self setupUI];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MZListMenu dismissListMenuInView:self.view isAnimation:NO];
}

- (void)setupUI {
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(showMenu:)];
    leftItem.tag = 101;
    self.navigationItem.leftBarButtonItem = leftItem;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showMenu:)];
    rightItem.tag = 102;
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(10.0, 120.0, 60.0, 30.0);
    btn1.tag = 11;
    btn1.backgroundColor = [UIColor redColor];
    [btn1 setTitle:@"view1" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(155.0, 120.0, 60.0, 30.0);
    btn2.tag = 11;
    btn2.backgroundColor = [UIColor redColor];
    [btn2 setTitle:@"view2" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(305.0, 120.0, 60.0, 30.0);
    btn3.tag = 11;
    btn3.backgroundColor = [UIColor redColor];
    [btn3 setTitle:@"view3" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(100.0, 200.0, 60.0, 30.0);
    btn4.tag = 22;
    btn4.backgroundColor = [UIColor redColor];
    [btn4 setTitle:@"cell" forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
}

- (void)showMenu:(id)sender {
    UIBarButtonItem *item = (UIBarButtonItem *)sender;
    NSArray *imageArr = @[@"icon_swap", @"icon_photograph", @"icon_code"];
    NSArray *titleArr = @[@"扫一扫", @"拍\t照", @"付款码"];
    MZListMenuConfiguration *configuration = [MZListMenuConfiguration defaultConfiguration];
    configuration.menuType = item.tag == 101 ? MZListMenuTypeLeftNavBar: MZListMenuTypeRightNavBar;
    [item mz_showMenuWithImages:imageArr titles:titleArr currentNav:self.navigationController configuration:configuration itemClickBlock:^(NSInteger index) {
        [self showMessage:index];
    }];
}

- (void)btnAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 11) {
        NSArray *imageArr = @[@"icon_swap", @"icon_photograph", @"icon_code"];
        NSArray *titleArr = @[@"扫一扫", @"拍\t照", @"付款码"];
        [btn mz_showMenuWithImages:imageArr titles:titleArr configuration:[MZListMenuConfiguration defaultConfiguration] itemClickBlock:^(NSInteger index) {
            [self showMessage:index];
        }];
    } else {
        [self.navigationController pushViewController:[[MZListMenuTableVC alloc] init] animated:YES];
    }
}

- (void)showMessage:(NSInteger)index {
    switch (index) {
        case 0: {
            [self showAlertMessage:@"扫一扫"];
        }
            break;
        case 1: {
            [self showAlertMessage:@"拍照"];
        }
            break;
        case 2: {
            [self showAlertMessage:@"付款码"];
        }
            break;
        default:
            break;
    }
}

- (void)showAlertMessage:(NSString *)message {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
