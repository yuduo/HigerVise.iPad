//
//  DownloadFileViewController.h
//  HigerManage
//
//  Created by jijesoft on 13-5-13.
//  Copyright (c) 2013年 WuHanNvl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadFileViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tbView;
    NSMutableArray *downloadedArray;
}

@end
