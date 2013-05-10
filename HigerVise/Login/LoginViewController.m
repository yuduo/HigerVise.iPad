//
//  LoginViewController.m
//  HigerVise
//
//  Created by Kevin.Mao on 12-10-12.
//  Copyright (c) 2012年 JijeSoft. All rights reserved.
//

#import "LoginViewController.h"
#import "GVTFirstViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize viewLogin, imgLoginFrame, imgLoginNothing, lblUserName, lblUserPwd, txtUserName, txtUserPwd, btnLogin;

#pragma mark - view lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //隐藏导航条
    self.navigationController.navigationBarHidden = YES;
    
    //设置控件位置，主要设置高度以及y轴距离
    self.txtUserPwd.frame = CGRectMake(self.txtUserPwd.frame.origin.x, self.btnLogin.frame.origin.y - (self.txtUserPwd.frame.size.height + 25) - 30, self.txtUserPwd.frame.size.width, self.txtUserPwd.frame.size.height + 25);
    self.txtUserName.frame = CGRectMake(self.txtUserName.frame.origin.x, self.txtUserPwd.frame.origin.y - (self.txtUserName.frame.size.height + 20) - 30, self.txtUserName.frame.size.width, self.txtUserName.frame.size.height + 25);
    self.lblUserPwd.frame = CGRectMake(self.lblUserPwd.frame.origin.x, self.txtUserPwd.frame.origin.y + 5, self.lblUserPwd.frame.size.width, self.lblUserPwd.frame.size.height);
    self.lblUserName.frame = CGRectMake(self.lblUserName.frame.origin.x, self.txtUserName.frame.origin.y + 5, self.lblUserName.frame.size.width, self.lblUserName.frame.size.height);
    
    //初始化变量
    _loginViewModel = [[LoginViewModel alloc] init];
    _loginService = [[LoginService alloc] initWithViewModel:_loginViewModel];
    
    //监听实体对象，输出结果
    [_loginViewModel addObserver:self   
                      forKeyPath:@"result" 
                         options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew 
                         context:nil];
    
    //监听实体对象，下载总量大小
    [_loginViewModel addObserver:self   
                      forKeyPath:@"prgSumSize" 
                         options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew 
                         context:nil];
    
    //监听实体对象，已经下载总量大小
    [_loginViewModel addObserver:self   
                      forKeyPath:@"prgDownloadSize" 
                         options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew 
                         context:nil];
    
    //监听实体对象，计算进度条大小
    [_loginViewModel addObserver:self   
                      forKeyPath:@"prgValue" 
                         options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew 
                         context:nil];
    
    //更新数据库文件
//    [BaseInfo updateSqliteDatabase];
}

- (void)viewWillAppear:(BOOL)animated
{
    //即将显示页面，设置最后一次登录用户名
    self.txtUserName.text = @"";
    self.txtUserPwd.text = @"";
    self.txtUserName.text = [ConfigInfo AppLastLoginUserName];
    
    //设置显示登录页面动画，隐藏页面控件
    imgLoginFrame.hidden = YES;
    lblUserName.hidden = YES;
    lblUserPwd.hidden = YES;
    txtUserName.hidden = YES;
    txtUserPwd.hidden = YES;
    btnLogin.hidden = YES;
    imgLoginNothing.hidden = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    static BOOL isFirstLoad = YES;
    if (isFirstLoad) {
        
    }
    isFirstLoad = NO;
    
    //设置动画，显示页面对象
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5];
    [animation setType:@"fade"];
    [animation setSubtype:kCATransitionFromRight];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [viewLogin.layer addAnimation:animation forKey:nil];
    
    //显示页面控件
    imgLoginFrame.hidden = NO;
    lblUserName.hidden = NO;
    lblUserPwd.hidden = NO;
    txtUserName.hidden = NO;
    txtUserPwd.hidden = NO;
    btnLogin.hidden = NO;
    imgLoginNothing.hidden = YES;
}

