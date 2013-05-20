//
//  KKFilterControl.m
//  KaiKai
//
//  Created by mazhiwei on 12-1-13.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "KKFilterControl.h"
#import "LSDefine.h"

@implementation KKFilterControl
@synthesize delegate = _delegate;
@synthesize selectedIndex = _selectedIndex;

- (id)initWithItems:(NSString*)aLeft andRight:(NSString*)aRight
{
    self = [super init];
    if (self)
    {
        _btnLeft = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _btnLeft.frame = CGRectMake(0,0,160,44);
//        [_btnLeft setBackgroundImage:LSImageByName(LSImage_bg_segment_selected) forState:UIControlStateNormal];
        _btnLeft.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_btnLeft setTitleColor:LSCOLOR_333333 forState:UIControlStateNormal];
        [_btnLeft setTitle:aLeft forState:UIControlStateNormal];
        [_btnLeft addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnLeft];
        self.selectedIndex = 0;
        
        _btnRight = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _btnRight.frame = CGRectMake(160,0,160,44);
//        [_btnRight setBackgroundImage:LSImageByName(LSImage_bg_segment_unselected) forState:UIControlStateNormal];
        _btnRight.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_btnRight setTitleColor:LSCOLOR_333333 forState:UIControlStateNormal];
        [_btnRight setTitle:aRight forState:UIControlStateNormal];
        [_btnRight addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnRight];
        
        self.frame = CGRectMake(0,0,320,44);
    }
    return self;
}

- (void)setSelectedIndex:(NSInteger)aIndex
{
    if (_selectedIndex == aIndex)
    {
        return;
    }
//    
//    if (0 == aIndex)
//    {
//        _selectedIndex = 0;
//        [_btnLeft setBackgroundImage:LSImageByName(LSImage_bg_segment_selected) forState:UIControlStateNormal];
//        [_btnRight setBackgroundImage:LSImageByName(LSImage_bg_segment_unselected) forState:UIControlStateNormal];
//    }
//    else if (1 == aIndex)
//    {
//        _selectedIndex = 1;
//        [_btnLeft setBackgroundImage:LSImageByName(LSImage_bg_segment_unselected) forState:UIControlStateNormal];
//        [_btnRight setBackgroundImage:LSImageByName(LSImage_bg_segment_selected) forState:UIControlStateNormal];
//    }
//    else 
//    {
//        _selectedIndex = -1;
//        [_btnLeft setBackgroundImage:LSImageByName(LSImage_bg_segment_unselected) forState:UIControlStateNormal];
//        [_btnRight setBackgroundImage:LSImageByName(LSImage_bg_segment_unselected) forState:UIControlStateNormal];
//    }
}

- (void)buttonClicked:(id)sender
{
    BOOL ret = NO;
    if (sender == _btnLeft && 0 != _selectedIndex)
    {
        self.selectedIndex = 0;
        ret = YES;
    }
    else if (sender == _btnRight && 1!= _selectedIndex)
    {
        self.selectedIndex = 1;
        ret = YES;
    }
    
    if (ret)
    {
        if (_delegate && [(NSObject*)_delegate respondsToSelector:@selector(filterControlSelectedItemChanged:selectedIndex:)])
        {
            [_delegate filterControlSelectedItemChanged:self selectedIndex:_selectedIndex];
        }
    }
}
@end
