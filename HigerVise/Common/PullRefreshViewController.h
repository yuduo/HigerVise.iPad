//
//  PullRefreshViewController.h
//  Locoso
//
//  Created by yongchang hu on 12-3-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PullRefreshViewController : UITableViewController<UITableViewDelegate,
UITableViewDataSource>{
    UIView *refreshHeaderView;
    UILabel *refreshLabel;
    UIImageView *refreshArrow;
    UIActivityIndicatorView *refreshSpinner;
    NSString *textPull;
    NSString *textRelease;
    NSString *textLoading;
    BOOL isDragging;
    BOOL isLoading;
}
@property (nonatomic, copy) NSString *textPull;
@property (nonatomic, copy) NSString *textRelease;
@property (nonatomic, copy) NSString *textLoading;
@property (nonatomic, retain) UIView *refreshHeaderView;
@property (nonatomic, retain) UILabel *refreshLabel;
@property (nonatomic, retain) UIImageView *refreshArrow;
@property (nonatomic, retain) UIActivityIndicatorView *refreshSpinner;
- (void)addPullToRefreshHeader;
- (void)startLoading;
- (void)stopLoading;
- (void)refresh;
@end
