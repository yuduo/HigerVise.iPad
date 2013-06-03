//
//  BookshelfViewController.m
//  GridViewTabTest
//
//  Created by Tom HU on 2012/12/21.
//  Copyright (c) 2012年 Tom HU. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ResourceViewController.h"
#import "GMGridView.h"

#import "REPhotoCollectionController.h"
#import "Photo.h"
#import "ThumbnailView.h"
#import "ASIHTTPRequest.h"
#import "DownloadFileManage.h"
#import "LSCollectionViewController.h"
#import "client_book.h"
#import "AddBookToLocal.h"
#import "UINavigationBar+Customized.h"
#import "catogory_list_model.h"
#import "BookshelfViewController.h"
#import "client_catgory.h"
#import "book_list_model.h"

#define GRID_VIEW_WIDTH 768
#define GRID_VIEW_HEIGHT 1024-200
#define BOOK_WIDTH 130
#define BOOK_HEIGHT 175
#define SHELF_HEIGHT 234
#define SEARCH_BAR_HEIGHT 38
#define CATEGORY_HEIGHT 80
#define kNum 2
#define RESOURCE_CATEGORY_BUTTON_COLOR  LSRGBA(119,79,46,1)
//////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark ViewController (privates methods)
//////////////////////////////////////////////////////////////

//@interface BookshelfViewController () <GMGridViewDataSource, GMGridViewSortingDelegate, GMGridViewTransformationDelegate, GMGridViewActionDelegate>
//{
//    __gm_weak GMGridView *_gmGridView;
//    
//    
//}
//@end

//////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark ViewController implementation
//////////////////////////////////////////////////////////////

@implementation ResourceViewController

//////////////////////////////////////////////////////////////
#pragma mark controller events
//////////////////////////////////////////////////////////////
@synthesize data = _data;
-(id)init
{
    self = [super init];
    _data = [[NSMutableArray alloc] init];
    bookViewArray = [[NSMutableArray alloc]init];
    
    netWorkQueue  = [[ASINetworkQueue alloc] init];
	[netWorkQueue reset];
	[netWorkQueue setShowAccurateProgress:YES];
	[netWorkQueue go];
    readAllBooks = [[ReadAllBook alloc]init];
    readAllBooks.viewSource = self;
    searchData = [[NSMutableArray alloc] init];
    markArray = [[NSMutableArray alloc] init];
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, (bLandScape == YES ? 1024 : 768), 60)];
//    self.navigationItem.title = @"书库";
    
    UIBarButtonItem *shelfItem  = [[UIBarButtonItem alloc] initWithCustomWithTitle:@"我的书架"
                                                                                    bgImage:[UIImage imageNamed:@"button.png"]
                                                                                     target:self
                                                                                     action:@selector(editButtonClicked)];
    
    [self.navigationItem setHidesBackButton:YES animated:NO];
//    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithCustom:[UIImage imageNamed:@"back.png"]
//                                                                                  bgImage:[UIImage imageNamed:@"back.png"]
//                                                                                   target:self
//                                                                                   action:@selector(backButtonClicked)];

    
//    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Title_hor.png"]];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Title_hor.png"] forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomWithTitle:@"+"
                                    bgImage:[UIImage imageNamed:@"button.png"]
                                     target:self
                                     action:@selector(addButtonClicked)];
    

#if 1
    controlArray = [[NSMutableArray alloc]init];
    
#else
    NSArray* arr = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"button.png"], [UIImage   imageNamed:@"button.png"], nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:arr];
    [segmentedControl addTarget:self action:@selector(action)   forControlEvents:UIControlEventValueChanged];
    [segmentedControl setSegmentedControlStyle:UISegmentedControlStyleBar];
    
    UIBarButtonItem *rb = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];
    [self.navigationItem setRightBarButtonItem:rb];
#endif
    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"resource_background.png"]];
    
    
    UIDeviceOrientation interfaceOrientation=[[UIApplication sharedApplication] statusBarOrientation];
    if (interfaceOrientation == UIDeviceOrientationPortrait || interfaceOrientation == UIDeviceOrientationPortraitUpsideDown) {
        //翻转为竖屏时
        bLandScape = NO;
    }else if (interfaceOrientation==UIDeviceOrientationLandscapeLeft || interfaceOrientation == UIDeviceOrientationLandscapeRight) {
        //翻转为横屏时
        bLandScape = YES;
    }
    
    // 创建uitableview
    if(!tbView){
        tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, (bLandScape == YES ? 1024 : 768), (bLandScape == YES ? 768 : 1024)) style:UITableViewStylePlain];
        tbView.delegate = self;
        tbView.dataSource = self;
        // 设置table的分割符透明
        tbView.separatorColor = [UIColor clearColor];
        // 设置table背景透明
        tbView.backgroundColor = [UIColor clearColor];
        tbView.showsVerticalScrollIndicator = NO;
    }

    [self.view addSubview:tbView];
    


    
    

    
    //time button
