//
//  LSCompanyListCell.m
//  Locoso
//
//  Created by zhiwei ma on 12-3-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSCompanyListCell.h"
#import "LSData.h"
#import "LSDefine.h"
#import "LSViewUtils.h"
#import "RJViewUtils.h"
#import "RJLabel.h"
#import "LSString.h"
#import "LSImagesViewController.h"

#define LSCompanyListCellNameWidth 210

@implementation LSCompanyListCell

+ (LSCompanyListCell*)companyListCell:(UITableView*)aTableView
{
    static NSString* reuseID = @"companyListCell";
    LSCompanyListCell* cell = [aTableView dequeueReusableCellWithIdentifier:reuseID];
    if (nil == cell)
    {
        cell = [[[LSCompanyListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID] autorelease];
    }
    return cell;
}

- (void)dealloc
{
    [_thumbView release];
    [_lbName release];
    [_approveView release];
    [_lbDescrption release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        _thumbView = [[UIImageView alloc] initWithFrame:CGRectMake(10,5,70,70)];
        _thumbView.image = LSImageByName(LSImage_icon_placeholder);
        [_thumbView setCornerAndBorderSmall];
        [self.contentView addSubview:_thumbView];
        
        _lbName = [[UILabel alloc] initWithFrame:CGRectMake(85, 5, LSCompanyListCellNameWidth, 20)];
        _lbName.font = LSFontNormal;
        _lbName.numberOfLines = 2;
        _lbName.textColor = LSCOLOR_BLACK;
        [self.contentView addSubview:_lbName];
        
        UIImage* renImage = LSImageByName(LSImage_icon_approve);
        _approveView = [[UIImageView alloc] initWithImage:renImage];
        [_approveView setViewOrigin:CGPointMake(85, 7)];
        [self.contentView addSubview:_approveView];
        
        _lbDescrption = [[UILabel alloc] initWithFrame:CGRectMake(85, 38, LSCompanyListCellNameWidth, 20)];
        _lbDescrption.numberOfLines = 2;
        _lbDescrption.font = LSFontSmall;
        _lbDescrption.textColor = LSCOLOR_6A6A6A;
        [self.contentView addSubview:_lbDescrption];
    }
    return self;
}

- (void)setCompanyData:(LSDataCompany*)aCompany imageViewController:(LSImagesViewController*)aImageVC
{
    if ([aCompany.logo length] > 0)
    {
        [aImageVC addImage:_thumbView imageURL:[aCompany.logo stringByHandleImageURL]];
    }
    
    NSMutableString* nameText = [NSMutableString stringWithString:aCompany.companyName];
    if (aCompany.state > 0)
    {
        _approveView.hidden = NO;
        [nameText insertString:@"      " atIndex:0];
    }
    else 
    {
        _approveView.hidden = YES;
    }
    
    _lbName.text = nameText;
    CGFloat width = [_lbName fitWidth:20];
    CGSize size;
    if (width > LSCompanyListCellNameWidth) 
    {
        size = [_lbName fitSize:LSCompanyListCellNameWidth];
    }
    else 
    {
        size = CGSizeMake(width, 20);
    }
    [_lbName setViewSize:size];
    
    _lbDescrption.text = aCompany.address;
    width = [_lbDescrption fitWidth:20];
    if (width > LSCompanyListCellNameWidth) 
    {
        size = [_lbDescrption fitSize:LSCompanyListCellNameWidth];
    }
    else 
    {
        size = CGSizeMake(width, 20);
    }
    [_lbDescrption setViewSize:size];
    [_lbDescrption setViewOrigin:CGPointMake(85, _lbName.frame.origin.y+ _lbName.frame.size.height)];
}
@end
