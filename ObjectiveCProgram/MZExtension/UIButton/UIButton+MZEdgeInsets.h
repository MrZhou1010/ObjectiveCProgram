//
//  UIButton+MZEdgeInsets.h
//  MZExtension
//
//  Created by Mr.Z on 2020/5/14.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MZImagePositionStyle) {
    MZImagePositionStyleTop = 0,    // image在上,title在下
    MZImagePositionStyleLeft,       // image在左,title在右
    MZImagePositionStyleBottom,     // image在下,title在上
    MZImagePositionStyleRight       // image在右,title在左
};

typedef NS_ENUM(NSInteger, MZEdgeInsetsType) {
    MZEdgeInsetsTypeTitle = 0,  // title
    MZEdgeInsetsTypeImage       // image
};

typedef NS_ENUM(NSInteger, MZMarginType) {
    MZMarginTypeTop = 0,
    MZMarginTypeLeft,
    MZMarginTypeBottom,
    MZMarginTypeRight,
    MZMarginTypeTopLeft,
    MZMarginTypeTopRight,
    MZMarginTypeBottomLeft,
    MZMarginTypeBottomRight
};

@interface UIButton (MZEdgeInsets)

/**
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现图片和标题的自由排布
 *  注意:1.该方法需在设置图片和标题之后才调用;2.图片和标题改变后需再次调用以重新计算titleEdgeInsets和imageEdgeInsets
 *  @param style 图片位置类型
 *  @param space 图片和标题之间的间隙
 */
- (void)layoutButtonWithImagePositionStyle:(MZImagePositionStyle)style imageTitleSpace:(CGFloat)space;

/**
 *  image在上,title在下
 *  @param space 图片和标题之间的间隙
 */
- (void)layoutButtonImageUpTitleDownWithimageTitleSpace:(CGFloat)space;

/**
 *  按钮只设置了title or image,该方法可以改变它们的位置
 *  @param edgeInsetsType edgeInsetsType description
 *  @param marginType marginType description
 *  @param margin margin description
 */
- (void)layoutButtomEdgeInsetsWithType:(MZEdgeInsetsType)edgeInsetsType marginType:(MZMarginType)marginType margin:(CGFloat)margin;

@end

NS_ASSUME_NONNULL_END
