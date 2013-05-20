//
//  LSSubCategoryTableViewCell.h
//  Locoso
//
//  Created by yongchang hu on 12-3-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSDataCategory;
@interface LSSubCategoryTableViewCell : UITableViewCell
+ (LSSubCategoryTableViewCell*)subcategoryTableViewCell:(UITableView*)aTableView;
//- (void)setCellWithData:(LSDataCategory*)aCategory indexPath:(NSIndexPath*)aIndexPath accessoryTarget:(id)aTarget accessorySelector:(SEL)aSelector;
@end
