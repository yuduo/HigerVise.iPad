//
//  UISearchBar.m
//  HigerManage
//
//  Created by jijesoft on 13-5-30.
//  Copyright (c) 2013年 WuHanNvl. All rights reserved.
//

#import "UISearchBar.h"
#import <QuartzCore/QuartzCore.h>

@implementation UISearchBar(CustomBackground)
- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed: @"searchBar.png"];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

@end