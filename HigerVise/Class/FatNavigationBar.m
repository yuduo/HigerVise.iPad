//
//  FatNavigationBar.m
//  FatNav
//
//  Created by 23 on 3/7/13.
//  Copyright (c) 2013 Aged and Distilled. All rights reserved.
//

const CGFloat kFatNavBarHeight = 100.0;

#import "FatNavigationBar.h"
#import <QuartzCore/QuartzCore.h>

@interface UIView (FatNavDebugging)

- (NSString*) recursiveDescription;

@end


@implementation FatNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (void) commonInit
{
    CGRect frame = self.frame;
    frame.size.height = kFatNavBarHeight;
    self.frame = frame;
    
    // Customize the navigation bar for our extra height
    CGFloat dy = floor( (kFatNavBarHeight - 44.0) / 2.0);
    
    [[UIBarButtonItem appearance] setBackButtonBackgroundVerticalPositionAdjustment:-dy forBarMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackgroundVerticalPositionAdjustment:-dy forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleVerticalPositionAdjustment:-dy forBarMetrics:UIBarMetricsDefault];
    
    //self.backgroundColor = [UIColor purpleColor];
    //self.layer.borderColor = [[UIColor yellowColor] CGColor];
    //self.layer.borderWidth = 1.0f;
}


- (void)setFrame:(CGRect)frame
{
    NSLog(@"<%@ : %p> Changing Frame to:%@", [[self class] description], (__bridge void*)self, CGRectCreateDictionaryRepresentation(frame));   
    frame.size.height = kFatNavBarHeight;
    [super setFrame:frame];
}

- (void)setBounds:(CGRect)bounds
{
    NSLog(@"<%@ : %p> Changing Bounds to:%@", [[self class] description], (__bridge void*)self, CGRectCreateDictionaryRepresentation(bounds));
    bounds.size.height = kFatNavBarHeight;
    [super setBounds:bounds];
    
}

@end
