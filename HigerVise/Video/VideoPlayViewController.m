//
//  ViewController.m
//  FullscreenVideoTest
//
//  Created by Peng on 8/27/12.
//  Copyright (c) 2012 Cocoa Star Apps. All rights reserved.
//

#import "VideoPlayViewController.h"

@interface VideoPlayViewController (PrivateMethods)


@end

@implementation VideoPlayViewController

@synthesize moviePlayer;
@synthesize videoAssetURL;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.videoAssetURL = [NSURL URLWithString:@"assets-library://asset/asset.MOV?id=E7EC800D-1E9C-4534-BCA5-D772F27418EE&ext=MOV"];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)playVideoWithMoviePlayerViewController
{
    self.navigationController.navigationBarHidden = YES;
    MPMoviePlayerViewController *viewController = [[MPMoviePlayerViewController alloc] initWithContentURL:self.videoAssetURL];
    [self presentMoviePlayerViewControllerAnimated:viewController];
}

- (void)playVideoWithMoviePlayerController
{
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:self.videoAssetURL];
    self.moviePlayer.controlStyle = MPMovieControlStyleDefault;
    self.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
    self.moviePlayer.shouldAutoplay = YES;
    self.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(loadStateDidChange:)
//                                                 name:MPMoviePlayerLoadStateDidChangeNotification
//                                               object:self.moviePlayer];
    
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:self.moviePlayer];
    
//	[[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
//                                                 name:MPMediaPlaybackIsPreparedToPlayDidChangeNotification
//                                               object:self.moviePlayer];
    
//	[[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(moviePlayBackStateDidChange:)
//                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
//                                               object:self.moviePlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayerDidExitFullscreen:)
                                                 name:MPMoviePlayerDidExitFullscreenNotification
                                               object:self.moviePlayer];
    
    [self.moviePlayer.view setFrame:self.view.bounds];
    [self.view addSubview:self.moviePlayer.view];
    [self.moviePlayer setFullscreen:YES animated:YES];
}

/* Handle movie load state changes. */
//- (void)loadStateDidChange:(NSNotification *)notification
//{
////	MPMoviePlayerController *player = notification.object;
//	MPMovieLoadState loadState = self.moviePlayer.loadState;
//    
//	/* The load state is not known at this time. */
//	if (loadState & MPMovieLoadStateUnknown) {
//        NSLog(@"loadStateDidChange:loadStateDidChange");
//	}
//	
//	/* The buffer has enough data that playback can begin, but it
//	 may run out of data before playback finishes. */
//	if (loadState & MPMovieLoadStatePlayable) {
//        NSLog(@"loadStateDidChange:MPMovieLoadStatePlayable");
//	}
//	
//	/* Enough data has been buffered for playback to continue uninterrupted. */
//	if (loadState & MPMovieLoadStatePlaythroughOK) {
//        NSLog(@"loadStateDidChange:MPMovieLoadStatePlaythroughOK");
//	}
//	
//	/* The buffering of data has stalled. */
//	if (loadState & MPMovieLoadStateStalled) {
//        NSLog(@"loadStateDidChange:MPMovieLoadStateStalled");
//	}
//}

- (void)moviePlayBackDidFinish:(NSNotification*)notification
{
    NSNumber *reason = [[notification userInfo] objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    NSLog(@"moviePlayBackDidFinish:%@", reason);
    
    switch ([reason integerValue])
    {
            /* The end of the movie was reached. */
        case MPMovieFinishReasonPlaybackEnded:
            NSLog(@"moviePlayBackDidFinish:MPMovieFinishReasonPlaybackEnded");
            [self.moviePlayer setFullscreen:NO animated:YES];
            break;
            
            /* An error was encountered during playback. */
        case MPMovieFinishReasonPlaybackError:
            NSLog(@"moviePlayBackDidFinish:MPMovieFinishReasonPlaybackError");
            [self performSelectorOnMainThread:@selector(displayError:)
                                   withObject:[[notification userInfo] objectForKey:@"error"]
                                waitUntilDone:NO];
            break;
            
            /* The user stopped playback. */
        case MPMovieFinishReasonUserExited:
        NSLog(@"moviePlayBackDidFinish:MPMovieFinishReasonUserExited");
            [self.moviePlayer setFullscreen:NO animated:YES];
            break;
            
        default:
            break;
    }
}

/* Called when the movie playback state has changed. */
//- (void)moviePlayBackStateDidChange:(NSNotification*)notification
//{
//	MPMoviePlayerController *player = notification.object;
//    
//	/* Playback is currently stopped. */
//	if (player.playbackState == MPMoviePlaybackStateStopped)
//	{
//        NSLog(@"moviePlayBackStateDidChange:MPMoviePlaybackStateStopped");
//	}
//	/*  Playback is currently under way. */
//	else if (player.playbackState == MPMoviePlaybackStatePlaying)
//	{
//        NSLog(@"moviePlayBackStateDidChange:MPMoviePlaybackStatePlaying");
//	}
//	/* Playback is currently paused. */
//	else if (player.playbackState == MPMoviePlaybackStatePaused)
//	{
//        NSLog(@"moviePlayBackStateDidChange:MPMoviePlaybackStatePaused");
//	}
//	/* Playback is temporarily interrupted, perhaps because the buffer
//	 ran out of content. */
//	else if (player.playbackState == MPMoviePlaybackStateInterrupted)
//	{
//        NSLog(@"moviePlayBackStateDidChange:MPMoviePlaybackStateInterrupted");
//	}
//}

/* Notifies observers of a change in the prepared-to-play state of an object
 conforming to the MPMediaPlayback protocol. */
//- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification
//{
//	NSLog(@"mediaIsPreparedToPlayDidChange");
//}

- (void)moviePlayerDidExitFullscreen:(NSNotification*)notification
{
    NSLog(@"moviePlayerDidExitFullscreen");
    [self dismissMoviePlayer];
    //remove from super view
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)dismissMoviePlayer
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                    name:MPMoviePlayerLoadStateDidChangeNotification
//                                                  object:self.moviePlayer];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:self.moviePlayer];
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                    name:MPMediaPlaybackIsPreparedToPlayDidChangeNotification
//                                                  object:self.moviePlayer];
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                    name:MPMoviePlayerPlaybackStateDidChangeNotification
//                                                  object:self.moviePlayer];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerDidExitFullscreenNotification
                                                  object:self.moviePlayer];
    
    if ([self.moviePlayer respondsToSelector:@selector(setFullscreen:animated:)]) {
        [self.moviePlayer.view removeFromSuperview];
        self.moviePlayer = nil;
    }
}

-(void)displayError:(id)info
{
    //
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"出错" message:@"不支持这种格式" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    [alertView show];
}
@end
