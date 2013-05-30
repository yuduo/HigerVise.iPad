//
//  LSData.m
//  HigerManage
//
//  Created by jijesoft on 13-5-17.
//  Copyright (c) 2013年 WuHanNvl. All rights reserved.
//

#import "LSData.h"

@implementation LSData

@end
#pragma mark LSDataBook
@implementation LSDataBook
@synthesize bookID = _bookID;
@synthesize bookName = _bookName;
@synthesize logo = _logo;
@synthesize local_resource = _local_resource;
@synthesize bookType = _bookType;
@synthesize bookSize,createTime;

- (void)dealloc
{
    self.bookName = nil;
    self.logo = nil;
    self.local_resource = nil;
    
    [super dealloc];
}
@end