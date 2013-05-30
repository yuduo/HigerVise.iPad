//
//  FatNavigationController.m
//  FatNav
//
//  Created by 23 on 3/8/13.
//  Copyright (c) 2013 Aged and Distilled. All rights reserved.
//

#import "FatNavigationController.h"

#import <QuartzCore/QuartzCore.h>

const CGFloat kFatNavigationTransitionDuration = 0.3;

@interface UIView (FatNavDebugging)

- (NSString*) recursiveDescription;

@end


@interface FatNavigationController ()

@end

@implementation FatNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    NSLog(@"\n------\nNavigationController- willLayoutSubviews\n------");
}

- (void)viewDidLayoutSubviews
{
    [self layoutNavigationAndContent];
}

- (void) layoutNavigationAndContent
{
 
    //Method 1: Super hack - adjust the wrapper view that we know is in the heirarchy

//    CGRect navigationBarFrame = self.navigationBar.frame;
//    navigationBarFrame.origin.y = 20.0; // Would need to account for status bar being hidden or a different size
//    self.navigationBar.frame = navigationBarFrame;
//    
//    UIView* containerView = self.view;
//    Class wrapperClass = NSClassFromString(@"UIViewControllerWrapperView");
//    Class transitionClass = NSClassFromString(@"UINavigationTransitionView");
//    UIView* wrapperView = nil;
//    UIView* transitionView = nil;
//    
//    for ( UIView* subview in containerView.subviews )
//    {
//        if ( [subview isKindOfClass:transitionClass] )
//        {
//            transitionView = subview;
//            break;
//        }
//    }
//    
//    for ( UIView* subview in transitionView.subviews )
//    {
//        if ( [subview isKindOfClass:wrapperClass] )
//        {
//            wrapperView = subview;
//            break;
//        }
//    }
//    
//    CGRect containerFrame = containerView.frame;
//    CGRect wrapperFrame = wrapperView.frame;
//    
//    wrapperFrame.origin.y = CGRectGetMaxY(navigationBarFrame);
//    wrapperFrame.size.height = containerFrame.size.height - CGRectGetMinY(wrapperFrame);
//
//    wrapperView.frame = wrapperFrame;
    
    //Method 2: adjust the content view and it's direct parent
    // still relying on a view heirarchy structure some. What if Apple adds another
    // ancestor view that needs adjusting?
    
    CGRect navigationBarFrame = self.navigationBar.frame;
    navigationBarFrame.origin.y = 20.0;
        //TODO:  Would need to account for status bar being hidden or a different size
    self.navigationBar.frame = navigationBarFrame;
    
    
    CGFloat extraHeight = navigationBarFrame.size.height - 44.0;
    
    UIViewController* topViewController = self.topViewController;

    UIView* contentView = topViewController.view;
    UIView* containerView = contentView.superview;
    
    CGRect contentFrame = contentView.frame;
    contentFrame.size.height -= extraHeight;
    contentView.frame = contentFrame;
    
    CGRect containerFrame = containerView.frame;
    containerFrame.size.height -= extraHeight;
    containerFrame.origin.y += extraHeight;
    containerView.frame = containerFrame;
    
}


- (UIImage*) imageSnapshotOfView:(UIView*)view
{
    UIGraphicsBeginImageContext(view.frame.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return snapshotImage;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
  //  NSLog(@"\n%@",[(id)self.view.superview recursiveDescription]);
   // NSLog(@"----------------\n");


    //TODO: animation in the nav bar.
    //      Can't push and pop the managed nav bar, so we'll have to do our own animation for it as well
    
    UIView* currentView = self.topViewController.view;
    CGRect currentViewFrame = currentView.frame;
    
    UIImage* currentViewSnapshot = [self imageSnapshotOfView:currentView];
    UIImageView* snapshotImageView = [[UIImageView alloc] initWithImage:currentViewSnapshot];
    
    [super pushViewController:viewController animated:NO];
    
    UIView* destinationView = viewController.view;
    CGRect destinationViewEndFrame = currentViewFrame;
    CGRect destinationViewStartFrame = destinationViewEndFrame;
    destinationViewStartFrame.origin.x = destinationView.frame.size.width;

    currentViewFrame.origin.x = -destinationView.frame.size.width;
    snapshotImageView.frame = currentViewFrame;
    
    [destinationView addSubview:snapshotImageView];
    destinationView.frame = destinationViewStartFrame;
    
    
    void (^animations)(void) = ^ {
        
        [destinationView setFrame:destinationViewEndFrame];
        // TODO: Animate the navigationItems
        // or maybe just do a temp nav bar and animate that and then remove it
    };
    
    [UIView animateWithDuration:kFatNavigationTransitionDuration delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:animations completion:^(BOOL finished) {
        [snapshotImageView removeFromSuperview];
    }];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    UIView* currentView = self.topViewController.view;
    CGRect currentViewFrame = currentView.frame;
    
    UIImage* currentViewSnapshot = [self imageSnapshotOfView:currentView];
    UIImageView* snapshotImageView = [[UIImageView alloc] initWithImage:currentViewSnapshot];
    
    UIViewController* poppedViewController = [super popViewControllerAnimated:NO];
    
    UIView* destinationView = self.topViewController.view;
    CGRect destinationViewEndFrame = destinationView.frame;
    CGRect destinationViewStartFrame = destinationViewEndFrame;
    destinationViewStartFrame.origin.x = -destinationView.frame.size.width;
    
    BOOL restoredClipsToBounds = destinationView.clipsToBounds;
    destinationView.clipsToBounds = NO;
    
    currentViewFrame.origin.x = destinationView.frame.size.width;
    snapshotImageView.frame = currentViewFrame;
    
    [destinationView addSubview:snapshotImageView];
    destinationView.frame = destinationViewStartFrame;
    
    void (^animations)(void) = ^ {
        
        [destinationView setFrame:destinationViewEndFrame];
        // TODO: Animate the navigationItems
        // or maybe just do a temp nav bar and animate that and then remove it
    };
    
    [UIView animateWithDuration:kFatNavigationTransitionDuration delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:animations completion:^(BOOL finished) {
        [snapshotImageView removeFromSuperview];
        destinationView.clipsToBounds = restoredClipsToBounds;
    }];
    
    
    return poppedViewController;
}


@end
