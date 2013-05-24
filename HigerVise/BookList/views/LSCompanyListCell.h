//
//  LSCompanyListCell.h
//  Locoso
//
//  Created by yongchang hu on 12-3-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSDataBook,LSImagesViewController;
@interface LSCompanyListCell : UITableViewCell
{
    UIImageView* _thumbView;
    UILabel* _lbName;
    UIImageView* _approveView;
    UILabel* _lbDescrption;
}
+ (LSCompanyListCell*)companyListCell:(UITableView*)aTableView;
- (void)setCompanyData:(LSDataBook*)aCompany imageViewController:(LSImagesViewController*)aImageVC;
@end
