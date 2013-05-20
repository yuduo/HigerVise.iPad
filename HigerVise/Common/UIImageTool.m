//
//  UIImageTool.m
//  Locoso
//
//  Created by yongchang hu on 12-1-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIImageTool.h"
#import <QuartzCore/QuartzCore.h>
//#import "LSDefine.h"
@implementation UIImageTool
+(UIImage *)addTwoImageToOne:(UIImage *) oneImg twoImage:(UIImage *) twoImg

{
    
    UIGraphicsBeginImageContext(oneImg.size);
    
    [oneImg drawInRect:CGRectMake(0, 0, oneImg.size.width, oneImg.size.height)];
    
    [twoImg drawInRect:CGRectMake(0, 0, twoImg.size.width, twoImg.size.height)];
    
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultImg;
    
}

+(void)setLayerCorner:(CALayer*)layer
{
    
    layer.cornerRadius = 7.0f;
    layer.borderWidth = 2;
//    layer.borderColor = LSCOLOR_CORNER.CGColor;
}
@end
