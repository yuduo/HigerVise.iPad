//
//  LSPhotosTableViewCell.m
//  Locoso
//
//  Created by zhiwei ma on 12-3-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSPhotosTableViewCell.h"

@implementation LSPhotosTableViewCell
@synthesize delegate = _delegate;
@synthesize placeHolderImage = _placeHolderImage;
@synthesize leftItem = _leftItem;
@synthesize rightItem = _rightItem;

- (void)dealloc
{
    self.placeHolderImage = nil;
    self.leftItem = nil;
    self.rightItem = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        LSPhotoItemView* leftItem = [[LSPhotoItemView alloc] initWithFrame:CGRectMake(13,10,140,160)];
        leftItem.tag = 101;
        leftItem.delegate = self;
        leftItem.imageView.image = _placeHolderImage;
        [self.contentView addSubview:leftItem];
        self.leftItem = leftItem;
        [leftItem release];
        
        LSPhotoItemView* rightItem = [[LSPhotoItemView alloc] initWithFrame:CGRectMake(167,10,140,160)];
        rightItem.tag = 102;
        rightItem.delegate = self;
        rightItem.imageView.image = _placeHolderImage;
        [self.contentView addSubview:rightItem];
        self.rightItem = rightItem;
        [rightItem release];   
    }
    return self;
}

#pragma mark LSPhotoItemViewDelegate
- (void)didDeleteItem:(LSPhotoItemView*)aItemView;
{
    NSInteger index = 0;
    if (self.leftItem == aItemView)
    {
        index = 0;
    }
    else if (self.rightItem == aItemView)
    {
        index = 1;
    }
    [_delegate didDeleteItem:self itemIndex:index];
}
- (void)didClickItem:(LSPhotoItemView*)aItemView
{
    NSInteger index = 0;
    if (self.leftItem == aItemView)
    {
        index = 0;
    }
    else if (self.rightItem == aItemView)
    {
        index = 1;
    }
    [_delegate didItemClicked:self itemIndex:index];
}
@end
