//
//  UserInfo.h
//  HigerVise
//
//  Created by Kevin.Mao on 12-10-12.
//  Copyright (c) 2012年 JijeSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (weak, nonatomic) NSString *userName;
@property (weak, nonatomic) NSString *userPassword;
@property (weak, nonatomic) NSString *useriPadKey;
@property (weak, nonatomic) NSString *userRealName;
@property (weak, nonatomic) NSString *userLevel;
@property (weak, nonatomic) NSString *userArea;

+ (UserInfo *)sharedUserInfo;

@end
