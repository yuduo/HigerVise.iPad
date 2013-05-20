//
//  LSMessageListTableViewCellCell.h
//  Locoso
//
//  Created by zhiwei ma on 12-3-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSData.h"

@interface LSMessageListTableViewCellCell : UITableViewCell
{
    UILabel* _lbContent;
    UILabel* _lbSenderName;
    UILabel* _lbTime;
    UIView*  _vReplyBg;
    UILabel* _lbReply;
}
+ (CGFloat)minumumHeight:(LSDataMessage*)aMessage;
- (void)updateWithData:(LSDataMessage*)aMessage;
@end
