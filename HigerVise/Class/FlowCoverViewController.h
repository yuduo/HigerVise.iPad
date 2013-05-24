//
//  FlowCoverViewController.h
//  FlowCover
//
//  Created by William Woody on 12/13/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowCoverView.h"

@interface FlowCoverViewController : UIViewController <FlowCoverViewDelegate>
{

}
-(id)init;
@property(nonatomic,strong)NSMutableArray *data;
@end

