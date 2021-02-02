//
//  UIView+MZListMenu.m
//  MZListMenu
//
//  Created by Mr.Z on 2020/5/14.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

#import "UIView+MZListMenu.h"

@implementation UIView (MZListMenu)

- (void)mz_showMenuWithImages:(NSArray *)imageArr titles:(NSArray *)titleArr configuration:(MZListMenuConfiguration *)configuration itemClickBlock:(MZListMenuItemClick)block {
    [MZListMenu showMenuWithImages:imageArr titles:titleArr inView:self configuration:configuration itemClickBlock:block];
}

@end
