//
//  LoginViewController.h
//  HigerVise
//
//  Created by Kevin.Mao on 12-10-12.
//  Copyright (c) 2012年 JijeSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"
#import "BaseInfo.h"
#import "ConfigInfo.h"
#import "UserInfo.h"
#import "LoginViewModel.h"
#import "LoginService.h"

@interface LoginViewController : UIViewController<MBProgressHUDDelegate, UIAlertViewDelegate>
{
    MBProgressHUD *_hud; //提示框
    LoginService *_loginService; //登录业务逻辑类
    LoginViewModel *_loginViewModel; //登录页面实体
    
    // 状态
	BOOL bLandScape;
}

@property (weak, nonatomic) IBOutlet UIView *viewLogin; //登录页面
@property (weak, nonatomic) IBOutlet UIImageView *imgLoginFrame; //登录背景
@property (weak, nonatomic) IBOutlet UIImageView *imgLoginNothing; //登录背景（无）
@property (weak, nonatomic) IBOutlet UILabel *lblUserName; //用户名标签
@property (weak, nonatomic) IBOutlet UILabel *lblUserPwd; //用户密码标签
@property (weak, nonatomic) IBOutlet UITextField *txtUserName; //用户名输入框
@property (weak, nonatomic) IBOutlet UITextField *txtUserPwd; //密码输入框
@property (weak, nonatomic) IBOutlet UIButton *btnLogin; //登录按钮

- (IBAction)btnLogin_TouchUpInside:(id)sender; //登录事件

@end
