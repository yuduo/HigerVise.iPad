//
//  LSSubCategoryTableViewCell.m
//  Locoso
//
//  Created by zhiwei ma on 12-3-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSSubCategoryTableViewCell.h"
#import "LSDefine.h"
#import "UITableView+LSAddiational.h"
#import "LSData.h"

@implementation LSSubCategoryTableViewCell
+ (LSSubCategoryTableViewCell*)subcategoryTableViewCell:(UITableView*)aTableView
{
    NSString* reuseID = @"subCategoryCell";
    LSSubCategoryTableViewCell* cell = [aTableView dequeueReusableCellWithIdentifier:reuseID];
    if (nil == cell)
    {
        cell = [[[LSSubCategoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID] autorelease];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.font = LSFontNormal;
        self.textLabel.textColor = LSCOLOR_BLACK;
    }
    return self;
}

- (void)setCellWithData:(LSDataCategory*)aCategory indexPath:(NSIndexPath*)aIndexPath accessoryTarget:(id)aTarget accessorySelector:(SEL)aSelector
{
    self.textLabel.text = aCategory.name;
    if (aCategory.childnum > 0)
    {
        [self setAccessoryView:aTarget selector:@selector(aSelector) viewTag:aIndexPath.row];
    }
    else 
    {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.accessoryView = nil;
    }
}
@end
