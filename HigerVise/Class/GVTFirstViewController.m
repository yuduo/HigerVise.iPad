//
//  GVTFirstViewController.m
//  GridViewTabTest
//
//  Created by Tom HU on 2012/12/21.
//  Copyright (c) 2012年 Tom HU. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "GVTFirstViewController.h"
#import "GMGridView.h"
#import "VideoPlayViewController.h"
#import "REPhotoCollectionController.h"
#import "Photo.h"
#import "ThumbnailView.h"
#import "ASIHTTPRequest.h"
#import "DownloadFileManage.h"
#define GRID_VIEW_WIDTH 768
#define GRID_VIEW_HEIGHT 1024-200
#define BOOK_WIDTH 130
#define BOOK_HEIGHT 175
#define SHELF_HEIGHT 234
#define kNum 3

//////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark ViewController (privates methods)
//////////////////////////////////////////////////////////////

//@interface GVTFirstViewController () <GMGridViewDataSource, GMGridViewSortingDelegate, GMGridViewTransformationDelegate, GMGridViewActionDelegate>
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

@implementation GVTFirstViewController

//////////////////////////////////////////////////////////////
#pragma mark controller events
//////////////////////////////////////////////////////////////

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;

    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Title_01.png"]];
//    self.navigationItem.hidesBackButton = YES;
    _data = [[NSMutableArray alloc] initWithObjects:@"乌克兰拖拉机简史",
            @"下面，我该干些什么",
            @"贩卖机故事",
            @"试验时代",
            @"断鼠",
            @"性本恶",
            @"艺术通史",
            @"酒吧问君三语",
            @"如何创作绘本小说",
            @"一天",nil];
    bookViewArray = [[NSMutableArray alloc]init];
