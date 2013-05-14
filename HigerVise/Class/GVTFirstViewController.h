//
//  GVTFirstViewController.h
//  GridViewTabTest
//
//  Created by Tom HU on 2012/12/21.
//  Copyright (c) 2012年 Tom HU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReaderViewController.h"
#import "FGalleryViewController.h"
#import "MyBookView.h"
#import "ASINetworkQueue.h"
@interface GVTFirstViewController : UIViewController<ReaderViewControllerDelegate,FGalleryViewControllerDelegate,UITableViewDelegate,UITableViewDataSource,MyBookDelegate,ASIHTTPRequestDelegate>
{
    NSArray *localCaptions;
    NSArray *localImages;
    NSArray *networkCaptions;
    NSArray *networkImages;
    FGalleryViewController *localGallery;
    FGalleryViewController *networkGallery;
    ASINetworkQueue *netWorkQueue;//创建一个队列
    // 状态
	BOOL bLandScape;
    NSMutableArray *_data;
     UITableView *tbView;
    NSMutableArray *bookViewArray;
}

@end
