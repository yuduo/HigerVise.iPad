//
//  LSLocationTableViewCell.m
//  Locoso
//
//  Created by yongchang hu on 12-3-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSLocationTableViewCell.h"
#import "LSDefine.h"

@implementation LSLocationTableViewCell
@synthesize delegate = _delegate;
@synthesize state = _state;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.font = LSFontNormal;
        self.textLabel.textColor = LSCOLOR_333333;
    }
    return self;
}

- (void)setStateUpdateSuccess:(NSString*)aCityName
{
    _state = LSLocationTableViewCellStateUpdateSuccess;
    self.textLabel.text = aCityName;
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,0,30,30);
//    [button setImage:LSImageByName(LSImage_icon_refresh) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(refreshButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.accessoryView = button;
}

- (void)setStateUpdateFailed
{
    _state = LSLocationTableViewCellStateUpdateFailed;
//    self.textLabel.text = LSString_location_updatefailed;
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,0,30,30);
//    [button setImage:LSImageByName(LSImage_icon_refresh) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(refreshButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.accessoryView = button;
}

- (void)setStateUpdating
{
    _state = LSLocationTableViewCellStateUpdating;
//    self.textLabel.text = LSString_location_updating;
    
    UIActivityIndicatorView* actView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
    actView.frame = CGRectMake(0,0,30,30);
    [actView startAnimating];
    self.accessoryView = actView;
}

- (void)refreshButtonClicked
{
    if (_delegate && [(NSObject*)_delegate respondsToSelector:@selector(didRefreshButtonClicked:)])
    {
        [_delegate didRefreshButtonClicked:self];
    }
}
@end
