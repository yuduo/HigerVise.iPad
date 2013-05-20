//
//  LSSearchResultFilterControl.h
//  Locoso
//
//  Created by zhiwei ma on 12-3-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSSearchResultFilterControl;
@protocol LSSearchResultFilterControlDelegate 
@optional
- (void)filterControl:(LSSearchResultFilterControl*)aControl itemClicked:(NSInteger)aIndex;
@end

@interface LSSearchResultFilterControl : UIImageView
{
    id<LSSearchResultFilterControlDelegate> _delegate;
    UILabel* _lbLeft;
    UILabel* _lbRight;
}
@property (assign) id<LSSearchResultFilterControlDelegate> delegate;
+ (LSSearchResultFilterControl*)searchResultFilterControl;
- (void)setItemSelected:(NSInteger)aIndex;
@end