#if 0
    UIButton *time = [[UIButton alloc]initWithFrame:CGRectMake(400, 0, 68, 40)];
    time.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"button.png"]];
    //name button
    UIButton *name = [[UIButton alloc]initWithFrame:CGRectMake(400+75, 0, 68, 40)];
    name.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"button.png"]];
    //catogory button
    UIButton *catory = [[UIButton alloc]initWithFrame:CGRectMake(400+150, 0, 68, 40)];
    catory.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"button.png"]];
    [time setTitle:@"时间" forState:UIControlStateNormal];
    [name setTitle:@"名称" forState:UIControlStateNormal];
    [catory setTitle:@"分类" forState:UIControlStateNormal];
    
    [time addTarget:self action:@selector(timeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [name addTarget:self action:@selector(nameButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [catory addTarget:self action:@selector(catoryButtonClick) forControlEvents:UIControlEventTouchUpInside];

#endif
    
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(((bLandScape == YES ? 1024 : 768) -331)/2, 30, 331, SEARCH_BAR_HEIGHT)];
    searchBar.delegate = self;
    [[searchBar.subviews objectAtIndex:0] removeFromSuperview];
    for (UIView *subview in searchBar.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subview removeFromSuperview];
            break;
        }
    }
    [searchBar setTranslucent:YES];
//    searchBar.backgroundImage = [UIImage imageNamed:@"searchBar.png"];
    [searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"searchBar"] forState:UIControlStateNormal];
//    [[searchBar.subviews objectAtIndex:0] setAlpha:0.0];
    //3自定义背景
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchBar.png"]];
//    [searchBar insertSubview:imageView atIndex:1];


    
//    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
//    
//    searchDisplayController.delegate = self;
//    searchDisplayController.searchResultsDataSource = self;
    
    
//    searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bLandScape == YES ? 1024 : 768, SEARCH_BAR_HEIGHT)];
//
//    searchView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"search_bg.png"]];
    
#if 0
    [searchView addSubview:time];
    [searchView addSubview:name];
    [searchView addSubview:catory];
#endif
//    [searchView addSubview:searchBar];
    
//    tbView.tableHeaderView = searchView;
//    [self.view addSubview:searchView];
    
//
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
//
    
//    CGRect bounds = [tbView bounds];
//    bounds.origin.y += searchBar.bounds.size.height;
//    [tbView setBounds:bounds];
    
    addButtonState = NO;
    
    categoryView = [[UIView alloc]initWithFrame:CGRectMake(0, SEARCH_BAR_HEIGHT, bLandScape == YES ? 1024 : 768, CATEGORY_HEIGHT)];
//    categoryView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"category_bg.png"]];

    [self addButtonToCategory];
    int OFFSET = 20;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 60, bLandScape == YES ? 1024 : 768, 130+40)];
    
//    searchView.frame = CGRectMake(0, SEARCH_BAR_HEIGHT, bLandScape == YES ? 1024 : 768, SEARCH_BAR_HEIGHT);
    categoryView.frame = CGRectMake(0, SEARCH_BAR_HEIGHT*2+OFFSET, bLandScape == YES ? 1024 : 768, CATEGORY_HEIGHT);
    UIImageView *slice = [[UIImageView alloc]initWithFrame:CGRectMake(0, SEARCH_BAR_HEIGHT+10, 1024, 4)];
    slice.image = [UIImage imageNamed:@"hor_slice.png"];
//    slice.frame = CGRectMake(0, SEARCH_BAR_HEIGHT+10, bLandScape == YES ? 1024 : 768, 4);
    [categoryView addSubview:slice];
    [view addSubview:searchBar];
//    [view addSubview:searchView];
    [view addSubview:categoryView];
    tbView.tableHeaderView = view;
    
//    CGRect bounds = [tbView bounds];
//    bounds.origin.y += searchBar.bounds.size.height;
//    [tbView setBounds:bounds];
}
-(void)addControlToNavi
{
    {
        UIImageView *view = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bookstore.png"]];
        view.frame = CGRectMake(((bLandScape == YES ? 1024 : 768)-67)/2+10, 10, 67, 40);
        view.tag = 1;
        [self.navigationController.navigationBar addSubview:view];
        [controlArray addObject:view];
    }
    UIImageView *logo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo.png"]];
    logo.frame = CGRectMake(10+6, 10, 190, 40);
    logo.tag = 2;
    [self.navigationController.navigationBar addSubview:logo];
    [controlArray addObject:logo];
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame = CGRectMake(573+12, 11, 50, 40);
    btnBack.tag = 3;
    [btnBack setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"add" ofType:@"png"]] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:btnBack];
    [controlArray addObject:btnBack];
    UIButton *btnHome = [UIButton buttonWithType:UIButtonTypeCustom];
    btnHome.frame = CGRectMake(653, 11, 97, 40);
    btnHome.tag = 4;
    [btnHome setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"button_mybook" ofType:@"png"]] forState:UIControlStateNormal];
    [btnHome addTarget:self action:@selector(editButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:btnHome];
    [controlArray addObject:btnHome];
}
-(void)resetControlPosition
{
    
    
    for (int i = 0; i < [controlArray count]; i ++) {
        UIView *view = [controlArray objectAtIndex:i];
        int tag = view.tag;
        switch (tag) {
            case 1:
                [view setFrame:bLandScape == YES ? CGRectMake((1024-67)/2+10, 10, 67, 40):CGRectMake((768-67)/2+10, 10, 67, 40)];
                break;
            case 2:
                [view setFrame:bLandScape == YES ? CGRectMake(10+6, 10, 190, 40):CGRectMake(10+6, 10, 190, 40)];
                break;
            case 3:
                [view setFrame:bLandScape == YES ? CGRectMake(825+12, 11, 66, 38):CGRectMake(573+12, 11, 66, 38)];
                break;
            case 4:
                [view setFrame:bLandScape == YES ? CGRectMake(904, 11, 97, 40):CGRectMake(653, 11, 97, 40)];
                break;
            default:
                break;
        }
    }
}
- (void)viewDidUnload
{
    [super viewDidUnload];
//    _gmGridView = nil;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIDeviceOrientation interfaceOrientation=[[UIApplication sharedApplication] statusBarOrientation];
    if (interfaceOrientation == UIDeviceOrientationPortrait || interfaceOrientation == UIDeviceOrientationPortraitUpsideDown) {
        //翻转为竖屏时
        bLandScape = NO;
    }else if (interfaceOrientation==UIDeviceOrientationLandscapeLeft || interfaceOrientation == UIDeviceOrientationLandscapeRight) {
        //翻转为横屏时
        bLandScape = YES;
    }
    [self addControlToNavi];
    [self resetControlPosition];
    //update
    
    [self updateTableView:interfaceOrientation];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, (bLandScape == YES ? 1024 : 768), 60)];

    self.navigationController.navigationBarHidden = NO;
    is_searching = NO;
