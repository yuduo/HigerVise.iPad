//
//  LSBaseViewController.h
//  Test1
//
//  Created by yongchang hu on 12-3-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RJViewUtils.h"
#import "LSModalView.h"
#import "LSDefine.h"
#import "LSData.h" //此头文件引入只是为了LSBaseViewController的子类不再需要引入

#import "LSBaseProtocolEngine.h"
#import "LSViewUtils.h"
#import "LSModalView.h"

typedef enum
{
    LSNavigationbarButtonItem_Left,
    LSNavigationbarButtonItem_Right
}LSNavigationbarButtonItemType;

@class MBProgressHUD;
@interface LSBaseViewController : UIViewController
<LSBaseProtocolEngineDelegate>
{
    MBProgressHUD* _hud;
    BOOL _isWaiting;
}
- (void)makeWindowUserInteractionEnabled:(BOOL)aBlock;
- (void)makeViewUserInteractionEnabled:(BOOL)aBlock;
- (void)startWaiting;
- (void)stopWaiting;
- (BOOL)isWaiting;
- (void)startHUDWaiting:(NSString*)aText;//阻塞UI的等待
- (void)setHUDWaitingText:(NSString*)aText;
- (void)setHUDWaitingDetailText:(NSString *)aText;

- (void)makeComponentViewEnabled:(BOOL)aEnabled;//default is noop.it's called by startWaiting or stopWaiting.

- (void)setNavigationBarButtonItemWithImage:(UIImage*)aIcon itemType:(LSNavigationbarButtonItemType)aType;
- (void)setNavigationBarButtonItemWithImage:(UIImage*)aIcon itemType:(LSNavigationbarButtonItemType)aType bgImage:(UIImage*)aBg;
- (void)setNavigationBarButtonItemWithTitle:(NSString*)aTitle itemType:(LSNavigationbarButtonItemType)aType;

- (void)setNavigationBarButtonItemWithTitleStytlePlain:(NSString*)aTitle itemType:(LSNavigationbarButtonItemType)aType;


- (void)setnavigationLeftButtonItemWithBack;
- (void)navigationLeftButtonItemClicked:(id)aSender;//default is back to pre-view
- (void)navigationRightButtonItemClicked:(id)aSender;//default is noop

//-----protocol enging-----
- (void)defaultDidProtocolEngineSuccess;
- (void)defaultDidProtocolEngineFailed:(NSError*)aError;
- (BOOL)didLoginExpired:(NSError*)aError;
@end