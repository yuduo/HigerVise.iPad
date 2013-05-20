//
//  LSFilterTableViewCell.h
//  Locoso
//
//  Created by zhiwei ma on 12-3-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LSFilterTableViewCellHeight 44

@class LSFilterTableViewCell;
@protocol LSFilterTableViewCellDelegate
- (void)didSwitchControlStateChanged:(LSFilterTableViewCell*)aCell on:(BOOL)aIsOn;
@end

@interface LSFilterTableViewCell : UITableViewCell
{
    id<LSFilterTableViewCellDelegate> _delegate;
    UILabel* _lbType;
    UILabel* _lbName;
    UISwitch* _switch;
}
@property (nonatomic,assign) id<LSFilterTableViewCellDelegate> delegate;
@property (nonatomic, getter=isSwitchOn) BOOL switchOn;
- (void)setCellData:(NSString*)aType name:(NSString*)aName;
@end
