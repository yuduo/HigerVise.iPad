//
//  LSFilterTableViewCell.m
//  Locoso
//
//  Created by yongchang hu on 12-3-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSFilterTableViewCell.h"
#import "LSDefine.h"
#import "UITableView+LSAddiational.h"

@interface LSFilterTableViewCell (LSPrivate)
- (void)switchValueChanged:(id)aSender;
@end

@implementation LSFilterTableViewCell (LSPrivate)
- (void)switchValueChanged:(id)aSender
{
    self.accessoryType = _switch.isOn ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
    if (_delegate && [(NSObject*)_delegate respondsToSelector:@selector(didSwitchControlStateChanged:on:)])
    {
        [_delegate didSwitchControlStateChanged:self on:_switch.isOn];
    }
}
@end

@implementation LSFilterTableViewCell
@synthesize delegate = _delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _lbType = [[UILabel alloc] initWithFrame:CGRectMake(10,0,40,LSFilterTableViewCellHeight)];
        _lbType.backgroundColor = LSCOLOR_CLEAR;
        _lbType.font = LSFontNormal;
        _lbType.textColor = LSCOLOR_BLACK;
        _lbType.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:_lbType];
        [_lbType release];
        
        _lbName = [[UILabel alloc] initWithFrame:CGRectMake(50,0,145,LSFilterTableViewCellHeight)];
        _lbName.backgroundColor = LSCOLOR_CLEAR;
        _lbName.font = LSFontNormal;
        _lbName.textColor = LSCOLOR_333333;
        _lbName.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:_lbName];
        [_lbName release];
        
        _switch = [[UISwitch alloc] initWithFrame:CGRectMake(200,8,50,30)];
        if ([_switch respondsToSelector:@selector(setOnTintColor:)]) 
        {
            _switch.onTintColor = LSCOLOS_SearchBar;
        }
        [_switch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:_switch];
    }
    return self;
}

- (void)setCellData:(NSString*)aType name:(NSString*)aName
{
    _lbType.text = aType;
    _lbName.text = aName;
}

- (void)setSwitchOn:(BOOL)switchOn
{
    _switch.on = switchOn;
    self.accessoryType = switchOn ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
}

- (BOOL)isSwitchOn
{
    return _switch.isOn;
}
@end
