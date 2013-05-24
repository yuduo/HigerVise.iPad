//
//  LSImageMatch.m
//  HigerManage
//
//  Created by jijesoft on 13-5-23.
//  Copyright (c) 2013年 WuHanNvl. All rights reserved.
//

#import "LSImageMatch.h"

@implementation LSImageMatch
@synthesize view = _view;
@synthesize imageURL = _imageURL;
- (void)dealloc
{
    self.view = nil;
    self.imageURL = nil;
    [super dealloc];
}
@end
