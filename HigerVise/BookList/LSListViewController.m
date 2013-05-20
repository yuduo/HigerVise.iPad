//
//  LSListViewController.m
//  Locoso
//
//  Created by yongchang hu on 12-3-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSListViewController.h"

@implementation LSListViewController
@synthesize morePage = _morePage;
@synthesize showPromptIfNoData = _showPromptIfNoData;
@synthesize nodataPromptView = _nodataPromptView;
@synthesize nodataPromptString = _nodataPromptString;
@synthesize needRefreshEvenIfHaveData = _needRefreshEvenIfHaveData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        _morePage = NO;
        _showPromptIfNoData = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (nil == _listPE)
    {
        _listPE = [self protocolEngine];
        _listPE.delegate = self;
        [_listPE retain];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (nil == _listPE.rspData.arrContent
        || _needRefreshEvenIfHaveData)
    {
        [self setProtocolEngineParams:_listPE];
        [_listPE sendRequest];
        [self startWaiting];
        _needRefreshEvenIfHaveData = NO;
    }
    else
    {
        [self loadComponentViews];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_listPE cancelRequest];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [_tableView release];
    _tableView = nil;
    
    self.nodataPromptView = nil;
}

- (void)dealloc
{
    self.nodataPromptView = nil;
    self.nodataPromptString = nil;
    [_listPE cancelRequest];
    [_listPE release];
    [_tableView release];
    
    [super dealloc];
}
- (void)loadComponentViews
{
    NSLog(@"%s",__FUNCTION__);
    
    if (_showPromptIfNoData)
    {
        if (0 == [_listPE.rspData.arrContent count])
        {
            if (nil == self.nodataPromptView)
            {
                UILabel* lbPrompt = [[UILabel alloc] initWithFrame:CGRectMake(0,0,200,30)];
                lbPrompt.backgroundColor = [UIColor clearColor];
                lbPrompt.textAlignment = UITextAlignmentCenter;
                
                self.nodataPromptView = lbPrompt;
                [lbPrompt release];
                [self.view addSubview:self.nodataPromptView];
                self.nodataPromptView.center = self.view.center;
            }
            else 
            {
                [self.view bringSubviewToFront:self.nodataPromptView];
                self.nodataPromptView.hidden = NO;
            }
            
            [_tableView removeFromSuperview];
            [_tableView release];
            _tableView = nil;
            
            return;
        }
        else 
        {
            self.nodataPromptView.hidden = YES;
        }
    }
    
    if (nil == _tableView)
    {
        _tableView = [self tableView];
        [_tableView retain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        if (_morePage)
        {
            [_tableView addMoreButton:self selector:@selector(didMoreButtonClicked)];
        }
        [self.view addSubview:_tableView];
    }
    else 
    {
        [_tableView reloadData];
    }
}

- (void)reloadComponentViews
{
    [_tableView removeFromSuperview];
    [_tableView release];
    _tableView = nil;
    [self loadComponentViews];
}

- (UITableView*)tableView
{
    return  [[[UITableView alloc] initWithFrame:CGRectMake(0,0,320,460-44-49) style:UITableViewStylePlain] autorelease];
}

- (BOOL)checkNeedShowMoreButton:(id)aNewData
{
    LSListRspData* rspData = (LSListRspData*)aNewData;
    BOOL hidden = [rspData.arrContent count] < _listPE.pageSize;
    return hidden;
}

- (void)didMoreButtonClicked
{
    [self startWaiting];
    NSInteger curPageNo = ([_listPE.rspData.arrContent count] / _listPE.pageSize) + 1;
    _listPE.pageNo = curPageNo;
    _listPE.op = LSProtocolEngineOp_More;
    [_listPE sendRequest];
}

- (void)setShowPromptIfNoData:(BOOL)showPromptIfNoData
{
    _showPromptIfNoData = showPromptIfNoData;
    if (showPromptIfNoData)
    {
        self.nodataPromptView.hidden = NO;
        [self.view bringSubviewToFront:self.nodataPromptView];
    }
    else 
    {
        self.nodataPromptView.hidden = YES;
    }
}

#pragma mark reload by subclass
- (LSListProtocolEngine*)protocolEngine
{
    return [[[LSListProtocolEngine alloc] init] autorelease];
}

- (void)setProtocolEngineParams:(LSListProtocolEngine*)aEngine
{
}

#pragma mark UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_listPE.rspData.arrContent count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark LSBaseProtocolEngineDelegate
- (void)didProtocolEngineFinished:(LSBaseProtocolEngine*)aEngine newData:(id)aData
{
    [self stopWaiting];
    if (_listPE == aEngine)
    {
        if (LSProtocolEngineOp_More == aEngine.op)
        {
            [self loadComponentViews];
        }
        else 
        {
            [self reloadComponentViews];
        }
        [_tableView makeMoreButtonHidden:[self checkNeedShowMoreButton:aData]];
    }
}

- (void)didProtocolEngineFailed:(LSBaseProtocolEngine *)aEngine error:(NSError*)aError
{
    [self stopWaiting];
    if (_listPE == aEngine)
    {
        if ([aError.domain isEqualToString:LSErrorDomain]) 
        {
            if (LSProtocolEngineOp_More == aEngine.op)
            {
                [self loadComponentViews];
            }
            else 
            {
                [self reloadComponentViews];
            }
        }
        else 
        {
            [self defaultDidProtocolEngineFailed:aError];
        }
    }
}
@end
