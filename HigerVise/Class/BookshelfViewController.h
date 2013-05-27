//
//  BookshelfViewController.h
//  GridViewTabTest
//
//  Created by Tom HU on 2012/12/21.
//  Copyright (c) 2012年 Tom HU. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MyBookView.h"
#import "ASINetworkQueue.h"
#import "ReadAllBook.h"
#import "LSCollectPE.h"
#define GRID_VIEW_WIDTH 768
#define GRID_VIEW_HEIGHT 1024-200
#define BOOK_WIDTH 130
#define BOOK_HEIGHT 175
#define SHELF_HEIGHT 234
#define SEARCH_BAR_HEIGHT 234
#define kNum 3


@interface BookshelfViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,MyBookDelegate,ASIHTTPRequestDelegate,ReadAllBookDelegate,UISearchBarDelegate, UISearchDisplayDelegate>
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
}
-(id)init;
@property(nonatomic,strong)NSMutableArray *data;

-(void)searchDocFindPicture:(NSString*)path;
@end
