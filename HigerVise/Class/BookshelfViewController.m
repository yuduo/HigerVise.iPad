//
//  BookshelfViewController.m
//  GridViewTabTest
//
//  Created by Tom HU on 2012/12/21.
//  Copyright (c) 2012年 Tom HU. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "BookshelfViewController.h"
#import "GMGridView.h"

#import "REPhotoCollectionController.h"
#import "Photo.h"
#import "ThumbnailView.h"
#import "ASIHTTPRequest.h"
#import "DownloadFileManage.h"
#import "LSCollectionViewController.h"
#import "client_book.h"
#import "AddBookToLocal.h"
#import "book_list_model.h"
#import "UINavigationBar+Custom.h"

#define GRID_VIEW_WIDTH 768
#define GRID_VIEW_HEIGHT 1024-200
#define BOOK_WIDTH 130
#define BOOK_HEIGHT 175
#define SHELF_HEIGHT 234
#define SEARCH_BAR_HEIGHT 38
#define kNum 4


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

@implementation BookshelfViewController

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
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    [self.navigationItem setHidesBackButton:YES animated:NO];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bookshelf_background.png"]];
//    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Title_hor.png"]];
    
    
//    self.navigationItem.title = @"我的书架";
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomWithTitle:@"下载内容"
//                                                                                      bgImage:[UIImage imageNamed:@"button.png"]
//                                                                                       target:self
//                                                                                       action:@selector(editButtonClicked)];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustom:[UIImage imageNamed:@"back.png"]
//                                                                            bgImage:[UIImage imageNamed:@"back.png"]
//                                                                             target:self
//                                                                             action:@selector(backButtonClicked)];
//
    
    
    UIDeviceOrientation interfaceOrientation=[[UIApplication sharedApplication] statusBarOrientation];
    if (interfaceOrientation == UIDeviceOrientationPortrait || interfaceOrientation == UIDeviceOrientationPortraitUpsideDown) {
        //翻转为竖屏时
        bLandScape = NO;
    }else if (interfaceOrientation==UIDeviceOrientationLandscapeLeft || interfaceOrientation == UIDeviceOrientationLandscapeRight) {
        //翻转为横屏时
        bLandScape = YES;
    }
    UIImageView *background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (bLandScape == YES ? 1024 : 768), (bLandScape == YES ? 768 : 1024))];
    if (bLandScape) {
        background.image = [UIImage imageNamed:@"bookshelf_background.png"];
        
    }else
    {
        background.image = [UIImage imageNamed:@"bookshelf_background_ver.png"];
    }
    self.view.backgroundColor = [UIColor colorWithPatternImage:background.image];
//    [self.view addSubview:background];
    
    // 创建uitableview
    if(!tbView){
        tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, (bLandScape == YES ? 1024 : 768), (bLandScape == YES ? 768 : 1024)) style:UITableViewStylePlain];
        tbView.delegate = self;
        tbView.dataSource = self;
        // 设置table的分割符透明
        tbView.separatorColor = [UIColor clearColor];
        // 设置table背景透明
        tbView.backgroundColor = [UIColor clearColor];
        tbView.showsVerticalScrollIndicator = NO;
    }
    [self.view addSubview:tbView];
    

    
    
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(((bLandScape == YES ? 1024 : 768) -331)/2, 20, 331, SEARCH_BAR_HEIGHT)];
    searchBar.delegate = self;
    [[searchBar.subviews objectAtIndex:0] removeFromSuperview];
    [searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"searchBar"] forState:UIControlStateNormal];

    
    searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bLandScape == YES ? 1024 : 768, SEARCH_BAR_HEIGHT+25)];
    UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shelf_top.png"] ];
    imageview.frame = CGRectMake(0, 20, bLandScape == YES ? 1024 : 768, SEARCH_BAR_HEIGHT+20);
    imageview.tag = 123;
