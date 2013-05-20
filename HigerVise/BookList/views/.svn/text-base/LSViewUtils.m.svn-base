//
//  LSViewUtils.m
//  Locoso
//
//  Created by zhiwei ma on 12-3-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSViewUtils.h"
#import <QuartzCore/QuartzCore.h>

@implementation LSViewUtils

@end


@implementation UIImageView (LSCategory)
- (void)setCornerAndBorderSmall
{
    self.clipsToBounds = YES;
    CALayer* layer = self.layer;
    layer.cornerRadius = 5.0f;
    layer.borderColor = LSCOLOR_CORNER.CGColor;
    layer.borderWidth = 1;
}

- (void)setCornerAndBorderNormal
{
    self.clipsToBounds = YES;
    CALayer* layer = self.layer;
    layer.cornerRadius = 7.0f;
    layer.borderColor = LSCOLOR_CORNER.CGColor;
    layer.borderWidth = 1;
}

- (void)setCornerAndBorderBig
{
    self.clipsToBounds = YES;
    CALayer* layer = self.layer;
    layer.cornerRadius = 10.0f;
    layer.borderColor = LSCOLOR_CORNER.CGColor;
    layer.borderWidth = 1;
}
@end