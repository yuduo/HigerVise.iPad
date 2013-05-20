//
//  KKFilterControl.h
//  KaiKai
//
//  Created by mazhiwei on 12-1-13.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KKFilterControl;
@protocol KKFilterControlDelegate
@optional
- (void)filterControlSelectedItemChanged:(KKFilterControl*)aFilter selectedIndex:(NSInteger)aSelectedIndex;
@end

@interface KKFilterControl : UIView 
{
    UIButton* _btnLeft;
    UIButton* _btnRight;
    id<KKFilterControlDelegate> _delegate;
    NSInteger _selectedIndex;
}
- (id)initWithItems:(NSString*)aLeft andRight:(NSString*)aRight;
@property (nonatomic, assign) id<KKFilterControlDelegate> delegate;
@property (nonatomic) NSInteger selectedIndex;//-1，0，1. -1表示未选中，默认为0
@end
