//
//  LoginViewModel.h
//  HigerVise
//
//  Created by Kevin.Mao on 12-10-12.
//  Copyright (c) 2012年 JijeSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    LoginSuccess            = 1000,     //登录成功
    LoginInitRequest        = 1001,     //正在请求初始化
    LoginInitDownload       = 1002,     //正在下载数据包
    LoginInitExpandZip      = 1003,     //正在解压数据包
    LoginDataDownload       = 1004,     //正在下载数据包
    LoginDataModify         = 1005,     //正在更新数据
    
    LoginErrorInit          = 1101,     //请下载数据包
    LoginErrorDelete        = 1102,     //系统已被删除
    LoginErrorLock          = 1103,     //系统已被锁定
    LoginErrorNotUser       = 1104,     //暂无登录纪录
    LoginErrorFailure       = 1105,     //密码已经过期
    LoginErrorPassword      = 1106,     //帐号或密码错误
    LoginErrorNotNet        = 1107,     //系统网络异常
    LoginErrorLoginKey      = 1108,     //登录密钥错误
    LoginErrorUserKey       = 1109,     //帐号交互密钥错误
    LoginErrorExpandZip     = 1110,     //数据解压失败
    LoginErroriPadUser      = 1111,     //用户名错误
    LoginErrorDataModify    = 1112,     //更新数据错误
    
} LoginResult;

@interface LoginViewModel : NSObject

@property (strong, nonatomic) NSNumber *result;
@property (strong, nonatomic) NSNumber *prgSumSize;
@property (strong, nonatomic) NSNumber *prgDownloadSize;
@property (strong, nonatomic) NSNumber *prgValue;
@property (strong, nonatomic) NSString *updateDesc;

@end
