//
//  MZSliderView.m
//  MZSliderView
//
//  Created by Mr.Z on 2020/5/16.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

#import "MZSliderView.h"
#import "UIView+MZFrameExtension.h"

/// 滑块的扩距
static const CGFloat kSliderButtonInset = 20.0;
/// 滑块的宽度
static const CGFloat kSliderButtonWidth = 10.0;
/// 滑块的高度
static const CGFloat kSliderButtonHeight = 10.0;

@interface MZSliderButton : UIButton

@end

@implementation MZSliderButton

/// 重写此方法扩大按钮的点击范围
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL result = [super pointInside:point withEvent:event];
    if (!result) {
        CGRect bounds = self.bounds;
        bounds = CGRectInset(bounds, -kSliderButtonInset, -kSliderButtonInset);
        return CGRectContainsPoint(bounds, point);
    }
    return result;
}

@end

@interface MZSliderView ()

/// 滑块
@property (nonatomic, strong) MZSliderButton *sliderBtn;
/// 滑杆背景
@property (nonatomic, strong) UIImageView *progressView;
/// 滑杆进度背景
@property (nonatomic, strong) UIImageView *sliderProgressView;
/// 缓存进度背景
@property (nonatomic, strong) UIImageView *bufferProgressView;
/// 加载视图
@property (nonatomic, strong) UIView *loadingView;
/// 是否在加载中
@property (nonatomic, assign) BOOL isLoading;
/// 点击手势
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
/// 拖动手势
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
/// 是否正在拖动
@property (nonatomic, assign, readwrite) BOOL isDragging;
/// 向前还是向后拖动
@property (nonatomic, assign, readwrite) BOOL isDragForward;

@end

@implementation MZSliderView

#pragma mark - lazy
- (UIImageView *)progressView {
    if (!_progressView) {
        _progressView = [[UIImageView alloc] init];
        _progressView.backgroundColor = [UIColor grayColor];
        _progressView.contentMode = UIViewContentModeScaleAspectFill;
        _progressView.clipsToBounds = YES;
    }
    return _progressView;
}

- (UIImageView *)sliderProgressView {
    if (!_sliderProgressView) {
        _sliderProgressView = [UIImageView new];
        _sliderProgressView.backgroundColor = [UIColor whiteColor];
        _sliderProgressView.contentMode = UIViewContentModeScaleAspectFill;
        _sliderProgressView.clipsToBounds = YES;
    }
    return _sliderProgressView;
}

- (UIImageView *)bufferProgressView {
    if (!_bufferProgressView) {
        _bufferProgressView = [[UIImageView alloc] init];
        _bufferProgressView.backgroundColor = [UIColor lightGrayColor];
        _bufferProgressView.contentMode = UIViewContentModeScaleAspectFill;
        _bufferProgressView.clipsToBounds = YES;
    }
    return _bufferProgressView;
}

- (MZSliderButton *)sliderBtn {
    if (!_sliderBtn) {
        _sliderBtn = [MZSliderButton buttonWithType:UIButtonTypeCustom];
        _sliderBtn.adjustsImageWhenHighlighted = NO;
    }
    return _sliderBtn;
}

- (UIView *)loadingView {
    if (!_loadingView) {
        _loadingView = [[UIView alloc] init];
        _loadingView.backgroundColor = [UIColor whiteColor];
        _loadingView.hidden = YES;
    }
    return _loadingView;
}

- (void)setMaximumTrackTintColor:(UIColor *)maximumTrackTintColor {
    _maximumTrackTintColor = maximumTrackTintColor;
    self.progressView.backgroundColor = maximumTrackTintColor;
}

- (void)setMinimumTrackTintColor:(UIColor *)minimumTrackTintColor {
    _minimumTrackTintColor = minimumTrackTintColor;
    self.sliderProgressView.backgroundColor = minimumTrackTintColor;
}

- (void)setBufferTrackTintColor:(UIColor *)bufferTrackTintColor {
    _bufferTrackTintColor = bufferTrackTintColor;
    self.bufferProgressView.backgroundColor = bufferTrackTintColor;
}

- (void)setLoadingTrackTintColor:(UIColor *)loadingTrackTintColor {
    _loadingTrackTintColor = loadingTrackTintColor;
    self.loadingView.backgroundColor = loadingTrackTintColor;
}

- (void)setMaximumTrackImage:(UIImage *)maximumTrackImage {
    _maximumTrackImage = maximumTrackImage;
    self.progressView.image = maximumTrackImage;
    self.maximumTrackTintColor = [UIColor clearColor];
}

- (void)setMinimumTrackImage:(UIImage *)minimumTrackImage {
    _minimumTrackImage = minimumTrackImage;
    self.sliderProgressView.image = minimumTrackImage;
    self.minimumTrackTintColor = [UIColor clearColor];
}

- (void)setBufferTrackImage:(UIImage *)bufferTrackImage {
    _bufferTrackImage = bufferTrackImage;
    self.bufferProgressView.image = bufferTrackImage;
    self.bufferTrackTintColor = [UIColor clearColor];
}

