//
//  UIDevice+MZDeviceExtension.m
//  MZExtension
//
//  Created by Mr.Z on 2020/5/14.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

#import "UIDevice+MZDeviceExtension.h"

@implementation UIDevice (MZDeviceExtension)

+ (iPhoneDevice)iPhoneDevice {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat heigth = [UIScreen mainScreen].bounds.size.height;
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationUnknown) {
        return unknown;
    }
    if (orientation == UIInterfaceOrientationPortrait) {
        if (width == 320.0f) {
            return heigth == 480.0f ? iPhone4 : iPhone5;
        } else if (width == 375.0f) {
            if (heigth == 667.0f) {
                return iPhone6;
            } else if (heigth == 812.0f) {
                return iPhoneX;
            }
        } else if (width == 414.0f) {
            if (heigth == 736.0f) {
                return iPhone6Plus;
            } else if (heigth == 896.0f) {
                return iPhoneXR;
            }
        }
    } else if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        if (heigth == 320.0f) {
            return width == 480.0f ? iPhone4 : iPhone5;
        } else if (heigth == 375.0f) {
            if (width == 667.0f) {
                return iPhone6;
            } else if (width == 812.0f) {
                return iPhoneX;
            }
        } else if (heigth == 414.0f) {
            if (width == 736.0f) {
                return iPhone6Plus;
            } else if (width == 896.0f) {
                return iPhoneXR;
            }
        }
    }
    return unknown;
}

@end
