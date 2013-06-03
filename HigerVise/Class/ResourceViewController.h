//
//  BookshelfViewController.h
//  GridViewTabTest
//
//  Created by Tom HU on 2012/12/21.
//  Copyright (c) 2012年 Tom HU. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ResourceView.h"
#import "ASINetworkQueue.h"
#import "ReadAllBook.h"
#import "LSCollectPE.h"



@interface ResourceViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ResourceViewDelegate,ASIHTTPRequestDelegate,ReadAllBookDelegate,UISearchBarDelegate, UISearchDisplayDelegate>
{


    ASINetworkQueue *netWorkQueue;//创建一个队列
    // 状态
	BOOL bLandScape;
    NSMutableArray *_data;
     UITableView *tbView;
    NSMutableArray *bookViewArray;
    ReadAllBook *readAllBooks;
    NSMutableArray *searchData;
    UISearchBar *searchBar;
    UIView *searchView;
    UISearchDisplayController *searchDisplayController;
    BOOL addButtonState;
    BOOL categoryButtonState;
    UIView *categoryView;
    NSMutableArray *markArray;
    NSMutableArray *controlArray;
    BOOL is_searching;
}
-(id)init;
@property(nonatomic,strong)NSMutableArray *data;

-(void)searchDocFindPicture:(NSString*)path;
@end