//    [searchView addSubview:imageview];
//    searchView.backgroundColor  = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shelf_top.png"]];
    [searchView addSubview:searchBar];
    tbView.tableHeaderView = searchView;

    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    
    CGRect bounds = [tbView bounds];
    bounds.origin.y += (searchBar.bounds.size.height+4);
    [tbView setBounds:bounds];
    
    controlArray = [[NSMutableArray alloc]init];
    [self addControlToNavi];
}
-(void)addControlToNavi
{
    {
        UIImageView *view = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"my_book_button.png"]];
        view.frame = CGRectMake(((bLandScape == YES ? 1024 : 768)-138)/2, 10, 138, 40);
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
    btnBack.frame = CGRectMake(bLandScape == YES ? 936 : 684, 10, 70, 40);
    btnBack.tag = 3;
    [btnBack setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"button_bookshelf" ofType:@"png"]] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:btnBack];
    [controlArray addObject:btnBack];
    
    UIButton *btnHome = [UIButton buttonWithType:UIButtonTypeCustom];
    btnHome.frame = CGRectMake(bLandScape == YES ? 827 : 577, 10, 100, 40);
    btnHome.tag = 4;
    [btnHome setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"down_manage_button" ofType:@"png"]] forState:UIControlStateNormal];
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
                [view setFrame:bLandScape == YES ? CGRectMake((1024-138)/2, 10, 138, 40):CGRectMake((768-138)/2, 10, 138, 40)];
                break;
            case 2:
                [view setFrame:CGRectMake(10+6, 10, 190, 40)];
                break;
            case 3:
                [view setFrame:CGRectMake(bLandScape == YES ? 936 : 684, 10, 70, 40)];
                break;
            case 4:
                [view setFrame:CGRectMake(bLandScape == YES ? 827 : 577, 10, 100, 40)];
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
    [self.navigationItem setHidesBackButton:YES animated:NO];
    NSArray *db = [book_list_model getMarkedBookList];
    if (db != nil) {
        //
    }
    self.data = [[NSMutableArray alloc]initWithArray: db];
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
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, (bLandScape == YES ? 1024 : 768), 60)];
    is_searching = NO;

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    for (int i = 0; i < [controlArray count]; i ++) {
        
        [(UIView*)[controlArray objectAtIndex:i] removeFromSuperview];
    }
//    [self stopAllDownload];
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
        if (count <= 5) {
            count = 5;
        }
        if (bLandScape) {
            count = ([searchData count]+kNum)/(kNum+1);
            if (count <= 4) {
                count = 4;
            }
        }
    }else{
        count = ([_data count]+kNum-1)/kNum;
        if (count <= 5) {
            count = 5;
        }
        if (bLandScape) {
            count = ([_data count]+kNum)/(kNum+1);
            if (count <= 4) {
                count = 4;
            }
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
    UIImageView *shelfView = nil;
    if (indexPath.row > 0) {
        if (bLandScape){
            shelfView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shelf_mark_hor.png"]];
        }else
        {
            shelfView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shelf_mark_ver.png"]];
        }
    }else
    {
        if (bLandScape){
            shelfView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shelf_one.png"]];
        }else
        {
            shelfView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shelf_one_ver.png"]];
        }
        
    }
    
//    [cell.contentView addSubview: shelfView];
    cell.backgroundView = shelfView;
    NSLog(@"row = %d",indexPath.row);
    //index = 0, is search bar

    // 定义图书大小
    int kCell_Items_Width = 150;
    int kCell_Items_Height = 234;
    int CELL_WITH  = 22;
    if (bLandScape) {
        kCell_Items_Width = 150;
        CELL_WITH  = 42;
    }
    // 设置图片大小206*306
    // 图片与图片之间距离为50
    // 每行3，4本图书
    CGFloat x = 60;
    CGFloat y = 0;
    

    NSInteger nowNum = kNum;
    if (bLandScape) {
        nowNum += 1;
    }
    
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
        MyBookView *bookView = [[MyBookView alloc]initWithFrame:CGRectMake(x, y, kCell_Items_Width, kCell_Items_Height) picturePath:[book valueForKey:@"resource_thum_url"]];
        bookView.picturePath = [book valueForKey:@"resource_thum_url"];
        bookView.bookID = [[book valueForKey:@"resource_master_id"] integerValue];
        bookView.bookName = [book valueForKey:@"resource_title"];
        bookView.bookPath = [book valueForKey:@"resource_url"];
        bookView.bookType = [[book valueForKey:@"resource_type"] integerValue];
        bookView.downloadCompleteStatus = [self checkDownloadState:bookView.bookID bookType:bookView.bookType];
        bookView.createTime = [book valueForKey:@"create_time"];
        bookView.imageCount = [NSString stringWithFormat:@"%@页", [book valueForKey:@"resource_image_count"]];//[book valueForKey:@"resource_image_count"];
        NSLog(@"image count = %@",bookView.imageCount);
        bookView.videoDuration = [book valueForKey:@"resource_video_duration"];
        if (bookView.bookType == RESOURCE_TYPE_MP4) {
            [[book valueForKey:@"resource_size"] stringByAppendingString:@"M"];
        }else
        {
            bookView.resourceSize = [NSString stringWithFormat:@"共%@M",[book valueForKey:@"resource_size"]];
        }
        
        
        bookView.delegate = self;
        [bookViewArray addObject:bookView];
        [cell.contentView addSubview:bookView];
        

        x += (CELL_WITH+kCell_Items_Width);
        // row+1
        ++row;
    }
    
    
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    CGFloat height = 234;
	return 234;
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
    searchBar.frame = CGRectMake(((bLandScape == YES ? 1024 : 768) -331)/2, 20, 331, SEARCH_BAR_HEIGHT);
    searchView.frame = CGRectMake(((bLandScape == YES ? 1024 : 768) -331)/2, 0, 331, SEARCH_BAR_HEIGHT);
    UIView *view = (UIView*)[self.view viewWithTag:123];
    [view removeFromSuperview];
    UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shelf_top.png"] ];
    imageview.frame = CGRectMake(0, 20, bLandScape == YES ? 1024 : 768, SEARCH_BAR_HEIGHT+20);
    imageview.tag = 123;
//    [searchView insertSubview:imageview belowSubview:searchBar];
    UIImage *background;
    if (bLandScape) {
        background = [UIImage imageNamed:@"bookshelf_background.png"];
        
    }else
    {
        background = [UIImage imageNamed:@"bookshelf_background_ver.png"];
    }
    self.view.backgroundColor = [UIColor colorWithPatternImage:background];
    [self resetControlPosition];
}
- (BOOL)shouldAutorotate {
    return YES;
}
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}
//- (void)viewDidLayoutSubviews
//{
//    
//    UIDeviceOrientation interfaceOrientation=[[UIApplication sharedApplication] statusBarOrientation];
//    if (interfaceOrientation == UIDeviceOrientationPortrait || interfaceOrientation == UIDeviceOrientationPortraitUpsideDown) {
//        //翻转为竖屏时
//        bLandScape = NO;
//        [self setVerticalFrame];
//    }else if (interfaceOrientation==UIDeviceOrientationLandscapeLeft || interfaceOrientation == UIDeviceOrientationLandscapeRight) {
//        //翻转为横屏时
//        bLandScape = YES;
//        [self setHorizontalFrame];
//    }
//    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, (bLandScape == YES ? 1024 : 768), 60)];
//}
-(void)setVerticalFrame
{
//    tbView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
//    [tbView reloadData];
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, (bLandScape == YES ? 1024 : 768), 60)];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Title_ver.png"] forBarMetrics:UIBarMetricsDefault];
}
-(void)setHorizontalFrame
{
//    tbView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
//    [tbView reloadData];
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, (bLandScape == YES ? 1024 : 768), 60)];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Title_hor.png"] forBarMetrics:UIBarMetricsDefault];
}