- (void)dealloc
{
    [_loginViewModel removeObserver:self forKeyPath:@"result" context:nil];
    [_loginViewModel removeObserver:self forKeyPath:@"prgSumSize" context:nil];
    [_loginViewModel removeObserver:self forKeyPath:@"prgDownloadSize" context:nil];
    [_loginViewModel removeObserver:self forKeyPath:@"prgValue" context:nil];
    
    if (_hud) {
        [_hud removeFromSuperview];
        _hud = nil;
    }
    _loginService = nil;
    _loginViewModel = nil;
    
    [self setViewLogin:nil];
    [self setImgLoginFrame:nil];
    [self setImgLoginNothing:nil];
    [self setLblUserName:nil];
    [self setLblUserPwd:nil];
    [self setTxtUserName:nil];
    [self setTxtUserPwd:nil];
    [self setBtnLogin:nil];
}

- (void)viewDidUnload
{
    [self setViewLogin:nil];
    [self setImgLoginFrame:nil];
    [self setImgLoginNothing:nil];
    [self setLblUserName:nil];
    [self setLblUserPwd:nil];
    [self setTxtUserName:nil];
    [self setTxtUserPwd:nil];
    [self setBtnLogin:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)didReceiveMemoryWarning
{
    
}

#pragma mark -
#pragma mark  rotate
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	bLandScape = NO;
	if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight){
		bLandScape = YES;
	}
	
	return YES;
}
- (BOOL)shouldAutorotate {
    return YES;
}
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}
- (void)viewDidLayoutSubviews
{
    
        UIDeviceOrientation interfaceOrientation=[[UIApplication sharedApplication] statusBarOrientation];
        if (interfaceOrientation == UIDeviceOrientationPortrait || interfaceOrientation == UIDeviceOrientationPortraitUpsideDown) {
            //翻转为竖屏时
            [self setVerticalFrame];
        }else if (interfaceOrientation==UIDeviceOrientationLandscapeLeft || interfaceOrientation == UIDeviceOrientationLandscapeRight) {
            //翻转为横屏时
            [self setHorizontalFrame];
        }
    
}
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
	if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
	   interfaceOrientation == UIInterfaceOrientationLandscapeRight)
	{
		bLandScape = YES;
	}else {
		bLandScape = NO;
	}
	
}
-(void)setVerticalFrame
{
    [imgLoginFrame setImage:[UIImage imageNamed:@"login-bg.png"]];
    [lblUserName setFrame:CGRectMake(15, 220, 120, 41)];
    
    [lblUserPwd setFrame:CGRectMake(15, 264, 120, 41)];
    [txtUserName setFrame:CGRectMake(125, 226, 344, 31)];
    [txtUserPwd setFrame:CGRectMake(125, 269, 344, 31)];
    [btnLogin setFrame:CGRectMake(125, 308, 344, 83)];
     
}
-(void)setHorizontalFrame
{
    [imgLoginFrame setImage:[UIImage imageNamed:@"login-bg.png"]];
    [lblUserName setFrame:CGRectMake(45, 120, 120, 41)];
    
    [lblUserPwd setFrame:CGRectMake(45, 164, 120, 41)];
    [txtUserName setFrame:CGRectMake(155, 126, 344, 31)];
    [txtUserPwd setFrame:CGRectMake(155, 169, 344, 31)];
    [btnLogin setFrame:CGRectMake(155, 208, 344, 83)];
}
#pragma mark - MBProgressHUDDelegate

- (void)hudWasHidden:(MBProgressHUD *)hud 
{
	[_hud removeFromSuperview];
	_hud = nil;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 101) {
        if (buttonIndex == 0) {
            _hud = [[MBProgressHUD alloc] initWithView:self.view];
            _hud.delegate = self;
            _hud.labelText = @"正在登录";
            //_hud.dimBackground = YES;
            [self.view addSubview:_hud];
            [_hud show:YES];
            
            //请求登录
            [self performSelector:@selector(login) withObject:nil afterDelay:0.1];
        }
    }
    else if (alertView.tag == 102) {
        if (buttonIndex == 0) {
            [self performSelector:@selector(transformPage) withObject:nil afterDelay:0.1];
        }
    }
}

#pragma mark - user actions

