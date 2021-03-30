//
//  MZMacro.h
//  ObjectiveCProgram
//
//  Created by Mr.Z on 2020/5/14.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

#ifndef MZMacro_h
#define MZMacro_h

#pragma mark - 布局
/// mainScreen
#define MZMainScreen [UIScreen mainScreen]

/// 支持横屏,当前Xcode支持iOS8及以上
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
#define MZScreenWidth ([MZMainScreen respondsToSelector:@selector(nativeBounds)] ? MZMainScreen.nativeBounds.size.width / MZMainScreen.nativeScale : MZMainScreen.bounds.size.width)
#define MZScreenHeight ([MZMainScreen respondsToSelector:@selector(nativeBounds)] ? MZMainScreen.nativeBounds.size.height / MZMainScreen.nativeScale : MZMainScreen.bounds.size.height)
#define MZScreenSize ([MZMainScreen respondsToSelector:@selector(nativeBounds)] ? CGSizeMake(MZMainScreen.nativeBounds.size.width / MZMainScreen.nativeScale, MZMainScreen.nativeBounds.size.height / MZMainScreen.nativeScale) : MZMainScreen.bounds.size)
#else
#define MZScreenWidth MZMainScreen.bounds.size.width
#define MZScreenHeight MZMainScreen.bounds.size.height
#define MZScreenSize MZMainScreen.bounds.size
#endif

/// 适配比例
#define MZRectRatio(x) (MZScreenWidth / 375.0 * x)

/// AppDelegate对象
#define MZAppDelegate [[UIApplication sharedApplication] delegate]

/// 是否iPhoneX
#define MZIPhoneX (@available(iOS 11.0, *) ? [MZAppDelegate window].safeAreaInsets.bottom > 0.0 : NO)

/// 状态栏高度
#define MZStatusBarHeight (CGFloat)(MZIPhoneX ? (44.0) : (20.0))
/// 导航栏高度
#define MZNavBarHeight (44.0)
/// 状态栏和导航栏总高度
#define MZStatusNavBarHeight (CGFloat)(MZIPhoneX ? (88.0) : (64.0))
/// TabBar高度
#define MZTabBarHeight (CGFloat)(MZIPhoneX ? (49.0 + 34.0) : (49.0))
/// 顶部安全区域远离高度
#define MZTopSafeHeight (CGFloat)(MZIPhoneX ? (44.0) : (0))
/// 底部安全区域远离高度
#define MZBottomSafeHeight (CGFloat)(MZIPhoneX ? (34.0) : (0))

#pragma mark - 颜色
#define RGBA(r, g, b, a) [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:a]
#define RGB(r, g, b) RGBA(r, g, b, 1.0f)
#define HexColorA(hex, a) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0f green:((float)((hex & 0xFF00) >> 8)) / 255.0f blue:((float)(hex & 0xFF)) / 255.0f alpha:a]
#define HexColor(hex) HexColorA(hex, 1.0f)
#define MZRandomColor RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#pragma mark - 字体
#define MZFont(fontSize) [UIFont systemFontOfSize:fontSize]

#pragma mark - 获取图片资源
#define MZGetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@", imageName]]

#pragma mark - mainBundle
/// 获取mainBundle
#define MZMainBundle [NSBundle mainBundle]
/// 获取bundlePath
#define MZBundlePath [MZMainBundle bundlePath]

/// App版本号
#define MZAppVersion [[MZMainBundle infoDictionary] objectForKey:@"CFBundleShortVersionString"]

/// 系统版本号
#define MZSystemVersion [[UIDevice currentDevice] systemVersion]

/// 获取沙盒路径
#define MZHomePath NSHomeDirectory()
/// 获取沙盒temp路径
#define MZTempPath NSTemporaryDirectory()
/// 获取沙盒document路径
#define MZDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
/// 获取沙盒cache路径
#define MZCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
/// 文件路径library/caches
#define MZFileCachePath ([[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil])

#pragma mark - 弱引用和强引用
/// 弱引用
#define MZWeakSelf(type) __weak typeof(type) weak##type = type;

#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define mz_weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define mz_weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define mz_weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define mz_weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

/// 强引用
#define MZStrongSelf(type) __strong typeof(weak##type) type = weak##type;

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define mz_strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define mz_strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define mz_strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define mz_strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

#pragma mark - 获取通知中心
#define MZNotificationCenter [NSNotificationCenter defaultCenter]

#pragma mark - userDefaults
#define MZUserDefaults [NSUserDefaults standardUserDefaults]

#pragma mark - 开发Log
#ifdef DEBUG
#define MZLog(fmt, ...) NSLog((@"[路径:%s]" "[函数名:%s]" "[行号:%d]" fmt), [[NSString stringWithFormat:@"%s", __FILE__].lastPathComponent UTF8String], __FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define MZLog(fmt, ...)
#endif

#endif /* MZMacro_h */
