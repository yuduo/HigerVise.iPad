//
//  LSImageMatch.h
//  HigerManage
//
//  Created by jijesoft on 13-5-23.
//  Copyright (c) 2013年 WuHanNvl. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - LSImageMatch
@interface LSImageMatch : NSObject
{
    UIView* _view;
    NSString* _imageURL;
}
@property (nonatomic, retain) UIView* view;
@property (nonatomic, retain) NSString* imageURL;
@end

