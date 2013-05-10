//
//  UserInfo.m
//  HigerVise
//
//  Created by Kevin.Mao on 12-10-12.
//  Copyright (c) 2012年 JijeSoft. All rights reserved.
//

#import "UserInfo.h"

static UserInfo *sharedUserInfo = nil;

@implementation UserInfo

@synthesize userName, userPassword, useriPadKey, userRealName, userLevel, userArea;

+ (UserInfo *)sharedUserInfo
{
    @synchronized(self) {
        if (sharedUserInfo == nil) {
            sharedUserInfo = [[self alloc] init];
        }
    }
    return  sharedUserInfo;
}


@end
