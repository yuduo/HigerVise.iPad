//
//  AppDelegate.m
//  HigerVise
//
//  Created by Kevin.Mao on 12-10-11.
//  Copyright (c) 2012年 JijeSoft. All rights reserved.
//

#import "AppDelegate.h"
#import "FatNavigationController.h"
//#import "UINavigationController+Rotation.h"
@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //设置启动导航条
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UINib *nib = [UINib nibWithNibName:@"NavigationController" bundle:nil];
    FatNavigationController *navigationController = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    if ( [[UIDevice currentDevice].systemVersion floatValue] < 6.0){
        // warning: addSubView doesn't work on iOS6
        [self.window addSubview: navigationController.view];
    }
    else{
        // use this mehod on ios6
        [self.window setRootViewController:navigationController];
    }
    [self.window makeKeyAndVisible];
    
    //配置文件初始化
    [ConfigInfo initialize];
    
    //设置配置文件中ipad名称
    [ConfigInfo setConfigValue:[BaseInfo encrypt:[UIDevice currentDevice].name] 
                           key:[BaseInfo encrypt:kiPadName]];
    
    //设置应用图标数字
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0]; 
    
    //注册推送通知，注册包括图片、声音以及消息
    //if(!application.enabledRemoteNotificationTypes) { 
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
    //}
    
    //禁止系统自动锁屏
    UIApplication *app = [UIApplication sharedApplication]; 
    app.idleTimerDisabled = YES;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    //存储用户当前切换至后台的时间点，该时间点用于在切换回来的时候，对比时间差，如果大于指定时间，则返回至登录页面，进行重新登录
    [[NSNotificationCenter defaultCenter] postNotificationName:@"newFeedbackViewHidden" object:nil];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [NSDate date];
    NSString *dateString = [dateFormatter stringFromDate:date];
    [ConfigInfo setConfigValue:dateString key:kAppTimeOut];
    
    //纪录客户端日志信息
    [BaseInfo addSystemLog:@"程序模块" log_operation:@"切换程序" log_message:@"切换至后台" log_error:@""];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    //比较当前时间与切换至后台时间
    NSDate *date = [NSDate date];//当前时间
    NSTimeInterval time = [date timeIntervalSinceDate:[ConfigInfo AppTimeOut]];//秒单位
    int minutes = ((int)time) / 60;
    
    //如果时间差大于系统自动返回登录页面时间，则返回至登录页面重新登录
    if (minutes >= [ConfigInfo ServerLockMinutes]) {
        //返回登录页面
        if ([self.window.rootViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
            [navigationController popToRootViewControllerAnimated:NO];
        }
    }
    
    //更新存储用户当前切换至后台的时间点
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    [ConfigInfo setConfigValue:dateString key:kAppTimeOut];
    
    //纪录客户端日志信息
    [BaseInfo addSystemLog:@"程序模块" log_operation:@"切换程序" log_message:@"切换至前台" log_error:@""];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    //纪录客户端日志信息
    [BaseInfo addSystemLog:@"程序模块" log_operation:@"切换程序" log_message:@"程序被终止" log_error:@""];
}

#pragma mark - remote notifications

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)token 
{
    //纪录客户端推送标示，将其写入至配置文件
    NSString *iPadDeviceToken = [NSString stringWithFormat:@"%@", token];
    if ((iPadDeviceToken != nil) && (![iPadDeviceToken isEqualToString:@""])) {
        [ConfigInfo setConfigValue:iPadDeviceToken key:kiPadDeviceToken];
    }
    //NSLog(@"注册推送成功:%@", iPadDeviceToken);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error 
{
    //NSLog(@"注册推送失败:%@", error);    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //NSLog(@"接受推送消息:%@", userInfo);
    
    //获取接受推送消息，并且弹出提示
    NSDictionary *aps = [userInfo objectForKey:@"aps"];
    if (aps) {
        NSString *alert = [aps objectForKey:@"alert"];
        //推送消息非空，则弹出提示信息
        if (alert && (![alert isEqualToString:@""])) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"更新摘要" message:alert delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
}



@end
