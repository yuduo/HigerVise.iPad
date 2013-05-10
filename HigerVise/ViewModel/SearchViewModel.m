//
//  SearchViewModel.m
//  HigerVise
//
//  Created by Kevin.Mao on 12-10-12.
//  Copyright (c) 2012年 JijeSoft. All rights reserved.
//

#import "SearchViewModel.h"

@implementation SearchViewModel

@synthesize result, searchConditions, searchResults, searchPrompts;

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
    [self setSearchConditions:nil];
    [self setSearchResults:nil];
    [self setSearchPrompts:nil];
}

@end