- (void)login
{
    NSString *userName = self.txtUserName.text;
    NSString *userPwd = self.txtUserPwd.text;
    [_loginService requestLogin:userName userPwd:userPwd];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqual:@"result"]) {
        LoginResult loginResult = [[change objectForKey:@"new"] intValue];
        switch (loginResult) {
            case LoginSuccess:
                if ([ConfigInfo AppHasUserData]) {
                    if ([BaseInfo isExistenceNetwork]) {
                        _hud.mode = MBProgressHUDModeIndeterminate;
                        _hud.labelText = @"绑定用户改变或者用户权限改变";
                        _hud.detailsLabelText = @"正在重新更新数据";
                        [_loginService performSelector:@selector(requestUserData:) withObject:[UserInfo sharedUserInfo].userName afterDelay:0.1];
                        return;
                    }
                    else {
                        _hud.customView = [BaseInfo getMsgPrompt];
                        _hud.mode = MBProgressHUDModeCustomView;
                        _hud.labelText = @"绑定用户改变或者用户权限改变";
                        _hud.detailsLabelText = @"请连接网络重新更新数据";
                        [_hud hide:YES afterDelay:5.0];
                    }
                }
                else {
                    [ConfigInfo setConfigValue:[UserInfo sharedUserInfo].userName key:kAppLastLoginUserName];
                    [BaseInfo addSystemLog:@"登录模块" log_operation:@"请求登录" log_message:@"登录成功" log_error:@""];
                    if (_loginViewModel.updateDesc == nil || [_loginViewModel.updateDesc isEqualToString:@""]) {
                        _hud.customView = [BaseInfo getMsgSuccess];
                        _hud.mode = MBProgressHUDModeCustomView;
                        _hud.labelText = @"登录成功";
                        [_hud hide:YES afterDelay:0.5];
                        [self performSelector:@selector(transformPage) withObject:nil afterDelay:0.5];
                    }
                    else {
                        [_hud hide:YES];
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"变更明细" 
                                                                            message:_loginViewModel.updateDesc 
                                                                           delegate:self 
                                                                  cancelButtonTitle:@"确定" 
                                                                  otherButtonTitles:nil, nil];
                        alertView.tag = 102;
                        [alertView show];
                        _loginViewModel.updateDesc = @"";
                    }
                }
                break;
                
                
                
            case LoginInitRequest:
                _hud.mode = MBProgressHUDModeIndeterminate;
                _hud.labelText = @"正在请求初始化";
                break;
            case LoginDataDownload:
                _hud.mode = MBProgressHUDModeAnnularDeterminate;
                _hud.labelText = @"正在下载数据包";
                break;
            case LoginInitDownload:
                _hud.mode = MBProgressHUDModeAnnularDeterminate;
                _hud.labelText = @"正在下载数据包";
                break;
            case LoginInitExpandZip:
                _hud.mode = MBProgressHUDModeIndeterminate;
                _hud.labelText = @"正在解压数据包";
                _hud.detailsLabelText = @"";
                break;
            case LoginDataModify:
                _hud.mode = MBProgressHUDModeIndeterminate;
                _hud.labelText = @"正在更新数据";
                _hud.detailsLabelText = @"";
                break;
                
                
            case LoginErrorInit:
                _hud.customView = [BaseInfo getMsgPrompt];
                _hud.mode = MBProgressHUDModeCustomView;
                _hud.labelText = @"系统尚未初始化";
                _hud.detailsLabelText = @"请连接网络下载初始化包";
                [_hud hide:YES afterDelay:5.0];
                break;
            case LoginErrorDelete:
                _hud.customView = [BaseInfo getMsgPrompt];
                _hud.mode = MBProgressHUDModeCustomView;
                _hud.labelText = @"系统已被加入黑名单";
                _hud.detailsLabelText = @"请联系相关人员解除并连接网络登录";
                [_hud hide:YES afterDelay:5.0];
                break;
            case LoginErrorLock:
                _hud.customView = [BaseInfo getMsgPrompt];
                _hud.mode = MBProgressHUDModeCustomView;
                _hud.labelText = @"系统已被锁定";
                _hud.detailsLabelText = @"请联系相关人员解除并连接网络登录";
                [_hud hide:YES afterDelay:5.0];
                break;
            case LoginErrorNotUser:
                _hud.customView = [BaseInfo getMsgPrompt];
                _hud.mode = MBProgressHUDModeCustomView;
                _hud.labelText = @"系统暂无该帐号登录纪录";
                [_hud hide:YES afterDelay:2.0];
                break;
            case LoginErrorFailure:
                _hud.customView = [BaseInfo getMsgPrompt];
                _hud.mode = MBProgressHUDModeCustomView;
                _hud.labelText = @"用户密码已经过期";
                _hud.detailsLabelText = @"请连接网络重新登录";
                [_hud hide:YES afterDelay:2.0];
                break;
            case LoginErrorPassword:
                _hud.customView = [BaseInfo getMsgPrompt];
                _hud.mode = MBProgressHUDModeCustomView;
                _hud.labelText = @"用户名或密码错误";
                _hud.detailsLabelText = [NSString stringWithFormat:@"剩余允许错误次数%d次", ([ConfigInfo ServerErrorNumber] - [self getLoginErrorNumber])];
                [_hud hide:YES afterDelay:5.0];
                break;
            case LoginErrorNotNet:
                _hud.customView = [BaseInfo getMsgPrompt];
                _hud.mode = MBProgressHUDModeCustomView;
                _hud.labelText = @"系统网络异常";
                [_hud hide:YES afterDelay:2.0];
                break;
            case LoginErrorLoginKey:
                _hud.customView = [BaseInfo getMsgPrompt];
                _hud.mode = MBProgressHUDModeCustomView;
                _hud.labelText = @"登录密钥错误";
                [_hud hide:YES afterDelay:2.0];
                break;
            case LoginErrorUserKey:
                _hud.customView = [BaseInfo getMsgPrompt];
                _hud.mode = MBProgressHUDModeCustomView;
                _hud.labelText = @"当前网络状况暂不稳定";
                _hud.detailsLabelText = @"请稍后再试";
                [_hud hide:YES afterDelay:2.0];
                break;
            case LoginErrorExpandZip:
                _hud.customView = [BaseInfo getMsgPrompt];
                _hud.mode = MBProgressHUDModeCustomView;
                _hud.labelText = @"数据解压失败";
                [_hud hide:YES afterDelay:2.0];
                break;
            case LoginErroriPadUser:
                _hud.customView = [BaseInfo getMsgPrompt];
                _hud.mode = MBProgressHUDModeCustomView;
                _hud.labelText = @"请尝试使用绑定用户登录";
                _hud.detailsLabelText = @"系统不存在该用户或者已被其他用户绑定";
                [_hud hide:YES afterDelay:5.0];
                break;
            case LoginErrorDataModify:
                _hud.customView = [BaseInfo getMsgPrompt];
                _hud.mode = MBProgressHUDModeCustomView;
                _hud.labelText = @"更新数据错误";
                [_hud hide:YES afterDelay:2.0];
                break;
            default:
                _hud.customView = [BaseInfo getMsgPrompt];
                _hud.mode = MBProgressHUDModeCustomView;
                _hud.labelText = @"登录异常";
                [_hud hide:YES afterDelay:2.0];
                break;
        }
    }
    else if ([keyPath isEqual:@"prgSumSize"]) {
        _hud.labelText = [NSString stringWithFormat:@"总计剩余 %.2fMB", [[change objectForKey:@"new"] floatValue]];
    }
    else if ([keyPath isEqual:@"prgDownloadSize"]) { 
        _hud.detailsLabelText = [NSString stringWithFormat:@"已下载 %.2fMB", [[change objectForKey:@"new"] floatValue]];
    }
    else if ([keyPath isEqual:@"prgValue"]) {
        _hud.progress = [[change objectForKey:@"new"] floatValue];
    }
}