//    searchBar.frame = CGRectMake(0, 0, 331, SEARCH_BAR_HEIGHT);
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    for (int i = 0; i < [controlArray count]; i ++) {
        
        [(UIView*)[controlArray objectAtIndex:i] removeFromSuperview];
    }

    
    [self stopAllDownload];
    
    if (![markArray count]) {
        return;
    }
    NSString *sql = @"(";
    for (int i = 0; i < [markArray count]; i ++) {
        sql = [sql stringByAppendingFormat:@"%@",[markArray objectAtIndex:i]];
        if (i < [markArray count]-1) {
            sql = [sql stringByAppendingString:@","];
        }
    }
    sql = [sql stringByAppendingString:@")"];
    [book_list_model updateBookListMarked:sql];
    
}
//////////////////////////////////////////////////////////////
#pragma mark memory management
//////////////////////////////////////////////////////////////

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


//////////////////////////////////////////////////////////////
#pragma mark GMGridViewDataSource
//////////////////////////////////////////////////////////////

//- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
//{
//    return [_data count];
//}
//
//- (CGSize)sizeForItemsInGMGridView:(GMGridView *)gridView
//{
//    return CGSizeMake(BOOK_WIDTH, BOOK_HEIGHT);
//}
//
//- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
//{
//    //NSLog(@"Creating view indx %d", index);
//    
//    CGSize size = [self sizeForItemsInGMGridView:gridView];
//    
//    GMGridViewCell *cell = [gridView dequeueReusableCell];
//    
//    if (!cell)
//    {
//        cell = [[GMGridViewCell alloc] init];
//        cell.deleteButtonIcon = [UIImage imageNamed:@"close_x.png"];
//        cell.deleteButtonOffset = CGPointMake(-15, -15);
//        
//        UIImageView *bookView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Book_Cover.png"]];
//        [bookView setFrame:CGRectMake(0, 0, size.width,size.height)];
//        
//        cell.contentView = bookView;
////        MyBookView *book = [[MyBookView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
////        cell.contentView = book;
//    }
//    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(20, size.height+10, 100, 20)];
////    [button setBackgroundColor:[UIColor clearColor]];
//    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [button setTitle:@"download" forState:UIControlStateNormal];
//    button.tag = index;
//    [button addTarget:self action:@selector(downLoadButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.contentView addSubview:button];
//    
//    UILabel *myTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(-40, size.height+10, 90, 21)];
//    myTitleLabel.backgroundColor = [UIColor clearColor];
//    myTitleLabel.text = @"title";
//    myTitleLabel.textAlignment = UITextAlignmentCenter;
//
//    [cell.contentView addSubview:myTitleLabel];
//    
////    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    
//    return cell;
//}
//
//- (void)GMGridView:(GMGridView *)gridView deleteItemAtIndex:(NSInteger)index
//{
//    [_data removeObjectAtIndex:index];
//}
//
////////////////////////////////////////////////////////////////
//#pragma mark GMGridViewActionDelegate
////////////////////////////////////////////////////////////////
//
//- (void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
//{
//    NSLog(@"Did tap at index %d", position);
//    //download function
//    
//}
//
//
//
////////////////////////////////////////////////////////////////
//#pragma mark GMGridViewSortingDelegate
////////////////////////////////////////////////////////////////
//
//- (void)GMGridView:(GMGridView *)gridView didStartMovingCell:(GMGridViewCell *)cell
//{
//    [UIView animateWithDuration:0.3
//                          delay:0
//                        options:UIViewAnimationOptionAllowUserInteraction
//                     animations:^{
//                         cell.contentView.backgroundColor = [UIColor orangeColor];
//                         cell.contentView.layer.shadowOpacity = 0.7;
//                     }
//                     completion:nil
//     ];
//}
//
//- (void)GMGridView:(GMGridView *)gridView didEndMovingCell:(GMGridViewCell *)cell
//{
//    [UIView animateWithDuration:0.3
//                          delay:0
//                        options:UIViewAnimationOptionAllowUserInteraction
//                     animations:^{
//                         cell.contentView.backgroundColor = [UIColor redColor];
//                         cell.contentView.layer.shadowOpacity = 0;
//                     }
//                     completion:nil
//     ];
//}
//
//- (BOOL)GMGridView:(GMGridView *)gridView shouldAllowShakingBehaviorWhenMovingCell:(GMGridViewCell *)cell atIndex:(NSInteger)index
//{
//    return YES;
//}
//
//- (void)GMGridView:(GMGridView *)gridView moveItemAtIndex:(NSInteger)oldIndex toIndex:(NSInteger)newIndex
//{
//    NSObject *object = [_data objectAtIndex:oldIndex];
//    [_data removeObject:object];
//    [_data insertObject:object atIndex:newIndex];
//}
//
//- (void)GMGridView:(GMGridView *)gridView exchangeItemAtIndex:(NSInteger)index1 withItemAtIndex:(NSInteger)index2
//{
//    [_data exchangeObjectAtIndex:index1 withObjectAtIndex:index2];
//}
//
//
////////////////////////////////////////////////////////////////
//#pragma mark DraggableGridViewTransformingDelegate
////////////////////////////////////////////////////////////////
//
//- (CGSize)GMGridView:(GMGridView *)gridView sizeInFullSizeForCell:(GMGridViewCell *)cell atIndex:(NSInteger)index
//{
//    return CGSizeMake(GRID_VIEW_WIDTH, 310);
//}
//
//- (UIView *)GMGridView:(GMGridView *)gridView fullSizeViewForCell:(GMGridViewCell *)cell atIndex:(NSInteger)index
//{
//    UIView *fullView = [[UIView alloc] init];
//    fullView.backgroundColor = [UIColor yellowColor];
//    fullView.layer.masksToBounds = NO;
//    fullView.layer.cornerRadius = 8;
//    
//    CGSize size = [self GMGridView:gridView sizeInFullSizeForCell:cell atIndex:index];
//    fullView.bounds = CGRectMake(0, 0, size.width, size.height);
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:fullView.bounds];
//    label.text = [NSString stringWithFormat:@"Fullscreen View for cell at index %d", index];
//    label.textAlignment = UITextAlignmentCenter;
//    label.backgroundColor = [UIColor clearColor];
//    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    label.font = [UIFont boldSystemFontOfSize:15];
//    
//    [fullView addSubview:label];
//    
//    return fullView;
//}
//
//- (void)GMGridView:(GMGridView *)gridView didStartTransformingCell:(GMGridViewCell *)cell
//{
//    [UIView animateWithDuration:0.5
//                          delay:0
//                        options:UIViewAnimationOptionAllowUserInteraction
//                     animations:^{
//                         cell.contentView.backgroundColor = [UIColor blueColor];
//                         cell.contentView.layer.shadowOpacity = 0.7;
//                     }
//                     completion:nil];
//}
//
//- (void)GMGridView:(GMGridView *)gridView didEndTransformingCell:(GMGridViewCell *)cell
//{
//    [UIView animateWithDuration:0.5
//                          delay:0
//                        options:UIViewAnimationOptionAllowUserInteraction
//                     animations:^{
//                         cell.contentView.backgroundColor = [UIColor redColor];
//                         cell.contentView.layer.shadowOpacity = 0;
//                     }
//                     completion:nil];
//}
//
//- (void)GMGridView:(GMGridView *)gridView didEnterFullSizeForCell:(UIView *)cell
//{
//    
//}