- (void)setThumbBackgroundImage:(UIImage *)image forState:(UIControlState)state {
    [self.sliderBtn setBackgroundImage:image forState:state];
}

- (void)setThumbImage:(UIImage *)image forState:(UIControlState)state {
    [self.sliderBtn setImage:image forState:state];
}

- (void)setMinimumValue:(CGFloat)minimumValue {
    _minimumValue = isnan(minimumValue) || minimumValue < 0.0 ? 0.0 : minimumValue;
}

- (void)setMaximumValue:(CGFloat)maximumValue {
    _maximumValue = isnan(maximumValue) || maximumValue < 0.0 ? 1.0 : maximumValue;
}

- (void)setValue:(CGFloat)value {
    if (isnan(value) || (self.maximumValue - self.minimumValue) <= 0.0) {
        return;
    }
    value = MAX(self.minimumValue, value);
    value = MIN(self.maximumValue, value);
    _value = value;
    if (self.sliderBtn.hidden) {
        self.sliderProgressView.width = self.progressView.width * (value - self.minimumValue) / (self.maximumValue - self.minimumValue);
    } else {
        self.sliderBtn.centerX = self.progressView.width * (value - self.minimumValue) / (self.maximumValue - self.minimumValue);
        self.sliderProgressView.width = self.sliderBtn.centerX;
    }
}

- (void)setBufferValue:(CGFloat)bufferValue {
    if (isnan(bufferValue) || (self.maximumValue - self.minimumValue) <= 0.0) {
        return;
    }
    bufferValue = MAX(self.minimumValue, bufferValue);
    bufferValue = MIN(self.maximumValue, bufferValue);
    _bufferValue = bufferValue;
    self.bufferProgressView.width = self.progressView.width * (bufferValue - self.minimumValue) / (self.maximumValue - self.minimumValue);
}

- (void)setSliderHeight:(CGFloat)sliderHeight {
    if (isnan(sliderHeight)) {
        return;
    }
    _sliderHeight = MAX(1.0, sliderHeight);
    self.progressView.height = sliderHeight;
    self.sliderProgressView.height = sliderHeight;
    self.bufferProgressView.height = sliderHeight;
}

- (void)setSliderRadius:(CGFloat)sliderRadius {
    if (isnan(sliderRadius) || sliderRadius <= 0.0) {
        return;
    }
    _sliderRadius = sliderRadius;
    [self.progressView setRound:sliderRadius];
    [self.sliderProgressView setRound:sliderRadius];
    [self.bufferProgressView setRound:sliderRadius];
}

- (void)setAllowTapped:(BOOL)allowTapped {
    _allowTapped = allowTapped;
    if (!allowTapped) {
        [self removeGestureRecognizer:self.tapGesture];
    }
}

- (void)setAllowDragged:(BOOL)allowDragged {
    _allowDragged = allowDragged;
    if (!allowDragged) {
        [self removeGestureRecognizer:self.panGesture];
    }
}

- (void)setHideSliderBtn:(BOOL)hideSliderBtn {
    _hideSliderBtn = hideSliderBtn;
    // 隐藏滑块,滑杆不可点击
    if (hideSliderBtn) {
        self.sliderBtn.hidden = YES;
        self.progressView.left = 0.0;
        self.sliderProgressView.left = 0.0;
        self.bufferProgressView.left = 0.0;
        self.allowTapped = NO;
        self.allowDragged = NO;
    }
}

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self defaultConfiguration];
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self defaultConfiguration];
    [self setupUI];
}

- (void)defaultConfiguration {
    self.value = 0.0;
    self.bufferValue = 0.0;
    self.minimumValue = 0.0;
    self.maximumValue = 1.0;
    self.sliderHeight = 1.0;
    self.sliderRadius = 0.0;
    self.hideSliderBtn = NO;
    self.allowTapped = YES;
    self.allowDragged = YES;
    self.animated = YES;
    self.thumbSize = CGSizeMake(kSliderButtonWidth, kSliderButtonHeight);
}

- (void)setupUI {
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.progressView];
    [self addSubview:self.bufferProgressView];
    [self addSubview:self.sliderProgressView];
    [self addSubview:self.sliderBtn];
    [self addSubview:self.loadingView];
    // 添加点击手势
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self addGestureRecognizer:self.tapGesture];
    // 添加滑动手势
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragged:)];
    [self addGestureRecognizer:self.panGesture];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (isnan(self.value) || isnan(self.bufferValue) || (self.maximumValue - self.minimumValue) <= 0.0) {
        return;
    }
    self.progressView.frame = CGRectMake(0, 0, self.width, self.sliderHeight);
    self.sliderBtn.frame = CGRectMake(0, 0, self.thumbSize.width, self.thumbSize.height);
    self.sliderBtn.centerX = self.progressView.width * (self.value - self.minimumValue) / (self.maximumValue - self.minimumValue);
    CGFloat sliderProgressWidth = self.sliderBtn.hidden ? self.progressView.width * (self.value - self.minimumValue) / (self.maximumValue - self.minimumValue) : self.sliderBtn.centerX;
    self.sliderProgressView.frame = CGRectMake(0, 0, sliderProgressWidth, self.sliderHeight);
    self.bufferProgressView.frame = CGRectMake(0, 0, self.progressView.width * (self.bufferValue - self.minimumValue) / (self.maximumValue - self.minimumValue), self.sliderHeight);
    self.loadingView.frame = CGRectMake((self.width - 0.1) * 0.5, (self.height - MIN(self.sliderHeight, 2.0)) * 0.5, 0.1, MIN(self.sliderHeight, 2.0));
    self.progressView.centerY = self.height * 0.5;
    self.sliderBtn.centerY = self.height * 0.5;
    self.sliderProgressView.centerY = self.height * 0.5;
    self.bufferProgressView.centerY = self.height * 0.5;
}

