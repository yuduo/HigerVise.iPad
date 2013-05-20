//
//  UITableView+LSAddiational.h
//  Locoso
//
//  Created by yongchang hu on 12-3-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (LSAddiational)
- (void)addMoreButton:(id)aTarget selector:(SEL)aSelector;
- (void)makeMoreButtonHidden:(BOOL)aHidden;
@end

@interface  UITableViewCell (LSAddiational)
- (void)setAccessoryView:(id)aTarget selector:(SEL)aSelector viewTag:(NSInteger)aViewTag;
@end