//
//  LSPhotoItemView.m
//  Locoso
//
//  Created by yongchang hu on 12-3-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSPhotoItemView.h"
#import "LSDefine.h"
#import <QuartzCore/QuartzCore.h>

@implementation LSPhotoItemView
@synthesize delegate = _delegate;
@synthesize state = _state;
@synthesize imageView = _imageView;
@synthesize textLabel = _textLabel;

- (void)dealloc
{
    self.imageView = nil;
    self.textLabel = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5,5,133,133)];
        imageView.clipsToBounds = YES;
        CALayer* layer = imageView.layer;
        layer.cornerRadius = 10.0f;
        layer.borderColor = LSCOLOR_999999.CGColor;
        layer.borderWidth = 1.0f;
        [self addSubview:imageView];
        self.imageView = imageView;
        [imageView release];
        
        UILabel* labelView = [[UILabel alloc] initWithFrame:CGRectMake(5, 140, 133, 20)];
        labelView.backgroundColor = [UIColor clearColor];
        labelView.textColor = LSCOLOR_333333;
        labelView.font = LSFontNormal;
        labelView.textAlignment = UITextAlignmentCenter;
        [self addSubview:labelView];
        self.textLabel = labelView;
        [labelView release];
        
        UIControl* control = [[UIControl alloc] initWithFrame:CGRectMake(0,0,frame.size.width,frame.size.height)];
        control.backgroundColor = [UIColor clearColor];
        [control addTarget:self action:@selector(itemClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:control];
        [control release];
        
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.frame = CGRectMake(-5,-5,30,30);
//        [_deleteButton setImage:LSImageByName(LSImage_icon_close) forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_deleteButton];
        
    }
    return self;
}

- (void)setState:(LSPhotoItemViewState)state
{
    _state = state;
    if (LSPhotoItemViewStateNormal == state)
    {
        _deleteButton.hidden = YES;
    }
    else if (LSPhotoItemViewStateDelete == state)
    {
        _deleteButton.hidden = NO;
    }
}

- (void)deleteButtonClicked
{
    [_delegate didDeleteItem:self];
}

- (void)itemClicked
{
    if (LSPhotoItemViewStateNormal == _state)
    {
        [_delegate didClickItem:self];
    }
    else if (LSPhotoItemViewStateDelete == _state)
    {
        //noop
    }
}
@end
