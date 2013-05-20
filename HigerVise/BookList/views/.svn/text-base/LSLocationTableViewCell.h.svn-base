//
//  LSLocationTableViewCell.h
//  Locoso
//
//  Created by zhiwei ma on 12-3-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSLocationTableViewCell;
@protocol LSLocationTableViewCellDelegate
@optional
- (void)didRefreshButtonClicked:(LSLocationTableViewCell*)aCell;
@end

typedef enum
{
    LSLocationTableViewCellStateUpdateSuccess,
    LSLocationTableViewCellStateUpdateFailed,
    LSLocationTableViewCellStateUpdating
}LSLocationTableViewCellState;

@interface LSLocationTableViewCell : UITableViewCell
{
    id<LSLocationTableViewCellDelegate> _delegate;
    LSLocationTableViewCellState _state;
}
@property (nonatomic, assign) id<LSLocationTableViewCellDelegate> delegate;
@property (nonatomic, readonly) LSLocationTableViewCellState state;
- (void)setStateUpdateSuccess:(NSString*)aCityName;
- (void)setStateUpdateFailed;
- (void)setStateUpdating;
@end
