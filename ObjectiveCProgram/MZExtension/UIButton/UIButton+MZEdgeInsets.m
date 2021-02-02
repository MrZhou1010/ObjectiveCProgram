//
//  UIButton+MZEdgeInsets.m
//  MZExtension
//
//  Created by Mr.Z on 2020/5/14.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

#import "UIButton+MZEdgeInsets.h"

@implementation UIButton (MZEdgeInsets)

- (void)layoutButtonWithImagePositionStyle:(MZImagePositionStyle)style imageTitleSpace:(CGFloat)space {
    // 1.得到imageView和titleLabel的宽和高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    CGFloat titleWidth = 0.0;
    CGFloat titleHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0,用下面的这种设置
        titleWidth = self.titleLabel.intrinsicContentSize.width;
        titleHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        titleWidth = self.titleLabel.frame.size.width;
        titleHeight = self.titleLabel.frame.size.height;
    }
    // 2.声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets titleEdgeInsets = UIEdgeInsetsZero;
    // 3.根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (style) {
        case MZImagePositionStyleTop: {
            imageEdgeInsets = UIEdgeInsetsMake(-titleHeight - space / 2.0, 0, 0, -titleWidth);
            titleEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight - space / 2.0, 0);
        }
            break;
        case MZImagePositionStyleLeft: {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space / 2.0, 0, space / 2.0);
            titleEdgeInsets = UIEdgeInsetsMake(0, space / 2.0, 0, -space / 2.0);
        }
            break;
        case MZImagePositionStyleBottom: {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -titleHeight - space / 2.0, -titleWidth);
            titleEdgeInsets = UIEdgeInsetsMake(-imageHeight - space / 2.0, -imageWith, 0, 0);
        }
            break;
        case MZImagePositionStyleRight: {
            imageEdgeInsets = UIEdgeInsetsMake(0, titleWidth + space / 2.0, 0, -titleWidth - space / 2.0);
            titleEdgeInsets = UIEdgeInsetsMake(0, -imageWith - space / 2.0, 0, imageWith + space / 2.0);
        }
            break;
        default:
            break;
    }
    // 4.赋值
    self.titleEdgeInsets = titleEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}

- (void)layoutButtonImageUpTitleDownWithimageTitleSpace:(CGFloat)space {
    [self layoutButtonWithImagePositionStyle:MZImagePositionStyleTop imageTitleSpace:space];
}

- (void)layoutButtomEdgeInsetsWithType:(MZEdgeInsetsType)edgeInsetsType marginType:(MZMarginType)marginType margin:(CGFloat)margin {
    CGSize itemSize = CGSizeZero;
    if (edgeInsetsType == MZEdgeInsetsTypeTitle) {
        if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
            // 由于iOS8中titleLabel的size为0，用下面的这种设置
            itemSize = self.titleLabel.intrinsicContentSize;
        } else {
            itemSize = self.titleLabel.frame.size;
        }
    } else {
        itemSize = self.imageView.frame.size;
    }
    NSInteger horizontalFlag  = 0;
    NSInteger verticalFlag = 0;
    switch (marginType) {
        case MZMarginTypeTop: {
            horizontalFlag = 0;
            verticalFlag = -1;
        }
            break;
        case MZMarginTypeLeft: {
            horizontalFlag = -1;
            verticalFlag = 0;
        }
            break;
        case MZMarginTypeBottom: {
            horizontalFlag = 0;
            verticalFlag = 1;
        }
            break;
        case MZMarginTypeRight: {
            horizontalFlag = 1;
            verticalFlag = 0;
        }
            break;
        case MZMarginTypeTopLeft: {
            horizontalFlag = -1;
            verticalFlag = -1;
        }
            break;
        case MZMarginTypeTopRight: {
            horizontalFlag = 1;
            verticalFlag = -1;
        }
            break;
        case MZMarginTypeBottomLeft: {
            horizontalFlag = -1;
            verticalFlag = 1;
        }
            break;
        case MZMarginTypeBottomRight: {
            horizontalFlag = 1;
            verticalFlag = 1;
        }
            break;
        default:
            break;
    }
    CGFloat horizontalMargin = (CGRectGetWidth(self.frame) - itemSize.width) / 2.0 - margin;
    CGFloat verticalMargin = (CGRectGetHeight(self.frame) - itemSize.height) / 2.0 - margin;
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(verticalMargin * verticalFlag, horizontalMargin * horizontalFlag, -verticalMargin * verticalFlag, -horizontalMargin * horizontalFlag);
    if (edgeInsetsType == MZEdgeInsetsTypeTitle) {
        self.titleEdgeInsets = edgeInsets;
    } else {
        self.imageEdgeInsets = edgeInsets;
    }
}

@end
