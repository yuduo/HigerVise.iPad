//
//  LSSearchResultFilterControl.m
//  Locoso
//
//  Created by zhiwei ma on 12-3-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSSearchResultFilterControl.h"
#import "LSDefine.h"

@implementation LSSearchResultFilterControl
@synthesize delegate = _delegate;

+ (LSSearchResultFilterControl*)searchResultFilterControl
{
    LSSearchResultFilterControl* filterControl = [[[LSSearchResultFilterControl alloc] initWithFrame:CGRectMake(0,0,320,50)] autorelease];
    return filterControl;
}

- (void)dealloc
{
    [_lbLeft release];
    [_lbRight release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        self.image = LSImageByName(LSImage_filter_00);
        
        _lbLeft = [[UILabel alloc] initWithFrame:CGRectMake(0,40,80,50)];
        _lbLeft.backgroundColor = [UIColor redColor];
        _lbLeft.font = LSFontBig;
        _lbLeft.textColor = LSCOLOR_BLACK;
        _lbLeft.textAlignment = UITextAlignmentCenter;
        _lbLeft.text = LSString_filter_industry;
        UIControl* controlLeft = [[UIControl alloc] initWithFrame:_lbLeft.bounds];
        [controlLeft addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
        [controlLeft release];
        [self addSubview:_lbLeft];
        
         
        _lbRight = [[UILabel alloc] initWithFrame:CGRectMake(200,0,80,50)];
        _lbRight.backgroundColor = [UIColor redColor];
        _lbRight.font = LSFontBig;
        _lbRight.textColor = LSCOLOR_BLACK;
        _lbRight.textAlignment = UITextAlignmentCenter;
        _lbRight.text = LSString_filter_district;
        UIControl* controlRight = [[UIControl alloc] initWithFrame:_lbLeft.bounds];
        [controlRight addTarget:self action:@selector(rightItemClicked) forControlEvents:UIControlEventTouchUpInside];
        [controlRight release];
        [self addSubview:_lbRight];
    }
    return self;
}

- (void)setItemSelected:(NSInteger)aIndex
{
    if (aIndex < 0)
    {
        self.image = LSImageByName(LSImage_filter_00);
    }
    else if (0 == aIndex)
    {
        self.image = LSImageByName(LSImage_filter_01);
    }
    else if (1 == aIndex)
    {
        self.image = LSImageByName(LSImage_filter_02);
    }
}

- (void)leftItemClicked
{
    if ([(NSObject*)_delegate respondsToSelector:@selector(filterControl:itemClicked:)])
    {
        [_delegate filterControl:self itemClicked:0];
    }
}

- (void)rightItemClicked
{
    if ([(NSObject*)_delegate respondsToSelector:@selector(filterControl:itemClicked:)])
    {
        [_delegate filterControl:self itemClicked:1];
    }
}
@end