#pragma mark ReaderViewControllerDelegate

- (void)dismissReaderViewController:(ReaderViewController *)viewController
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, (bLandScape == YES ? 1024 : 768), 60)];
}


- (NSMutableArray *)prepareDatasource
{
    NSMutableArray *datasource = [[NSMutableArray alloc] init];
    [datasource addObject:[Photo photoWithURLString:@"http://distilleryimage6.s3.amazonaws.com/5acf0f48d5ac11e1a3461231381315e1_5.jpg"
                                               date:nil]];
    [datasource addObject:[Photo photoWithURLString:@"http://distilleryimage0.s3.amazonaws.com/622c57d4ced411e1ae7122000a1e86bb_5.jpg"
                                               date:nil]];
    [datasource addObject:[Photo photoWithURLString:@"http://distilleryimage7.s3.amazonaws.com/1a8f3db4b87811e1ab011231381052c0_5.jpg"
                                               date:nil]];
    [datasource addObject:[Photo photoWithURLString:@"http://distilleryimage6.s3.amazonaws.com/c0039594b74011e181bd12313817987b_5.jpg"
                                               date:nil]];
    [datasource addObject:[Photo photoWithURLString:@"http://distilleryimage10.s3.amazonaws.com/b9e61198b69411e180d51231380fcd7e_5.jpg"
                                               date:nil]];
    [datasource addObject:[Photo photoWithURLString:@"http://distilleryimage3.s3.amazonaws.com/334b13f4b5ae11e1abd612313810100a_5.jpg"
                                               date:nil]];
    [datasource addObject:[Photo photoWithURLString:@"http://distilleryimage2.s3.amazonaws.com/9ab3ff16b59911e1b00112313800c5e4_5.jpg"
                                               date:nil]];
    [datasource addObject:[Photo photoWithURLString:@"http://distilleryimage10.s3.amazonaws.com/e02206c8b59511e1be6a12313820455d_5.jpg"
                                               date:nil]];
    [datasource addObject:[Photo photoWithURLString:@"http://distilleryimage9.s3.amazonaws.com/3b9c9182b53a11e1be6a12313820455d_5.jpg"
                                               date:nil]];
    [datasource addObject:[Photo photoWithURLString:@"http://distilleryimage6.s3.amazonaws.com/93f1fab2b4b711e192e91231381b3d7a_5.jpg"
                                               date:nil]];
    return datasource;
}


-(void)downLoadButtonClick:(UIButton *)button
{
    NSInteger tag = button.tag;
    
}