#pragma mark -
#pragma mark MyBookDelegate method

- (void)readBtnOfBookWasClicked:(MyBookView *)book {
    
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

- (void)downBtnOfBookWasClicked:(MyBookView *)book {//下载,将要下载的书添加到ASINetworkQueue
	
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

- (void)pauseBtnOfBookWasClicked:(MyBookView *)book {//暂停下载
	
	for (ASIHTTPRequest *request in [netWorkQueue operations]) {//查找暂停的对象
		
		NSInteger bookid = [[request.userInfo objectForKey:@"bookID"] intValue];//查看userinfo信息
		if (book.bookID == bookid) {//判断ID是否匹配
			//暂停匹配对象
			[request clearDelegatesAndCancel];
		}
	}
}

- (void)closeBtnOfBookWasClicked:(MyBookView *)book {
  
    NSInteger bookID = book.bookID;
    //remove from data
    for (int i = 0; i < [_data count]; i ++) {
        client_book *book = [_data objectAtIndex:i];
        if (bookID == [book.resource_master_id integerValue]) {
            [_data removeObjectAtIndex:i];
            break;
        }
    }
    [tbView reloadData];
    [book_list_model updateBookListUnMark:[NSString stringWithFormat:@"%d",bookID]];
}

- (void)viewBtnOfBookWasClicked:(MyBookView *)book
{
    
}
#pragma mark -
#pragma mark ASIHTTPRequestDelegate method

//ASIHTTPRequestDelegate,下载之前获取信息的方法,主要获取下载内容的大小
- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders {
    
	//NSLog(@"didReceiveResponseHeaders-%@",[responseHeaders valueForKey:@"Content-Length"]);
	for (MyBookView *temp in bookViewArray) {//循环出具体对象
		
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
    
	for (MyBookView *temp in bookViewArray) {//循环出具体对象
		
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
//	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
//	label.text = @"down fail,请检查网络是否连接!";
//	[self.view addSubview:label];
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
    LSCollectionViewController *ibook = [[LSCollectionViewController alloc]init];
    
    [self.navigationController pushViewController:ibook animated:YES];
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
//    tableView.frame = CGRectMake((1024-331)/2, 0, 331, 44);
}
- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    searchBar.frame = CGRectMake(0, 0, 331, SEARCH_BAR_HEIGHT);
}
- (void) searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller;
{
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, (bLandScape == YES ? 1024 : 768), 60)];
    searchBar.frame = CGRectMake(((bLandScape == YES ? 1024 : 768) -331)/2, 0, 331, SEARCH_BAR_HEIGHT);
}
@end