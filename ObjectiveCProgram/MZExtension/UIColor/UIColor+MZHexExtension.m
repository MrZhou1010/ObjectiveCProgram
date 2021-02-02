//
//  UIColor+MZHexExtension.m
//  MZExtension
//
//  Created by Mr.Z on 2020/5/14.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

#import "UIColor+MZHexExtension.h"

@implementation UIColor (MZHexExtension)

+ (UIColor * __nullable)colorWithHex:(NSInteger)hex {
    return [self colorWithHex:hex alpha:1.0];
}

+ (UIColor * __nullable)colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0f green:((float)((hex & 0xFF00) >> 8)) / 255.0f blue:((float)(hex & 0xFF)) / 255.0f alpha:alpha];
}

+ (UIColor * __nullable)colorWithHexString:(NSString *)hexStr {
    return [self colorWithHexString:hexStr alpha:1.0];
}

+ (UIColor * __nullable)colorWithHexString:(NSString *)hexStr alpha:(CGFloat)alpha {
    NSString *cString = [[hexStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    CGFloat r = 0.0;
    CGFloat g = 0.0;
    CGFloat b = 0.0;
    if (cString.length == 3) {
        r = [self colorComponent:cString start:0 length:1];
        g = [self colorComponent:cString start:1 length:1];
        b = [self colorComponent:cString start:2 length:1];
    } else if (cString.length == 6) {
        r = [self colorComponent:cString start:0 length:1];
        g = [self colorComponent:cString start:2 length:1];
        b = [self colorComponent:cString start:4 length:1];
    } else {
        return [UIColor blackColor];
    }
    return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
}

+ (CGFloat)colorComponent:(NSString *)str start:(NSUInteger)start length:(NSUInteger)length {
    NSString *subStr = [str substringWithRange:NSMakeRange(start, length)];
    NSString *fullHexStr = length == 2 ? subStr : [NSString stringWithFormat:@"%@%@", subStr, subStr];
    unsigned int hexComponent;
    [[NSScanner scannerWithString:fullHexStr] scanHexInt: &hexComponent];
    return hexComponent / 255.0f;
}

@end