//=======================处理代码==========================

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSInteger count = 0;
    
    
    if(is_searching){
        
        count = ([searchData count]+kNum-1)/kNum;
//        if (count <= 5) {
//            count = 5;
//        }
        if (bLandScape) {
            count = ([searchData count]+kNum)/(kNum+1);
//            if (count <= 4) {
//                count = 4;
//            }
        }
    }else{
        count = ([_data count]+kNum-1)/kNum;
//        if (count <= 5) {
//            count = 5;
//        }
        if (bLandScape) {
            count = ([_data count]+kNum)/(kNum+1);
//            if (count <= 4) {
//                count = 4;
//            }
        }
    }
    
    return count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"etuancell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (!cell) {
		//cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:identifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        // 取消选择模式
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else{
        // 删除cell中的子对象,刷新覆盖问题。
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    NSLog(@"row = %d",indexPath.row);
    //index = 0, is search bar

    // 定义图书大小
    int kCell_Items_Width = 352;
    int kCell_Items_Height = 175;
    // 设置图片大小206*306
    // 图片与图片之间距离为50
    // 每行3，4本图书
    CGFloat x = 30;
    CGFloat y = 40;
    

    NSInteger nowNum = kNum;
    UIImageView *shelfView = nil;
    
    
    if (bLandScape) {
        nowNum += 1;
        kCell_Items_Width = 315;
        
        shelfView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"resource_cell_hro.png"]];
    }else
    {
        shelfView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"resource_cell_background.png"]];
    }
    cell.backgroundView = shelfView;
    NSInteger row = indexPath.row * nowNum;
    
    NSMutableArray *temp;
     
    if(is_searching){
        temp = searchData;
    }else{
        temp = _data;
    }
    
    for (int i = 0; i<nowNum; ++i) {
        // 跳出循环
        if (row >= [temp count]) {
            break;
        }
        NSDictionary *book = [temp objectAtIndex:row];
        // 展示图片
        ResourceView *bookView = [[ResourceView alloc]initWithFrame:CGRectMake(x, y, kCell_Items_Width, kCell_Items_Height) picturePath:[book valueForKey:@"resource_thum_url"]];
        bookView.picturePath = [book valueForKey:@"resource_thum_url"];
        bookView.bookID = [[book valueForKey:@"resource_master_id"] integerValue];
        bookView.bookName = [book valueForKey:@"resource_title"];
        bookView.bookPath = [book valueForKey:@"resource_url"];
        bookView.bookType = [[book valueForKey:@"resource_type"] integerValue];
        bookView.downloadCompleteStatus = [self checkDownloadState:bookView.bookID bookType:bookView.bookType];
        [bookView setButtonState:[self checkAddButtonState:[[book valueForKey:@"is_marked"] boolValue]]];
        bookView.createTime = [book valueForKey:@"create_time"];
        bookView.imageCount = [NSString stringWithFormat:@"共%@页", [book valueForKey:@"resource_image_count"]];
        bookView.videoDuration = [book valueForKey:@"resource_video_duration"];
        bookView.resourceSize = [NSString stringWithFormat:@"共%@M",[book valueForKey:@"resource_size"]];
        //[[book valueForKey:@"resource_size"] stringByAppendingString:@"M"];
        bookView.delegate = self;
        [bookViewArray addObject:bookView];
        [cell.contentView addSubview:bookView];
        

        x += (11+kCell_Items_Width);
        NSLog(@"x = %f",x);
        // row+1
        ++row;
    }
    
    
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    CGFloat height = 234;
	return 164;
}
- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView
{
    tableView.rowHeight = 234.0f; // or some other height
}
// 测试按钮
- (void) testButton:(id)sender{
    
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


-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
	[self updateTableView:interfaceOrientation];
}
- (BOOL)shouldAutorotate {
    return YES;
}
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}
-(void)updateTableView:(UIInterfaceOrientation)interfaceOrientation
{
    if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
	   interfaceOrientation == UIInterfaceOrientationLandscapeRight)
	{
		bLandScape = YES;
        [self setHorizontalFrame];
	}else {
		bLandScape = NO;
        [self setVerticalFrame];
	}
	tbView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    
    [tbView reloadData];
    searchBar.frame = CGRectMake(((bLandScape == YES ? 1024 : 768) -331)/2, 30, 331, SEARCH_BAR_HEIGHT);
    [self resetControlPosition];
}
//- (void)viewDidLayoutSubviews
//{
//    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, (bLandScape == YES ? 1024 : 768), 60)];
//    UIDeviceOrientation interfaceOrientation=[[UIApplication sharedApplication] statusBarOrientation];
//    if (interfaceOrientation == UIDeviceOrientationPortrait || interfaceOrientation == UIDeviceOrientationPortraitUpsideDown) {
//        //翻转为竖屏时
//        [self setVerticalFrame];
//    }else if (interfaceOrientation==UIDeviceOrientationLandscapeLeft || interfaceOrientation == UIDeviceOrientationLandscapeRight) {
//        //翻转为横屏时
//        [self setHorizontalFrame];
//    }
//
//}
-(void)setVerticalFrame
{
//    tbView.frame = CGRectMake(0, 0, (bLandScape == YES ? 1024 : 768), (bLandScape == YES ? 768 : 1024));
//    [tbView reloadData];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Title_ver.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, (bLandScape == YES ? 1024 : 768), 60)];
}
-(void)setHorizontalFrame
{
//    tbView.frame = CGRectMake(0, 0, (bLandScape == YES ? 1024 : 768), (bLandScape == YES ? 768 : 1024));
//    [tbView reloadData];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Title_hor.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, (bLandScape == YES ? 1024 : 768), 60)];
}

