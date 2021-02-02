//
//  UIFont+MZFitDevice.h
//  MZExtension
//
//  Created by Mr.Z on 2020/5/14.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (MZFitDevice)

/// 根据不同的屏幕设置不同字号大小
/// @param fontSize 原来的字号大小
+ (CGFloat)updateFontSize:(CGFloat)fontSize;

/// 根据不同的屏幕设置不同字号
/// @param fontSize 原来的字号大小
+ (UIFont *)fontSize:(CGFloat)fontSize;

/// 根据不同的屏幕设置不同加粗字号
/// @param fontSize 原来的字号大小
+ (UIFont *)boldFontSize:(CGFloat)fontSize;


@end

NS_ASSUME_NONNULL_END
