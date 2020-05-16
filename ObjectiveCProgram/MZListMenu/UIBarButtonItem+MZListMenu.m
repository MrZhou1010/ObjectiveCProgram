//
//  UIBarButtonItem+MZListMenu.m
//  MZListMenu
//
//  Created by Mr.Z on 2020/5/14.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

#import "UIBarButtonItem+MZListMenu.h"

@implementation UIBarButtonItem (MZListMenu)

- (void)mz_showMenuWithImages:(NSArray *)imageArr titles:(NSArray *)titleArr currentNav:(UINavigationController *)currentNav configuration:(MZListMenuConfiguration *)configuration itemClickBlock:(MZListMenuItemClick)block {
    [MZListMenu showMenuWithImages:imageArr titles:titleArr currentNav:currentNav configuration:configuration itemClickBlock:block];
}

@end
