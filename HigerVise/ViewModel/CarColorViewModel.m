//
//  CarColorViewModel.m
//  HigerVise
//
//  Created by Kevin.Mao on 12-10-31.
//  Copyright (c) 2012年 JijeSoft. All rights reserved.
//

#import "CarColorViewModel.h"

@implementation CarColorViewModel
@synthesize result, groups;
@synthesize sumCount, finishedCount, failedCount;

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
    [self setGroups:nil];
}

@end
