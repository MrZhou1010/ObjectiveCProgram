//
//  UIFont+MZFitDevice.m
//  MZExtension
//
//  Created by Mr.Z on 2020/5/14.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

#import "UIFont+MZFitDevice.h"
#import "UIDevice+MZDeviceExtension.h"

@implementation UIFont (MZFitDevice)

+ (UIFont *)fontSize:(CGFloat)fontSize {
    return [UIFont systemFontOfSize:[self updateFontSize:fontSize]];
}

+ (UIFont *)boldFontSize:(CGFloat)fontSize {
    return [UIFont boldSystemFontOfSize:[self updateFontSize:fontSize]];
}

+ (CGFloat)updateFontSize:(CGFloat)fontSize {
    switch ([UIDevice iPhoneDevice]) {
        case iPhone4: {
            return fontSize - 2.0;
            break;
        }
        case iPhone5: {
            return fontSize - 2.0;
            break;
        }
        case iPhone6: {
            return fontSize;
            break;
        }
        case iPhone6Plus: {
            return fontSize + 1.5;
            break;
        }
        case iPhoneX: {
            return fontSize + 1.0;
            break;
        }
        case iPhoneXR: {
            return fontSize + 1.5;
            break;
        }
        case unknown: {
            return fontSize;
            break;
        }
    }
}

@end
