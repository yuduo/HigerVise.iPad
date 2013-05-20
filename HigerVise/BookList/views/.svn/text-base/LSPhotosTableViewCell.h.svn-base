//
//  LSPhotosTableViewCell.h
//  Locoso
//
//  Created by zhiwei ma on 12-3-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSPhotoItemView.h"

@class LSPhotosTableViewCell;
@protocol LSPhotosTableViewCellDelegate
- (void)didItemClicked:(LSPhotosTableViewCell*)aCell itemIndex:(NSInteger)aIndex;
- (void)didDeleteItem:(LSPhotosTableViewCell*)aCell itemIndex:(NSInteger)aIndex;
@end

@interface LSPhotosTableViewCell : UITableViewCell
<LSPhotoItemViewDelegate>
{
    id<LSPhotosTableViewCellDelegate> _delegate;
    UIImage* _placeHolderImage;
    
    LSPhotoItemView* _leftItem;
    LSPhotoItemView* _rightItem;
}
@property (nonatomic, assign) id<LSPhotosTableViewCellDelegate> delegate;
@property (nonatomic, retain) UIImage* placeHolderImage;
@property (nonatomic, retain) LSPhotoItemView* leftItem;
@property (nonatomic, retain) LSPhotoItemView* rightItem;
@end
