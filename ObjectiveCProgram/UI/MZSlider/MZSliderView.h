//
//  MZSliderView.h
//  MZSliderView
//
//  Created by Mr.Z on 2020/5/16.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MZSliderViewDelegate <NSObject>

@optional

/// 滑杆点击
- (void)sliderViewTapped:(CGFloat)value;

/// 滑杆滑动开始
- (void)sliderViewTouchBegan:(CGFloat)value;

/// 滑杆滑动中
- (void)sliderViewValueChanged:(CGFloat)value;

/// 滑杆滑动结束
- (void)sliderViewTouchEnded:(CGFloat)value;

@end

@interface MZSliderView : UIView

/// 代理
@property (nonatomic, weak) id<MZSliderViewDelegate> delegate;

/// 默认滑杆的颜色,默认为grayColor
@property (nonatomic, strong) UIColor *maximumTrackTintColor;

/// 滑杆进度的颜色,默认为whiteColor
@property (nonatomic, strong) UIColor *minimumTrackTintColor;

/// 缓存进度的颜色,默认为lightGrayColor
@property (nonatomic, strong) UIColor *bufferTrackTintColor;

/// loading进度的颜色,默认为whiteColor
@property (nonatomic, strong) UIColor *loadingTrackTintColor;

/// 默认滑杆的图片
@property (nonatomic, strong) UIImage *maximumTrackImage;

/// 滑杆进度的图片
@property (nonatomic, strong) UIImage *minimumTrackImage;

/// 缓存进度的图片
@property (nonatomic, strong) UIImage *bufferTrackImage;

/// 滑杆进度最小值,默认为0.0
@property(nonatomic, assign) CGFloat minimumValue;

/// 滑杆进度最大值,默认为1.0
@property(nonatomic, assign) CGFloat maximumValue;

/// 滑杆进度,默认为0.0
@property (nonatomic, assign) CGFloat value;

/// 缓存进度,默认为0.0
@property (nonatomic, assign) CGFloat bufferValue;

/// 滑杆的高度,默认为1.0
@property (nonatomic, assign) CGFloat sliderHeight;

/// 滑杆的圆角,默认为0.0
@property (nonatomic, assign) CGFloat sliderRadius;

/// 滑块的大小
@property (nonatomic, assign) CGSize thumbSize;

/// 是否隐藏滑块,默认为NO
@property (nonatomic, assign, getter = isHideSliderBtn) BOOL hideSliderBtn;

/// 是否允许点击,默认为YES
@property (nonatomic, assign, getter = isAllowTapped) BOOL allowTapped;

/// 是否允许拖动,默认为YES
@property (nonatomic, assign, getter = isAllowDragged) BOOL allowDragged;

/// 是否动画,默认为YES
@property (nonatomic, assign, getter = isAnimated) BOOL animated;

/// 是否正在拖动
@property (nonatomic, assign, readonly) BOOL isDragging;

/// 向前还是向后拖动
@property (nonatomic, assign, readonly) BOOL isDragForward;

/// 开始加载动画
- (void)startLoadAnimating;

/// 结束加载动画
- (void)stopLoadAnimating;

/// 设置滑块的背景图片
/// @param image 图片
/// @param state 按钮状态
- (void)setThumbBackgroundImage:(UIImage *)image forState:(UIControlState)state;

/// 设置滑块图片
/// @param image  图片
/// @param state 按钮状态
- (void)setThumbImage:(UIImage *)image forState:(UIControlState)state;

@end

NS_ASSUME_NONNULL_END
