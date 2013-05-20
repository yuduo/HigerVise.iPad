//
//  CustomMessageViewCell.m
//  Locoso
//
//  Created by yongchang hu on 11-12-22.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "CustomMessageViewCell.h"
#import "CustomMessageView.h"

@implementation CustomMessageViewCell
@synthesize custommessageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
	if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
		
		// Create a time zone view and add it as a subview of self's contentView.
        CGRect tzvFrame = CGRectMake(0.0, 0.0, 320, 100);
		custommessageView = [[CustomMessageView alloc] initWithFrame:tzvFrame];
		
		[self.contentView addSubview:custommessageView];
	}
	return self;
}
-(void)setCellNSStringValue:(NSString*)MsgContent MsgName:(NSString*)usrName LeaveData:(NSString*)leaveData LeaveMsg:(NSString*)leaveMsg
{
    [custommessageView setCellNSStringValue:MsgContent MsgName:usrName LeaveData:leaveData LeaveMsg:leaveMsg];
}

- (void)dealloc {
    [custommessageView release];
    [super dealloc];
}
@end