#pragma mark -
#pragma mark MyBookDelegate method

- (void)readBtnOfBookWasClicked:(ResourceView *)book {
    
    NSString *suffix ;
    NSInteger type = book.bookType;
    
    
    
    switch (type) {
        case RESOURCE_TYPE_MP4:
            suffix = @".mp4";
            break;
        case RESOURCE_TYPE_PDF:
            suffix = @".pdf";
            break;

        default:
            break;
    }
    
    
    
    if (type == RESOURCE_TYPE_IMAGE) {
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *savePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"unzip/book_%d",book.bookID]];
        [self searchDocFindPicture:savePath];
        
    }else
    {
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *savePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"book_%d%@",book.bookID,suffix]];
        
        //创建文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //判断temp文件夹是否存在
        BOOL fileExists = [fileManager fileExistsAtPath:savePath];
        
        if (!fileExists) {//如果不存在,下载
            return;
        }
        
        
        [readAllBooks readButtonClicked:type path:savePath];
    }
    
}
-(void)searchDocFindPicture:(NSString*)path
{
    //创建文件管理器
	NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *err;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath: path error: &err];  // path 时绝对路径
    BOOL haveDoc = NO;
    if ([files count]) {
        //have doc
        for (int i = 0; i < [files count]; i ++) {
            NSDictionary *attribs;
            NSString *filepath = [files objectAtIndex:i];
            attribs = [fileManager attributesOfItemAtPath:[path stringByAppendingPathComponent:filepath] error: NULL];
            if ([attribs objectForKey: NSFileType] == NSFileTypeDirectory) {
                [readAllBooks readButtonClicked:RESOURCE_TYPE_IMAGE path:[path stringByAppendingPathComponent:filepath]];
                haveDoc = YES;
                break;
            }
        }
    }
    if (!haveDoc) {
        [readAllBooks readButtonClicked:RESOURCE_TYPE_IMAGE path:path];
    }
}

- (void)downBtnOfBookWasClicked:(ResourceView *)book {//下载,将要下载的书添加到ASINetworkQueue
	
	//初始化Documents路径
	NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
	//初始化临时文件路径
	NSString *folderPath = [path stringByAppendingPathComponent:@"temp"];
	//创建文件管理器
	NSFileManager *fileManager = [NSFileManager defaultManager];
	//判断temp文件夹是否存在
	BOOL fileExists = [fileManager fileExistsAtPath:folderPath];
	
	if (!fileExists) {//如果不存在说创建,因为下载时,不会自动创建文件夹
		[fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
	}
	//初始下载路径
	NSURL *url = [NSURL URLWithString: [book.bookPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	//设置下载路径
	ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
	//设置ASIHTTPRequest代理
	request.delegate = self;
    
    NSString *suffix ;
    NSInteger type = book.bookType;
    switch (type) {
        case RESOURCE_TYPE_MP4:
            suffix = @".mp4";
            break;
        case RESOURCE_TYPE_PDF:
            suffix = @".pdf";
            break;
        case RESOURCE_TYPE_IMAGE:
            suffix = @".zip";
            break;
        default:
            break;
    }
    
	//初始化保存ZIP文件路径
	NSString *savePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"book_%d%@",book.bookID,suffix]];
	//初始化临时文件路径
	NSString *tempPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"temp/book_%d.temp",book.bookID]];
	//设置文件保存路径
	[request setDownloadDestinationPath:savePath];
	//设置临时文件路径
	[request setTemporaryFileDownloadPath:tempPath];
	//设置进度条的代理,
	[request setDownloadProgressDelegate:book];
	//设置是是否支持断点下载
	[request setAllowResumeForFileDownloads:YES];
	//设置基本信息
	[request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:book.bookID],@"bookID",nil]];
	//添加到ASINetworkQueue队列去下载
	[netWorkQueue addOperation:request];
	
}

- (void)pauseBtnOfBookWasClicked:(ResourceView *)book {//暂停下载
	
	for (ASIHTTPRequest *request in [netWorkQueue operations]) {//查找暂停的对象
		
		NSInteger bookid = [[request.userInfo objectForKey:@"bookID"] intValue];//查看userinfo信息
		if (book.bookID == bookid) {//判断ID是否匹配
			//暂停匹配对象
			[request clearDelegatesAndCancel];
		}
	}
}

- (void)markBtnOfBookWasClicked:(ResourceView *)book
{
    [markArray addObject:[NSString stringWithFormat:@"%d",book.bookID]];
    
}
#pragma mark -
#pragma mark ASIHTTPRequestDelegate method

