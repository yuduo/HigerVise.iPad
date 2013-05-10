//
//  LoginViewModel.m
//  HigerVise
//
//  Created by Kevin.Mao on 12-10-12.
//  Copyright (c) 2012年 JijeSoft. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel

@synthesize result, prgSumSize, prgDownloadSize, prgValue, updateDesc;

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    [self setResult:nil];
    [self setPrgSumSize:nil];
    [self setPrgDownloadSize:nil];
    [self setPrgValue:nil];
    [self setUpdateDesc:nil];
}

@end
