//
//  RJCheckBoxView.h
//  RuijiMOA
//
//  Created by  on 12-2-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RJCheckBoxView : UIButton
{
    BOOL _isPitchOn;
    UIImage* _imgPitchOn;
    UIImage* _imgPitchOff;
}
@property (nonatomic) BOOL isPitchOn;
@property (nonatomic, retain) UIImage* imgPitchOn;
@property (nonatomic, retain) UIImage* imgPitchOff;

- (id)initWithImage:(UIImage*)aPitchOn pitchOffImage:(UIImage*)aPitchOff;
@end