//ASIHTTPRequestDelegate,下载之前获取信息的方法,主要获取下载内容的大小
- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders {
    
	//NSLog(@"didReceiveResponseHeaders-%@",[responseHeaders valueForKey:@"Content-Length"]);
	for (ResourceView *temp in bookViewArray) {//循环出具体对象
		
		if (temp.bookID == [[request.userInfo objectForKey:@"bookID"] intValue]) {
			//查找以前是否保存过 具体对象 内容的大小
			NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
			float tempConLen = [[userDefaults objectForKey:[NSString stringWithFormat:@"book_%d_contentLength",temp.bookID]] floatValue];
			
			if (tempConLen == 0 ) {//如果没有保存,则持久化他的内容大小
				
				[userDefaults setObject:[NSNumber numberWithFloat:request.contentLength/1024.0/1024.0] forKey:[NSString stringWithFormat:@"book_%d_contentLength",temp.bookID]];
			}
		}
	}
}
//ASIHTTPRequestDelegate,下载完成时,执行的方法
- (void)requestFinished:(ASIHTTPRequest *)request {
    
	for (ResourceView *temp in bookViewArray) {//循环出具体对象
		
		if ([temp respondsToSelector:@selector(bookID)]) {
			
			if (temp.bookID == [[request.userInfo objectForKey:@"bookID"] intValue]) {//判断是否与下载完成的对象匹配
				
				temp.downloadCompleteStatus = YES;//如果匹配,则设置他的下载状态为YES
				
				//重绘
				[temp setNeedsDisplay];
                
                
                NSString *suffix = @"";
                NSString *bookPath = temp.bookPath;
                
                switch (temp.bookType) {
                    case RESOURCE_TYPE_MP4:
                        suffix = @"mp4";
                        break;
                    case RESOURCE_TYPE_PDF:
                        suffix = @"pdf";
                        break;
                    case RESOURCE_TYPE_IMAGE:
                        [temp startUnZip];
                        suffix = @"zip";
                        break;
                    default:
                        break;
                }
                NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
                NSString *savePath ;
                if (temp.bookType == RESOURCE_TYPE_IMAGE) {
                    savePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"unzip/book_%d",temp.bookID]];
                }else
                {
                    savePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"book_%d.%@",temp.bookID,suffix]];
                }
                
                
                LSDataBook *book = [[LSDataBook alloc]init];
                book.bookID = temp.bookID;
                book.bookName = temp.bookName;
                book.local_resource = savePath;
                book.bookType = temp.bookType;
                book.logo = temp.picturePath;
                book.createTime = temp.createTime;
                //save to local
                [AddBookToLocal addBookToArray:book];
			}
            
		}
	}
}
//ASIHTTPRequestDelegate,下载失败
- (void)requestFailed:(ASIHTTPRequest *)request {
    
	NSLog(@"down fail.....");
	UIAlertView *alarm = [[UIAlertView alloc]initWithTitle:@"下载失败！" message:@"请检查网络是否连接!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alarm show];
}

-(void)stopAllDownload
{
    for (ASIHTTPRequest *request in [netWorkQueue operations]) {//查找暂停的对象
		
		{//判断ID是否匹配
			//暂停匹配对象
			[request clearDelegatesAndCancel];
		}
	}
}
-(void)backButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)editButtonClicked
{
#if 0
    LSCollectionViewController *ibook = [[LSCollectionViewController alloc]init];
    
    [self.navigationController pushViewController:ibook animated:YES];
#else
    NSArray *db = [book_list_model getMarkedBookList];
    if (db != nil) {
        //
    }
    //go to book
    BookshelfViewController *ibook = [[BookshelfViewController alloc]init];
    ibook.data = [[NSMutableArray alloc]initWithArray: db];
    [self.navigationController pushViewController:ibook animated:YES];
#endif
    
    [self viewWillDisappear:NO];
}
- (LSListProtocolEngine*)protocolEngine
{
    return [[LSCollectPE alloc] init];
}
-(BOOL)checkDownloadState:(NSInteger)bookID bookType:(NSInteger)bookType
{
    //初始化Documents路径
	NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSString *suffix = @"";
    
    switch (bookType) {
        case RESOURCE_TYPE_MP4:
            suffix = @".mp4";
            break;
        case RESOURCE_TYPE_PDF:
            suffix = @".pdf";
            break;
        case RESOURCE_TYPE_IMAGE:
            
            suffix = @"";
            break;
        default:
            break;
    }
    
    //初始化保存ZIP文件路径
	NSString *filePath ;
    if (bookType == RESOURCE_TYPE_IMAGE) {
        filePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"unzip/book_%d",bookID]];
    }else
    {
        filePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"book_%d%@",bookID,suffix]];
    }
    

    
    
    return [self whetherFileExist:filePath];
}
-(BOOL)whetherFileExist:(NSString*)path
{
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //判断temp文件夹是否存在
    BOOL fileExists = [fileManager fileExistsAtPath:path];
    
    return fileExists;
}

-(UIViewController*)getCurrentViewController
{
    return self;
}

#pragma mark - searchDisplayControllerDelegate

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [searchData removeAllObjects];
    
    client_book *group;
    
    for(group in _data)
    {
       
        NSString *element;
        
        element = group.resource_title;
        if(element != nil)
        {
            NSRange range = [element rangeOfString:searchString options:NSCaseInsensitiveSearch];
            
            if (range.length > 0) {
                [searchData addObject:group];
                
            }
        }
        
    }
    
    return YES;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [searchData removeAllObjects];
    if ([searchText length] == 0) {
        is_searching = NO;
        [tbView reloadData];
    }
    client_book *group;
    
    for(group in _data)
    {
        
        NSString *element;
        
        element = group.resource_title;
        if(element != nil)
        {
            NSRange range = [element rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (range.length > 0) {
                [searchData addObject:group];
                is_searching = YES;
                [tbView reloadData];
            }
        }
        
    }
}
-(BOOL)searchBarShouldBeginEditing:(UISearchBar*)searchBar{
    //準備搜尋前，把上面調整的TableView調整回全屏幕的狀態，如果要產生動畫效果，要另外執行animation代碼
    
    return YES;
}
-(BOOL)searchBarShouldEndEditing:(UISearchBar*)searchBar{
    
    //搜尋結束後，恢復原狀，如果要產生動畫效果，要另外執行animation代碼
    
    return YES;
}
-(void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView {
    
}
- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    searchBar.frame = CGRectMake(0, 0, 331, SEARCH_BAR_HEIGHT);
//    [[searchBar.subviews objectAtIndex:1]removeFromSuperview];
}
- (void) searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller;
{
    searchBar.frame = CGRectMake(((bLandScape == YES ? 1024 : 768) -331)/2, 0, 331, SEARCH_BAR_HEIGHT);
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchBar.png"]];
//    [searchBar insertSubview:imageView atIndex:1];
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, (bLandScape == YES ? 1024 : 768), 60)];
}

