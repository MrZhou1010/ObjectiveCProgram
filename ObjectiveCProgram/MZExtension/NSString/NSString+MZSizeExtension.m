//
//  NSString+MZSizeExtension.m
//  MZExtension
//
//  Created by Mr.Z on 2020/5/14.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

#import "NSString+MZSizeExtension.h"

@implementation NSString (MZSizeExtension)

- (CGSize)stringSizeWithContentSize:(CGSize)contentSize font:(UIFont *)font {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize size = [self boundingRectWithSize:contentSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size;
}

- (CGSize)stringSizeWithContentSize:(CGSize)contentSize fontSize:(CGFloat)fontSize {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    NSDictionary *attributes = @{NSFontAttributeName: font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize size = [self boundingRectWithSize:contentSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size;
}

- (CGFloat)stringWidthWithHeight:(CGFloat)height fontSize:(CGFloat)fontSize {
    UIColor *backgroundColor = [UIColor blackColor];
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    CGRect sizeToFit = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSForegroundColorAttributeName:backgroundColor, NSFontAttributeName:font} context:nil];
    return sizeToFit.size.width;
}

- (CGFloat)stringHeightWithWidth:(CGFloat)width fontSize:(CGFloat)fontSize {
    UIColor *backgroundColor = [UIColor blackColor];
    UIFont *font = [UIFont boldSystemFontOfSize:fontSize];
    CGRect sizeToFit = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSForegroundColorAttributeName:backgroundColor, NSFontAttributeName:font} context:nil];
    return sizeToFit.size.height;
}
@end