#pragma mark - loadAnimating
- (void)startLoadAnimating {
    if (self.isLoading) {
        return;
    }
    self.isLoading = YES;
    self.bufferProgressView.hidden = YES;
    self.sliderProgressView.hidden = YES;
    self.sliderBtn.hidden = YES;
    self.loadingView.hidden = NO;
    [self.loadingView.layer removeAllAnimations];
    [self.loadingView.layer addAnimation:[self createAnimation] forKey:@"loading"];
}

- (CAAnimationGroup *)createAnimation {
    CAAnimationGroup *animationGroup = [[CAAnimationGroup alloc] init];
    animationGroup.duration = 0.4;
    animationGroup.beginTime = CACurrentMediaTime() + 0.4;
    animationGroup.repeatCount = MAXFLOAT;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    CABasicAnimation *scaleAnimation = [CABasicAnimation animation];
    scaleAnimation.keyPath = @"transform.scale.x";
    scaleAnimation.fromValue = @(1000.0f);
    scaleAnimation.toValue = @(self.width * 10.0f);
    CABasicAnimation *alphaAnimation = [CABasicAnimation animation];
    alphaAnimation.keyPath = @"opacity";
    alphaAnimation.fromValue = @(1.0f);
    alphaAnimation.toValue = @(0.0f);
    [animationGroup setAnimations:@[scaleAnimation, alphaAnimation]];
    return animationGroup;
}

- (void)stopLoadAnimating {
    self.isLoading = NO;
    self.bufferProgressView.hidden = NO;
    self.sliderProgressView.hidden = NO;
    self.sliderBtn.hidden = self.hideSliderBtn;
    self.loadingView.hidden = YES;
    [self.loadingView.layer removeAllAnimations];
}

#pragma mark - gesture action
- (void)tapped:(UITapGestureRecognizer *)tap {
    CGPoint point = [tap locationInView:self.progressView];
    // 获取进度
    CGFloat value = (point.x - self.sliderBtn.width * 0.5) * (self.maximumValue - self.minimumValue) / self.progressView.width + self.minimumValue;
    value = MAX(self.minimumValue, value);
    value = MIN(self.maximumValue, value);
    self.value = value;
    if ([self.delegate respondsToSelector:@selector(sliderViewTapped:)]) {
        [self.delegate sliderViewTapped:value];
    }
}

- (void)dragged:(UIPanGestureRecognizer *)pan {
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: {
            [self sliderTouchBegan:self.sliderBtn];
        }
            break;
        case UIGestureRecognizerStateChanged: {
            [self sliderDragMoving:self.sliderBtn point:[pan locationInView:self.progressView]];
        }
            break;
        case UIGestureRecognizerStateEnded: {
            [self sliderTouchEnded:self.sliderBtn];
        }
            break;
        default:
            break;
    }
}

- (void)sliderTouchBegan:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(sliderViewTouchBegan:)]) {
        [self.delegate sliderViewTouchBegan:self.value];
    }
    if (self.animated) {
        [UIView animateWithDuration:0.2 animations:^{
            btn.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
        }];
    }
}

- (void)sliderTouchEnded:(UIButton *)btn {
    self.isDragging = NO;
    if ([self.delegate respondsToSelector:@selector(sliderViewTouchEnded:)]) {
        [self.delegate sliderViewTouchEnded:self.value];
    }
    if (self.animated) {
        [UIView animateWithDuration:0.2 animations:^{
            btn.transform = CGAffineTransformIdentity;
        }];
    }
}

- (void)sliderDragMoving:(UIButton *)btn point:(CGPoint)touchPoint {
    // 获取进度值
    CGFloat value = (touchPoint.x - btn.width * 0.5) * (self.maximumValue - self.minimumValue) / self.progressView.width + self.minimumValue;
    value = MAX(self.minimumValue, value);
    value = MIN(self.maximumValue, value);
    if (self.value == value) {
        return;
    }
    self.isDragging = YES;
    self.isDragForward = self.value < value;
    self.value = value;
    if ([self.delegate respondsToSelector:@selector(sliderViewValueChanged:)]) {
        [self.delegate sliderViewValueChanged:value];
    }
}

@end
