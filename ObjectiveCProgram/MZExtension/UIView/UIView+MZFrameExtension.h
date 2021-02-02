//
//  UIView+MZFrameExtension.h
//  MZExtension
//
//  Created by Mr.Z on 2020/5/14.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (MZFrameExtension)

/// 控件起点
@property (nonatomic, assign) CGPoint origin;

/// 控件大小
@property (nonatomic, assign) CGSize size;

/// 控件起点X
@property (nonatomic, assign) CGFloat x;

/// 控件起点Y
@property (nonatomic, assign) CGFloat y;

/// 控件宽
@property (nonatomic, assign) CGFloat width;

/// 控件高
@property (nonatomic, assign) CGFloat height;

/// 控件顶部
@property (nonatomic, assign) CGFloat top;

/// 控件底部
@property (nonatomic, assign) CGFloat bottom;

/// 控件左边
@property (nonatomic, assign) CGFloat left;

/// 控件右边
@property (nonatomic, assign) CGFloat right;

/// 控件中心点X
@property (nonatomic, assign) CGFloat centerX;

/// 控件中心点Y
@property (nonatomic, assign) CGFloat centerY;

/// 控件左上
@property(nonatomic, assign, readonly) CGPoint topLeft;

/// 控件右上
@property(nonatomic, assign, readonly) CGPoint topRight;

/// 控件左下
@property(nonatomic, assign, readonly) CGPoint bottomLeft;

/// 控件右下
@property(nonatomic, assign, readonly) CGPoint bottomRight;

/// 屏幕中心点X
@property (nonatomic, assign, readonly) CGFloat middleX;

/// 屏幕中心点Y
@property (nonatomic, assign, readonly) CGFloat middleY;

/// 屏幕中心点
@property (nonatomic, assign, readonly) CGPoint middlePoint;

/// 设置上边圆角
/// @param corner 圆角
- (void)setCornerOnTop:(CGFloat)corner;

/// 设置下边圆角
/// @param corner 圆角
- (void)setCornerOnBottom:(CGFloat)corner;

/// 设置左边圆角
/// @param corner 圆角
- (void)setCornerOnLeft:(CGFloat)corner;

/// 设置右边圆角
/// @param corner 圆角
- (void)setCornerOnRight:(CGFloat)corner;

/// 设置左上圆角
/// @param corner 圆角
- (void)setCornerOnTopLeft:(CGFloat)corner;

/// 设置右上圆角
/// @param corner 圆角
- (void)setCornerOnTopRight:(CGFloat)corner;

/// 设置左下圆角
/// @param corner 圆角
- (void)setCornerOnBottomLeft:(CGFloat)corner;

/// 设置右下圆角
/// @param corner 圆角
- (void)setCornerOnBottomRight:(CGFloat)corner;

/// 设置所有圆角
/// @param corner 圆角
- (void)setAllCorner:(CGFloat)corner;

/// 设置圆角
/// @param cornerRadius 圆角
- (void)setRound:(CGFloat)cornerRadius;

/// 设置边框
/// @param borderWidth 边框宽
/// @param borderColor 边框颜色
- (void)setBorder:(CGFloat)borderWidth color:(UIColor *)borderColor;

/// 设置圆角和边框
/// @param cornerRadius 圆角
/// @param borderWidth 边框宽
/// @param borderColor 边框颜色
- (void)setRound:(CGFloat)cornerRadius width:(CGFloat)borderWidth color:(UIColor * __nullable)borderColor;

/// 设置阴影
/// @param shadowColor 阴影颜色
/// @param opacity 透明度
/// @param radius 圆角
/// @param offset 偏移量
- (void)setShadow:(UIColor * __nullable)shadowColor opacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset;

@end

NS_ASSUME_NONNULL_END
