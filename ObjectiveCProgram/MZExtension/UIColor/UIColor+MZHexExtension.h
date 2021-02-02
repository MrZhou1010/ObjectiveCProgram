//
//  UIColor+MZHexExtension.h
//  MZExtension
//
//  Created by Mr.Z on 2020/5/14.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (MZHexExtension)

/// 十六进制颜色值
/// @param hex 颜色值
+ (UIColor * __nullable)colorWithHex:(NSInteger)hex;

/// 十六进制颜色值,透明度
/// @param hex 颜色值
/// @param alpha 透明度
+ (UIColor * __nullable)colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha;

/// 十六进制颜色值(#、0x)
/// @param hexStr 颜色值
+ (UIColor * __nullable)colorWithHexString:(NSString *)hexStr;

/// 十六进制颜色值,透明度(#、0x)
/// @param hexStr 颜色值
/// @param alpha 透明度
+ (UIColor * __nullable)colorWithHexString:(NSString *)hexStr alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
