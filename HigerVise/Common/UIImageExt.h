//
//  UIImageExt.h
//  Locoso
//
//  Created by yongchang hu on 12-1-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface UIImage (UIImageExt)
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;
@end
