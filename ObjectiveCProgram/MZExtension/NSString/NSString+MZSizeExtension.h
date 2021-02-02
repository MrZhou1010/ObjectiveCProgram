//
//  NSString+MZSizeExtension.h
//  MZExtension
//
//  Created by Mr.Z on 2020/5/14.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (MZSizeExtension)

/// 获取字符串的尺寸
/// @param contentSize 内容尺寸
/// @param font 字体
- (CGSize)stringSizeWithContentSize:(CGSize)contentSize font:(UIFont *)font;

/// 获取字符串的尺寸
/// @param contentSize 内容尺寸
/// @param fontSize 字体大小
- (CGSize)stringSizeWithContentSize:(CGSize)contentSize fontSize:(CGFloat)fontSize;

/// 获取字符串的宽度
/// @param height 指定高度
/// @param fontSize 字体大小
- (CGFloat)stringWidthWithHeight:(CGFloat)height fontSize:(CGFloat)fontSize;

/// 获取字符串的高度
/// @param width 指定宽度
/// @param fontSize 字体大小
- (CGFloat)stringHeightWithWidth:(CGFloat)width fontSize:(CGFloat)fontSize;

@end

NS_ASSUME_NONNULL_END
