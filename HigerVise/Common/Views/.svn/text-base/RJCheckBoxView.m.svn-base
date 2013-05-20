//
//  RJCheckBoxView.m
//  RuijiMOA
//
//  Created by  on 12-2-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RJCheckBoxView.h"

@implementation RJCheckBoxView
@synthesize isPitchOn = _isPitchOn;
@synthesize imgPitchOn = _imgPitchOn;
@synthesize imgPitchOff = _imgPitchOff;

- (void)dealloc
{
    self.imgPitchOn = nil;
    self.imgPitchOff = nil;
    [super dealloc];
}

- (id)initWithImage:(UIImage*)aPitchOn pitchOffImage:(UIImage*)aPitchOff
{
    self = [self init];
    self.imgPitchOn = aPitchOn;
    self.imgPitchOff = aPitchOff;
    self.isPitchOn = NO;
    return self;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        [self addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];   
    }
    return self;
}

- (void)setIsPitchOn:(BOOL)aIsPitchOn
{
    _isPitchOn = aIsPitchOn;
    
    if (NO == aIsPitchOn) 
    {
        [self setImage:_imgPitchOff forState:UIControlStateNormal];
    }
    else
    {
        [self setImage:_imgPitchOn forState:UIControlStateNormal];
    }
}

- (void) buttonClicked:(id)aSender
{
    self.isPitchOn = !self.isPitchOn;
}
@end
