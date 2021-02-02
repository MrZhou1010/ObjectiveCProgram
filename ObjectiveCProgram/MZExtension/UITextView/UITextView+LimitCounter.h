//
//  UITextView+LimitCounter.h
//  MZExtension
//
//  Created by Mr.Z on 2020/5/14.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (LimitCounter)

/// 限制字数
@property (nonatomic, assign) NSInteger limitCount;
/// lab的右边距(默认10.0)
@property (nonatomic, assign) CGFloat labMargin;
/// lab的高度(默认20.0)
@property (nonatomic, assign) CGFloat labHeight;
/// 统计限制字数Label
@property (nonatomic, readonly) UILabel *inputLimitLabel;

@end

NS_ASSUME_NONNULL_END