- (void)transformPage
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5];
    [animation setType:@"fade"];
    [animation setSubtype:kCATransitionFromLeft];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
   
    GVTFirstViewController *fvc = [[GVTFirstViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:fvc animated:NO];
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
}

- (IBAction)btnLogin_TouchUpInside:(id)sender 
{
//    NSString *dbPath = [BaseInfo getDataBasePath];
//    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
//    [db open];
//    NSString *strSql = @"update client_vehicle_edition_setting set sale_group_code = '1001' where sale_group_code = 's01'";
//    [db executeUpdate:strSql];
//    strSql = @"update client_vehicle_edition_setting set sale_group_code = '1002' where sale_group_code = 's02' or sale_group_code = 's03'";
//    [db executeUpdate:strSql];    
//    [db close];
    
    //if ([BaseInfo isDebug]) {
        //self.txtUserName.text = @"wangqf";
        //self.txtUserPwd.text = @"aki1031";
        //self.txtUserName.text = kHigerViseClientOffLine;
        //self.txtUserPwd.text = kHigerViseClientOffLine;
    //}
    
    //[ConfigInfo setConfigValue:@"1" key:kAppVersion];
    
//    [self.txtUserName resignFirstResponder];
//    [self.txtUserPwd resignFirstResponder];
    
//    if ([self.txtUserName.text isEqualToString:@""]) {
//        _hud = [[MBProgressHUD alloc] initWithView:self.view];
//        _hud.delegate = self;
//        _hud.customView = [BaseInfo getMsgPrompt];
//        _hud.mode = MBProgressHUDModeCustomView;
//        _hud.labelText = @"请填写用户名";
//        //_hud.dimBackground = YES;
//        [self.view addSubview:_hud];
//        [_hud show:YES];
//        [_hud hide:YES afterDelay:1.0];
//        return;
//    }
//    
//    if ([self.txtUserPwd.text isEqualToString:@""]) {
//        _hud = [[MBProgressHUD alloc] initWithView:self.view];
//        _hud.delegate = self;
//        _hud.customView = [BaseInfo getMsgPrompt];
//        _hud.mode = MBProgressHUDModeCustomView;
//        _hud.labelText = @"请填写密码";
//        //_hud.dimBackground = YES;
//        [self.view addSubview:_hud];
//        [_hud show:YES];
//        [_hud hide:YES afterDelay:1.0];
//        return;
//    }
    
//    if ([self.txtUserName.text isEqualToString:kHigerViseClientOffLine] &&
//        [self.txtUserPwd.text isEqualToString:kHigerViseClientOffLine])
    self.txtUserName.text =kHigerViseClientOffLine;
    self.txtUserPwd.text =kHigerViseClientOffLine;
    {
        [UserInfo sharedUserInfo].userName = kHigerViseClientOffLine;
        [UserInfo sharedUserInfo].userPassword = kHigerViseClientOffLine;
        [UserInfo sharedUserInfo].useriPadKey = kHigerViseClientOffLine;
        [UserInfo sharedUserInfo].userRealName = @"数据管理员";
        [UserInfo sharedUserInfo].userLevel = @"1000";
        [UserInfo sharedUserInfo].userArea = @"ALL";
        
        NSString *dbResourcePath = [[NSBundle mainBundle] pathForResource:kHigerDatabaseOffLine ofType:@""];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
        NSString *documentsPath = [paths objectAtIndex:0]; 
        NSString *databasePath = [documentsPath stringByAppendingPathComponent:kHigerDatabaseOffLine]; 
        if (![[NSFileManager defaultManager] fileExistsAtPath:databasePath]) {
            //[[NSFileManager defaultManager] removeItemAtPath:databasePath error:nil];
            [[NSFileManager defaultManager] copyItemAtPath:dbResourcePath toPath:databasePath error:nil];
        }
        
        [self performSelector:@selector(transformPage) withObject:nil afterDelay:0.5];
        
        return;
    }
    
    if ([ConfigInfo AppStatus] == kAppStatusInit) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"建议WIFI环境\r\n系统需初始化登录？" delegate:self cancelButtonTitle:@"登录并下载" otherButtonTitles:@"取消登录", nil];
        alertView.tag = 101;
        [alertView show];
        return;
    }
    
    _hud = [[MBProgressHUD alloc] initWithView:self.view];
    _hud.delegate = self;
    _hud.labelText = @"正在登录";
    //_hud.dimBackground = YES;
    [self.view addSubview:_hud];
    [_hud show:YES];
    
    //请求登录
    [self performSelector:@selector(login) withObject:nil afterDelay:0.1];
}

- (int)getLoginErrorNumber
{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *localDate = [dateFormatter stringFromDate:date];
    NSString *where = [NSString stringWithFormat:@"date(login_time, 'unixepoch', 'localtime') = '%@' AND login_result = 0 ORDER BY user_login_id DESC", localDate];
    NSArray *array = [client_user_login_dal getList:where];
    return array.count;
}


@end
