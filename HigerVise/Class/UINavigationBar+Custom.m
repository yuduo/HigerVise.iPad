//
//  UINavigationBar+Custom.m
//  HigerManage
//
//  Created by jijesoft on 13-6-4.
//  Copyright (c) 2013年 WuHanNvl. All rights reserved.
//

#import "UINavigationBar+Custom.h"


@implementation UINavigationBar (CustomHeight)

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect barFrame = self.frame;
    barFrame.size.height = 60;
    self.frame = barFrame;
}

@end