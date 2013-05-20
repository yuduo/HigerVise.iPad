//
//  LSBaseViewController.m
//  Test1
//
//  Created by yongchang hu on 12-3-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSBaseViewController.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"

#define RJBaseViewControllerWaitingViewTag 9999
#define RJBaseViewControllerHUDView 9998
@implementation LSBaseViewController

#pragma mark interface
- (void)makeWindowUserInteractionEnabled:(BOOL)aBlock
{
//    [UIApplication sharedApplication].keyWindow.userInteractionEnabled = aBlock;
    UIWindow* window = ((AppDelegate*)([UIApplication sharedApplication].delegate)).window;
    window.userInteractionEnabled = aBlock;
}

- (void)makeViewUserInteractionEnabled:(BOOL)aBlock
{
    self.view.userInteractionEnabled = aBlock;
}

- (void)startWaiting
{
    if ([self isWaiting])
    {
        return;
    }
    
    UIActivityIndicatorView* waitingView = nil;
    UIView* view = [self.view viewWithTag:RJBaseViewControllerWaitingViewTag];
    if (nil == view)
    {
        waitingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        waitingView.hidesWhenStopped = YES;
        waitingView.tag = RJBaseViewControllerWaitingViewTag;
        waitingView.frame = CGRectMake(0,0,50,50);
        waitingView.center = self.view.center;
        [self.view addSubview:waitingView];
        [waitingView release];
    }
    
    [waitingView startAnimating];
    _isWaiting = YES;
    [self makeComponentViewEnabled:NO];
}

- (void)stopWaiting
{
    UIActivityIndicatorView*  waitingView = (UIActivityIndicatorView*)[self.view viewWithTag:RJBaseViewControllerWaitingViewTag];
    if (waitingView)
    {
        [waitingView stopAnimating];
    }
    [waitingView removeFromSuperview];
    waitingView = nil;
    
    UIWindow* window = ((AppDelegate*)([UIApplication sharedApplication].delegate)).window;
    [MBProgressHUD hideHUDForView:window animated:YES];
    [_hud release];
    _hud = nil;
    
    _isWaiting = NO;
    [self makeComponentViewEnabled:YES];
}

- (BOOL)isWaiting
{
    return _isWaiting;
}

- (void)startHUDWaiting:(NSString*)aText
{
    if ([self isWaiting])
    {
        return;
    }
    
    UIWindow* window = ((AppDelegate*)([UIApplication sharedApplication].delegate)).window;
    _hud = [[MBProgressHUD alloc] initWithView:window];
	[window addSubview:_hud];
    _hud.labelText = aText;
	[_hud show:YES];
}

- (void)setHUDWaitingText:(NSString*)aText
{
    _hud.labelText = aText;
}

- (void)setHUDWaitingDetailText:(NSString *)aText
{
    _hud.detailsLabelText = aText;
}

- (void)makeComponentViewEnabled:(BOOL)aEnabled
{
}

- (void)setNavigationBarButtonItemWithImage:(UIImage*)aIcon itemType:(LSNavigationbarButtonItemType)aType
{
//    [self setNavigationBarButtonItemWithImage:aIcon itemType:aType bgImage:LSImageByName(LSImage_bg_nav_item)];
}

- (void)setNavigationBarButtonItemWithImage:(UIImage*)aIcon itemType:(LSNavigationbarButtonItemType)aType bgImage:(UIImage*)aBg
{
    UIBarButtonItem* item = nil;
    if (LSNavigationbarButtonItem_Left == aType)
    {
        item = [[UIBarButtonItem alloc] initWithCustom:aIcon 
                                               bgImage:aBg 
                                                target:self 
                                                action:@selector(navigationLeftButtonItemClicked:)];
        self.navigationItem.leftBarButtonItem = item;
        
    }
    else if (LSNavigationbarButtonItem_Right == aType)
    {
        item = [[UIBarButtonItem alloc] initWithCustom:aIcon 
                                               bgImage:aBg 
                                                target:self 
                                                action:@selector(navigationRightButtonItemClicked:)];
        self.navigationItem.rightBarButtonItem = item;
    }
    
    [item release];
}

