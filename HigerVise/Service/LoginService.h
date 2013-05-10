//
//  LoginService.h
//  HigerVise
//
//  Created by Kevin.Mao on 12-10-12.
//  Copyright (c) 2012年 JijeSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ZipArchive.h"
#import "BaseInfo.h"
#import "ConfigInfo.h"
#import "UserInfo.h"
#import "LoginViewModel.h"
#import "DataService.h"

static NSString *kUserTextName = @"sql.txt";

@interface LoginService : NSObject<ASIHTTPRequestDelegate>
{
    NSString *_userName;
    NSString *_userPwd;
    NSString *_useriPadKey;
    NSString *_userRealName;
    NSString *_userLevel;
    NSString *_userArea;
    
    ASIHTTPRequest *_request;
    float _prgSumSize;
    float _prgDownloadSize;
    float _prgValue;
    
    LoginViewModel *_loginViewModel;
    DataService *_dataService;
    
    NSString *_userDataZipName;
    NSString *_userDataZipTempName;
    NSString *_userDataVersion;
    
    NSString *_initDataZipName;
    NSString *_initDataZipTempName;
    NSString *_initDataVersion;
}

- (id)initWithViewModel:(LoginViewModel *)loginViewModel;
- (void)requestLogin:(NSString *)userName userPwd:(NSString *)userPwd;
- (void)requestUserData:(NSString *)userName;

@end
