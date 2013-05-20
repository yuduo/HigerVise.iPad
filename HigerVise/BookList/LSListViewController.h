//
//  LSListViewController.h
//  Locoso
//
//  Created by yongchang hu on 12-3-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSImagesViewController.h"
#import "LSListProtocolEngine.h"
#import "UITableView+LSAddiational.h"

@interface LSListViewController : LSImagesViewController
<LSBaseProtocolEngineDelegate, UITableViewDelegate, UITableViewDataSource>
{
    LSListProtocolEngine* _listPE;
    UITableView* _tableView;
    
    BOOL _morePage;
    
    BOOL _showPromptIfNoData;
    UIView* _nodataPromptView;
    NSString* _nodataPromptString;
    
    BOOL _needRefreshEvenIfHaveData;//有数据也要刷新。用来解决某些页面“返回”时需要更新的问题
}
@property (nonatomic) BOOL morePage;//是否使用分页功能
@property (nonatomic) BOOL showPromptIfNoData;
@property (nonatomic, retain) UIView* nodataPromptView;
@property (nonatomic, retain) NSString* nodataPromptString;

@property (nonatomic) BOOL needRefreshEvenIfHaveData;

- (void)loadComponentViews;
- (void)reloadComponentViews;
- (UITableView*)tableView;
- (BOOL)checkNeedShowMoreButton:(id)aNewData;


//-----子类重载------
- (LSListProtocolEngine*)protocolEngine;//noop
- (void)setProtocolEngineParams:(LSListProtocolEngine*)aEngine;//noop.viewWillAppear中被调用
- (void)didMoreButtonClicked;//noop
@end
