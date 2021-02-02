//
//  UIDevice+MZDeviceExtension.h
//  MZExtension
//
//  Created by Mr.Z on 2020/5/14.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, iPhoneDevice) {
    iPhone4,
    iPhone5,
    iPhone6,
    iPhone6Plus,
    iPhoneX,
    iPhoneXR,
    unknown
};

@interface UIDevice (MZDeviceExtension)

/// 屏幕大小类型iPhone设备
+ (iPhoneDevice)iPhoneDevice;

@end

NS_ASSUME_NONNULL_END
