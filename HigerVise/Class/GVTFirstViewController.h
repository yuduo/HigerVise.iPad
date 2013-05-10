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

@interface GVTFirstViewController : UIViewController<ReaderViewControllerDelegate,FGalleryViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSArray *localCaptions;
    NSArray *localImages;
    NSArray *networkCaptions;
    NSArray *networkImages;
    FGalleryViewController *localGallery;
    FGalleryViewController *networkGallery;
    
    // 状态
	BOOL bLandScape;
    NSMutableArray *_data;
     UITableView *tbView;
}

@end
