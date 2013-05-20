//
//  UITableView+LSAddiational.m
//  Locoso
//
//  Created by zhiwei ma on 12-3-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UITableView+LSAddiational.h"
#import "LSDefine.h"

@implementation UITableView (LSAddiational)
- (void)addMoreButton:(id)aTarget selector:(SEL)aSelector
{
    UIButton* moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    moreButton.frame = CGRectMake(0,0,320,44);
    [moreButton setTitleColor:LSCOLOR_333333 forState:UIControlStateNormal];
    [moreButton setTitle:LSString_showmore forState:UIControlStateNormal];
    [moreButton addTarget:aTarget action:aSelector forControlEvents:UIControlEventTouchUpInside];
    self.tableFooterView = moreButton;
}

- (void)makeMoreButtonHidden:(BOOL)aHidden
{
    self.tableFooterView.hidden = aHidden;
}
@end

@implementation  UITableViewCell (LSAddiational)
- (void)setAccessoryView:(id)aTarget selector:(SEL)aSelector viewTag:(NSInteger)aViewTag
{
    UIButton* accessoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    accessoryButton.frame = CGRectMake(0,0,40,40);
    [accessoryButton setImage:LSImageByName(LSImage_Icon_Arrow) forState:UIControlStateNormal];
    [accessoryButton addTarget:aTarget action:aSelector forControlEvents:UIControlEventTouchUpInside];
    accessoryButton.tag = aViewTag;
    self.accessoryView = accessoryButton;
}
@end