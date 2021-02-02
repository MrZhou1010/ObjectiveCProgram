//
//  MZSliderVC.m
//  ObjectiveCProgram
//
//  Created by Mr.Z on 2020/5/16.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

#import "MZSliderVC.h"
#import "MZSliderView.h"
#import "UIView+MZFrameExtension.h"

@interface MZSliderVC () <MZSliderViewDelegate>

@property (nonatomic, strong) MZSliderView *sliderView;

@property (nonatomic, strong) UILabel *valueLabel;

@end

@implementation MZSliderVC

#pragma mark - lazy
- (MZSliderView *)sliderView {
    if (!_sliderView) {
        _sliderView = [[MZSliderView alloc] initWithFrame:CGRectZero];
        _sliderView.delegate = self;
        _sliderView.maximumTrackTintColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5];
        _sliderView.minimumTrackTintColor = [[UIColor greenColor] colorWithAlphaComponent:0.5];
        _sliderView.bufferTrackTintColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
        _sliderView.loadingTrackTintColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
        _sliderView.minimumValue = 10.0;
        _sliderView.maximumValue = 20.0;
        _sliderView.value = 12.3;
        _sliderView.bufferValue = 17.6;
        _sliderView.sliderHeight = 2.0;
        _sliderView.sliderRadius = 1.0;
        _sliderView.thumbSize = CGSizeMake(20.0, 20.0);
        [_sliderView setThumbImage:[UIImage imageNamed:@"icon_photograph"] forState:UIControlStateNormal];
    }
    return _sliderView;
}

- (UILabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _valueLabel.textColor = [UIColor orangeColor];
        _valueLabel.font = [UIFont systemFontOfSize:16];
        _valueLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _valueLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.title = @"自定义Slider";
    [self setupUI];
}

- (void)setupUI {
    self.valueLabel.text = [NSString stringWithFormat:@"%.1lf", self.sliderView.value];
    self.valueLabel.frame = CGRectMake(0, 120.0, 100.0, 30.0);
    self.sliderView.frame = CGRectMake(20.0, 180.0, self.view.bounds.size.width - 40.0, 20.0);
    self.valueLabel.centerX = self.sliderView.width * (self.sliderView.value - self.sliderView.minimumValue) / (self.sliderView.maximumValue - self.sliderView.minimumValue) + self.sliderView.left;
    [self.view addSubview:self.valueLabel];
    [self.view addSubview:self.sliderView];
    [self.sliderView startLoadAnimating];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.sliderView stopLoadAnimating];
    });
}

#pragma mark - MZSliderViewDelegate
/// 滑杆点击
- (void)sliderViewTapped:(CGFloat)value {
    NSLog(@"点击:%.2lf", value);
    self.valueLabel.text = [NSString stringWithFormat:@"%.1lf", value];
    self.valueLabel.centerX = self.sliderView.width * (self.sliderView.value - self.sliderView.minimumValue) / (self.sliderView.maximumValue - self.sliderView.minimumValue) + self.sliderView.left;
}

/// 滑杆滑动开始
- (void)sliderViewTouchBegan:(CGFloat)value {
    NSLog(@"滑杆滑动开始:%.2lf", value);
}

/// 滑杆滑动中
- (void)sliderViewValueChanged:(CGFloat)value {
    NSLog(@"滑杆滑动中:%.2lf", value);
    self.valueLabel.text = [NSString stringWithFormat:@"%.1lf", value];
    self.valueLabel.centerX = self.sliderView.width * (self.sliderView.value - self.sliderView.minimumValue) / (self.sliderView.maximumValue - self.sliderView.minimumValue) + self.sliderView.left;
}

/// 滑杆滑动结束
- (void)sliderViewTouchEnded:(CGFloat)value {
    NSLog(@"滑杆滑动结束:%.2lf", value);
}

@end