- (void)setNavigationBarButtonItemWithTitle:(NSString*)aTitle itemType:(LSNavigationbarButtonItemType)aType 
{
//    UIBarButtonItem* item = nil;
//    if (LSNavigationbarButtonItem_Left == aType)
//    {
//        item = [[UIBarButtonItem alloc] initWithCustomWithTitle:aTitle 
//                                                        bgImage:LSImageByName(LSImage_bg_nav_item) 
//                                                         target:self 
//                                                         action:@selector(navigationLeftButtonItemClicked:)];
//        self.navigationItem.leftBarButtonItem = item;
//        
//    }
//    else if (LSNavigationbarButtonItem_Right == aType)
//    {
//        item = [[UIBarButtonItem alloc] initWithCustomWithTitle:aTitle 
//                                                        bgImage:LSImageByName(LSImage_bg_nav_item)
//                                                         target:self 
//                                                         action:@selector(navigationRightButtonItemClicked:)];
//        self.navigationItem.rightBarButtonItem = item;
//    }
//    
//    [item release];
}

- (void)setNavigationBarButtonItemWithTitleStytlePlain:(NSString*)aTitle itemType:(LSNavigationbarButtonItemType)aType
{
    UIBarButtonItem* item = nil;
    if (LSNavigationbarButtonItem_Left == aType)
    {
        item = [[UIBarButtonItem alloc] initWithTitle:aTitle style:UIBarButtonItemStylePlain target:self action:@selector(navigationLeftButtonItemClicked:)];
        self.navigationItem.leftBarButtonItem = item;
        
    }
    else if (LSNavigationbarButtonItem_Right == aType)
    {
        item = [[UIBarButtonItem alloc] initWithTitle:aTitle style:UIBarButtonItemStylePlain target:self action:@selector(navigationRightButtonItemClicked:)];
        self.navigationItem.rightBarButtonItem = item;
    }
    [item release]; 
}

- (void)setnavigationLeftButtonItemWithBack
{
//    [self setNavigationBarButtonItemWithImage:LSImageByName(LSImage_icon_nav_item_back)  itemType:LSNavigationbarButtonItem_Left bgImage:nil];
    [self setNavigationBarButtonItemWithTitle:@"返回" itemType:LSNavigationbarButtonItem_Left];
}

- (void)navigationLeftButtonItemClicked:(id)aSender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)navigationRightButtonItemClicked:(id)aSender
{
    //noop
}

#pragma mark Protocol Enging
- (void)didProtocolEngineFinished:(LSBaseProtocolEngine*)aEngine newData:(id)aData
{
    [self defaultDidProtocolEngineSuccess];
}

- (void)didProtocolEngineFailed:(LSBaseProtocolEngine *)aEngine error:(NSError*)aError
{
    if (![self didLoginExpired:aError])
    {
        [self defaultDidProtocolEngineFailed:aError];
    }
}

- (void)defaultDidProtocolEngineSuccess
{
    [self stopWaiting];
}

- (void)defaultDidProtocolEngineFailed:(NSError*)aError
{
    [self stopWaiting];
    NSLog(@"%s %@",__FUNCTION__, aError);
    NSString* errString = nil;
    if ([aError.domain isEqualToString:LSErrorDomain])
    {
        errString = [aError.userInfo valueForKey:NSLocalizedDescriptionKey];
    }
    else 
    {
        errString = LSErrorString_NetworkFailed;
    }
    NSAssert(errString, @"");
    [LSModalAlertView messageBox:nil message:errString];
}

- (BOOL)didLoginExpired:(NSError*)aError
{
    if (aError.code == 110500)//登录失效
    {
//        NSInteger ret = [LSModalAlertView confirmMessageBox:nil message:LSString_loginExpiredConfirm];
//        if (0 != ret)
//        {
//            [[NSNotificationCenter defaultCenter] postNotificationName:LSNOTIFICATION_LOGIN_EXPIRED object:nil];
//        }
        return  YES;
    }
    return NO;
}
@end
