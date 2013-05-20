//
//  CustomMessageViewCell.h
//  Locoso
//
//  Created by yongchang hu on 11-12-22.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomMessageView;

@interface CustomMessageViewCell : UITableViewCell{
    CustomMessageView *custommessageView;
}
@property (nonatomic, retain) CustomMessageView *custommessageView;
-(void)setCellNSStringValue:(NSString*)MsgContent MsgName:(NSString*)usrName LeaveData:(NSString*)leaveData LeaveMsg:(NSString*)leaveMsg;
//-(void)SetCCoustomMsg:(NSString *)setStr;
//-(void)SetCCoustomName:(NSString *)setStr;
//-(void)SetCLeaveData:(NSString *)setStr;
//-(void)SetCLeaveMsg:(NSString *)setStr;
@end