//    GMGridView *gmGridView = [[GMGridView alloc] initWithFrame:self.view.bounds];
//    GMGridView *gmGridView = [[GMGridView alloc] initWithFrame:CGRectMake(0, 0, 768, 1024-60)];
//    gmGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    gmGridView.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:gmGridView];
//    _gmGridView = gmGridView;
//    
//    _gmGridView.style = GMGridViewStyleSwap;
//    _gmGridView.itemSpacing = 50;
//    _gmGridView.itemHSpacing = 59;
//    _gmGridView.minEdgeInsets = UIEdgeInsetsMake(30, 10, -5, 10);
//    _gmGridView.centerGrid = YES;
//    _gmGridView.actionDelegate = self;
//    _gmGridView.sortingDelegate = self;
//    _gmGridView.transformDelegate = self;
//    _gmGridView.dataSource = self;
    // 创建uitableview
    if(!tbView){
        tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        tbView.delegate = self;
        tbView.dataSource = self;
        // 设置table的分割符透明
        tbView.separatorColor = [UIColor clearColor];
        // 设置table背景透明
        tbView.backgroundColor = [UIColor clearColor];
    }
    [self.view addSubview:tbView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
//    _gmGridView = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
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
//    //pdf,video,photos
//    switch (position) {
//        case 0:
//            //video
//        {
//            NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
//            NSString *videoPath = [bundlePath stringByAppendingPathComponent:@"test.m4v"];
//            NSURL *url = [NSURL fileURLWithPath:videoPath];
//            VideoPlayViewController *videoPlayer = [[VideoPlayViewController alloc]init];
//            videoPlayer.videoAssetURL = url;
//            [self.navigationController pushViewController:videoPlayer animated:YES];
//            [videoPlayer playVideoWithMoviePlayerController];
//        }
//            break;
//        case 1:
//            //PDF
//        {
//            
//            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"pdf"];
//            ReaderDocument *document = [ReaderDocument withDocumentFilePath:filePath password:nil];
//            if (document != nil) {
//                ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
//                readerViewController.delegate = self;
//                
//                [self.navigationController pushViewController:readerViewController animated:YES];
//                
//            }
//        }
//            break;
//        case 2:
//            //photos
//            if(0)
//            {
//                REPhotoCollectionController *photoCollectionController;
//                photoCollectionController = [[REPhotoCollectionController alloc] initWithDatasource:[self prepareDatasource]];
//                photoCollectionController.title = @"Photos";
//                photoCollectionController.thumbnailViewClass = [ThumbnailView class];
//                self.navigationController.navigationBarHidden = NO;
//                [self.navigationController pushViewController:photoCollectionController animated:YES];
//            }
//            
//        {
//            networkImages = [[NSArray alloc] initWithObjects:@"http://farm6.static.flickr.com/5042/5323996646_9c11e1b2f6_b.jpg", @"http://farm6.static.flickr.com/5007/5311573633_3cae940638.jpg",nil];
//            networkGallery = [[FGalleryViewController alloc] initWithPhotoSource:self];
//            self.navigationController.navigationBarHidden = NO;
//            [self.navigationController pushViewController:networkGallery animated:YES];
//            
//        }
//            break;
//        default:
//            break;
//    }
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
    //if ([self.window.rootViewController isKindOfClass:[UINavigationController class]]) {
    //    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    //    [navigationController popViewControllerAnimated:YES];
    //}
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

#pragma mark - FGalleryViewControllerDelegate Methods


- (int)numberOfPhotosForPhotoGallery:(FGalleryViewController *)gallery
{
    int num;
    if( gallery == localGallery ) {
        num = [localImages count];
    }
    else if( gallery == networkGallery ) {
        num = [networkImages count];
    }
	return num;
}


- (FGalleryPhotoSourceType)photoGallery:(FGalleryViewController *)gallery sourceTypeForPhotoAtIndex:(NSUInteger)index
{
	if( gallery == localGallery ) {
		return FGalleryPhotoSourceTypeLocal;
	}
	else return FGalleryPhotoSourceTypeNetwork;
}


- (NSString*)photoGallery:(FGalleryViewController *)gallery captionForPhotoAtIndex:(NSUInteger)index
{
    
	return @"";
}


- (NSString*)photoGallery:(FGalleryViewController*)gallery filePathForPhotoSize:(FGalleryPhotoSize)size atIndex:(NSUInteger)index {
    return [localImages objectAtIndex:index];
}

- (NSString*)photoGallery:(FGalleryViewController *)gallery urlForPhotoSize:(FGalleryPhotoSize)size atIndex:(NSUInteger)index {
    return [networkImages objectAtIndex:index];
}

- (void)handleTrashButtonTouch:(id)sender {
    // here we could remove images from our local array storage and tell the gallery to remove that image
    // ex:
    //[localGallery removeImageAtIndex:[localGallery currentIndex]];
}


- (void)handleEditCaptionButtonTouch:(id)sender {
    // here we could implement some code to change the caption for a stored image
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
    NSInteger count = ([_data count]+kNum-1)/kNum;
    if (bLandScape) {
        count = ([_data count]+kNum)/(kNum+1);
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
    UIImageView *shelfView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shelf.png"]];
    [cell.contentView addSubview: shelfView];
    // 定义图书大小
#define kCell_Items_Width 130
#define kCell_Items_Height 175
    // 设置图片大小206*306
    // 图片与图片之间距离为50
    // 每行3，4本图书
    CGFloat x = 80;
    CGFloat y = 40;
    

    NSInteger nowNum = kNum;
    if (bLandScape) {
        nowNum += 1;
    }
    
    NSInteger row = indexPath.row * nowNum;
    
    for (int i = 0; i<nowNum; ++i) {
        // 跳出循环
        if (row >= [_data count]) {
            break;
        }
        
        // 展示图片
//        UIImageView *bookView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, kCell_Items_Width, kCell_Items_Height)];
//        NSString *bookName = [[NSString alloc] initWithFormat:@"Book_Cover.png",row];
//        bookView.image = [UIImage imageNamed:bookName];
        MyBookView *bookView = [[MyBookView alloc]initWithFrame:CGRectMake(x, y, kCell_Items_Width, kCell_Items_Height)];
        bookView.picturePath = @"Book_Cover.png";
        [bookViewArray addObject:bookView];
        [cell.contentView addSubview:bookView];
        
        // 添加按钮
        UIButton *bookButton = [UIButton buttonWithType:UIButtonTypeCustom];
        bookButton.frame = CGRectMake(x, y, kCell_Items_Width, kCell_Items_Height);
        // 这里采用一个技巧，使用button的tag，记录tabledata中的序号
        bookButton.tag = row;
        [bookButton addTarget:self action:@selector(testButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.contentView addSubview:bookButton];
        
        x += (80+kCell_Items_Width);
        // row+1
        ++row;
    }
    
    
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    CGFloat height = 234;
	return 234;
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
	}else {
		bLandScape = NO;
	}
	tbView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [tbView reloadData];
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
-(void)setVerticalFrame
{
    tbView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [tbView reloadData];
}
-(void)setHorizontalFrame
{
    tbView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [tbView reloadData];
}

#pragma mark -
#pragma mark MyBookDelegate method


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
	NSURL *url = [NSURL URLWithString:book.bookPath];
	//设置下载路径
	ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
	//设置ASIHTTPRequest代理
	request.delegate = self;
	//初始化保存ZIP文件路径
	NSString *savePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"book_%d.zip",book.bookID]];
	//初始化临时文件路径
	NSString *tempPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"temp/book_%d.zip.temp",book.bookID]];
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
    
	for (MyBookView *temp in [self.view subviews]) {//循环出具体对象
		
		if ([temp respondsToSelector:@selector(bookID)]) {
			
			if (temp.bookID == [[request.userInfo objectForKey:@"bookID"] intValue]) {//判断是否与下载完成的对象匹配
				
				temp.downloadCompleteStatus = YES;//如果匹配,则设置他的下载状态为YES
				
				//重绘
				[temp setNeedsDisplay];
			}
            //save to local
            [DownloadFileManage addToDownloadedList:temp.bookID path:nil];
		}
	}
}
//ASIHTTPRequestDelegate,下载失败
- (void)requestFailed:(ASIHTTPRequest *)request {
    
	NSLog(@"down fail.....");
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(300, 220, 200, 100)];
	label.text = @"down fail,请检查网络是否连接!";
	[self.view addSubview:label];
}


@end