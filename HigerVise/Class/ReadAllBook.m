//
//  ReadAllBook.m
//  HigerManage
//
//  Created by jijesoft on 13-5-22.
//  Copyright (c) 2013年 WuHanNvl. All rights reserved.
//

#import "ReadAllBook.h"
#import "VideoPlayViewController.h"

@implementation ReadAllBook
@synthesize viewSource = _viewSource;
-(void)readButtonClicked:(NSInteger)tag path:(NSString*)path
{
    //pdf,video,photos
    switch (tag) {
        case RESOURCE_TYPE_MP4:
            //video
        {
            
            NSString *videoPath = path;
            NSURL *url = [NSURL fileURLWithPath:videoPath];
            VideoPlayViewController *videoPlayer = [[VideoPlayViewController alloc]init];
            videoPlayer.videoAssetURL = url;
            [[_viewSource getCurrentViewController].navigationController pushViewController:videoPlayer animated:YES];
            [videoPlayer playVideoWithMoviePlayerController];
        }
            break;
        case RESOURCE_TYPE_PDF:
            //PDF
        {
            
            NSString *filePath = path;
            ReaderDocument *document = [ReaderDocument withDocumentFilePath:filePath password:nil];
            if (document != nil) {
                ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
                readerViewController.delegate = self;
                [_viewSource getCurrentViewController].navigationController.navigationBarHidden = YES;
                [[_viewSource getCurrentViewController].navigationController pushViewController:readerViewController animated:YES];
                
            }
        }
            break;
        case RESOURCE_TYPE_IMAGE:
            //photos
            
        {
            localImages = [[NSMutableArray alloc] init];
            
            NSError *err;
            NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath: path error: &err];  // path 时绝对路径
            if ([files count]) {
                
                for (int i = 0; i < [files count]; i ++) {
                    
                    NSString *filename = [files objectAtIndex:i];
                    NSString *filepath = [path stringByAppendingPathComponent:filename];
                    //                    filepath = [filepath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    [localImages addObject:filepath];
                    NSLog(@"image path = %@", filepath);
                }
                
            }
            localGallery = [[FGalleryViewController alloc] initWithPhotoSource:self];
            [_viewSource getCurrentViewController].navigationController.navigationBarHidden = NO;
            [[_viewSource getCurrentViewController].navigationController pushViewController:localGallery animated:YES];
        }
            break;
        default:
            break;
    }
    
}

#pragma mark - FGalleryViewControllerDelegate Methods


- (int)numberOfPhotosForPhotoGallery:(FGalleryViewController *)gallery
{
    int num;
    if( gallery == localGallery ) {
        num = [localImages count];
    }
    else if( gallery == networkGallery )
    {
        num = [networkImages count];
    }
	return num;
}


- (FGalleryPhotoSourceType)photoGallery:(FGalleryViewController *)gallery sourceTypeForPhotoAtIndex:(NSUInteger)index
{
	if( gallery == localGallery ) {
		return FGalleryPhotoSourceTypeLocal;
	}
	else return FGalleryPhotoSourceTypeNetwork;
}


- (NSString*)photoGallery:(FGalleryViewController *)gallery captionForPhotoAtIndex:(NSUInteger)index
{
    
	return @"";
}


- (NSString*)photoGallery:(FGalleryViewController*)gallery filePathForPhotoSize:(FGalleryPhotoSize)size atIndex:(NSUInteger)index {
    return [localImages objectAtIndex:index];
}

- (NSString*)photoGallery:(FGalleryViewController *)gallery urlForPhotoSize:(FGalleryPhotoSize)size atIndex:(NSUInteger)index {
    return [networkImages objectAtIndex:index];
}

- (void)handleTrashButtonTouch:(id)sender {
    // here we could remove images from our local array storage and tell the gallery to remove that image
    // ex:
    //[localGallery removeImageAtIndex:[localGallery currentIndex]];
}


- (void)handleEditCaptionButtonTouch:(id)sender {
    // here we could implement some code to change the caption for a stored image
}
#pragma mark ReaderViewControllerDelegate

- (void)dismissReaderViewController:(ReaderViewController *)viewController
{
    [[_viewSource getCurrentViewController].navigationController popViewControllerAnimated:YES];
    
}

@end
