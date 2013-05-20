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
#pragma mark LSDataCompany
@implementation LSDataCompany
@synthesize companyID = _companyID;
@synthesize companyName = _companyName;
@synthesize logo = _logo;
@synthesize address = _address;
@synthesize state = _state;

- (void)dealloc
{
    self.companyName = nil;
    self.logo = nil;
    self.address = nil;
    
    [super dealloc];
}
@end