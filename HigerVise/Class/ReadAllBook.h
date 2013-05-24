//
//  ReadAllBook.h
//  HigerManage
//
//  Created by jijesoft on 13-5-22.
//  Copyright (c) 2013年 WuHanNvl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FGalleryViewController.h"
#import "ReaderViewController.h"


#define RESOURCE_TYPE_MP4 2
#define RESOURCE_TYPE_PDF 1
#define RESOURCE_TYPE_IMAGE 3

@protocol ReadAllBookDelegate

@required
-(UIViewController*)getCurrentViewController;
@end

@interface ReadAllBook : NSObject<FGalleryViewControllerDelegate,ReaderViewControllerDelegate,ReadAllBookDelegate>
{
    FGalleryViewController *localGallery;
    FGalleryViewController *networkGallery;
    NSObject <ReadAllBookDelegate> *_viewSource;
    NSMutableArray *localImages;
    NSArray *localCaptions;
    
    NSArray *networkCaptions;
    NSArray *networkImages;
}
@property (nonatomic,assign) NSObject<ReadAllBookDelegate> *viewSource;
-(void)readButtonClicked:(NSInteger)tag path:(NSString*)path;
@end
