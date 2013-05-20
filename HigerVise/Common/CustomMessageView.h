//
//  CustomMessageView.h
//  Locoso
//
//  Created by yongchang hu on 11-12-29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomMessageView : UIView{
    NSString *coustomMsg;
    NSString *coustomName;
    NSString *leavedata;
    NSString *leaveMessage;
}
@property (nonatomic, retain) NSString *coustomMsg;
@property (nonatomic, retain) NSString *coustomName;
@property (nonatomic, retain) NSString *leavedata;
@property (nonatomic, retain) NSString *leaveMessage;
@end