- (void) timeButtonClick
{
    
}
- (void) nameButtonClick
{
    
}
- (void) catoryButtonClick
{
    categoryButtonState = categoryView.hidden;
    categoryButtonState = !categoryButtonState;
    
    //hiden
//    categoryView.hidden = categoryButtonState;
    categoryView.frame = CGRectMake(0, SEARCH_BAR_HEIGHT, bLandScape == YES ? 1024 : 768, SEARCH_BAR_HEIGHT);
    
}

-(void)addButtonClicked
{
    addButtonState = !addButtonState;
    [tbView reloadData];
}
-(NSInteger)getCaluPageCount:(NSMutableArray*)array
{
    int length = 0;
    for (int i = 0; i < [array count]; i ++) {
        //
        client_catgory *category = [array objectAtIndex:i];
        length += ([self getButtonWidth:category.catgory_name]+25);
    }
    length += 55;
    return 1+length/(bLandScape == YES ? 1024 : 768);
}
-(void)addButtonToCategory
{
    //read database
    NSMutableArray *db = (NSMutableArray*)[catogory_list_model getBookList];
    if (db != nil) {
        //
        
    }
    client_catgory *all = [[client_catgory alloc]init];
    all.catgory_name = @"全部";
    [db insertObject:all atIndex:0];
    
    int BUTTON_COUNT = 5;
    NSInteger count = [db count];
    NSInteger pageCount = [self getCaluPageCount:db];//count/BUTTON_COUNT+1;
//    client_catgory
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, bLandScape == YES ? 1024 : 768, SEARCH_BAR_HEIGHT)];
    scroll.pagingEnabled = YES;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.contentSize = CGSizeMake(scroll.frame.size.width*pageCount, scroll.frame.size.height);
    
    CGRect frame = scroll.bounds;
    frame.origin.y = 0.0f;
    
    
    
    for (int i = 1; i <= pageCount; i ++) {
        //page
        
        UIView *view = [[UIView alloc] initWithFrame:frame];
        frame.origin.x += scroll.frame.size.width*(i-1);
        [view setFrame:frame];
        [scroll addSubview:view];
        int index_x = 0;
        for (int j = 1; j <= BUTTON_COUNT; j ++) {
            
            if (((i-1)*BUTTON_COUNT+j) > count) {
                break;
            }
            {
            
                client_catgory *category = [db objectAtIndex:(i-1)*BUTTON_COUNT+(j-1)];
                
                NSLog(@"name = %@",category.catgory_name);
                //button
                int len = [self getButtonWidth:category.catgory_name];
                NSLog(@"len = %d",len);
                
                UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(55+index_x, 0, len, 40)];
                [button setTitle:category.catgory_name forState:UIControlStateNormal];
                UIImage *buttonBack = nil;
                if (len == 102) {
                    buttonBack = [UIImage imageNamed:@"button_three.png"];
                }else if (len == 118) {
                    buttonBack = [UIImage imageNamed:@"button_four.png"];
                }else
                {
                    buttonBack = [UIImage imageNamed:@"category_button.png"];
                }
                    
                [button setBackgroundImage:i == 1 && j == 1 ? buttonBack : [UIImage imageNamed:@"category_all.png"] forState:UIControlStateNormal];
                [button setTitleColor:i == 1 && j == 1 ?[UIColor whiteColor]:RESOURCE_CATEGORY_BUTTON_COLOR forState:UIControlStateNormal];
                button.tag = (i-1)*BUTTON_COUNT+(j-1);
                [button addTarget:self action:@selector(categoryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:button];
                
                index_x += (len+22);
            }
        }
        
    }
    [categoryView addSubview:scroll];
//    [self.view addSubview:categoryView];
}
-(NSInteger)getButtonWidth:(NSString*)str
{
    switch (str.length) {
        case 1:
            return 87;
            break;
        case 2:
            return 87;
            break;
        case 3:
            return 102;
            break;
        case 4:
            return 118;
            break;
        default:
            break;
    }
    
    return str.length*30;
}
-(void)categoryButtonClick:(UIButton*)button
{
    NSInteger tag = button.tag;
    NSArray *db = nil;
    if (tag == 0) {
        db = [book_list_model getBookListAll];
    }else
    {
        db = [book_list_model getBookList:tag];
    }
    if (db != nil) {
        //
    }
    self.data  = nil;
    self.data = [[NSMutableArray alloc]initWithArray: db];
    [tbView reloadData];
}

-(BOOL)checkAddButtonState:(BOOL)buttonState
{
    if (addButtonState) {
        //if added
        return buttonState;
    }
    return !addButtonState;
}
@end