//
//  LSZoomImageView.h
//  Locoso
//
//  Created by yongchang hu on 12-3-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LSZoomImageView : UIImageView {
	CGPoint _startLocation;
	CGSize _originalSize;
	CGAffineTransform _originalTransform;
    CFMutableDictionaryRef _touchBeginPoints;
	
	BOOL	_allowRotate;				// default YES
}
@property (assign) BOOL allowRotate;


@end
