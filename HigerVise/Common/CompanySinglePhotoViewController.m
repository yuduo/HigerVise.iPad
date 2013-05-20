//
//  CompanySinglePhotoViewController.m
//  Locoso
//
//  Created by yongchang hu on 11-12-9.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "CompanySinglePhotoViewController.h"

@implementation CompanySinglePhotoViewController
@synthesize imageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"公司Logo";
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
- (void)dealloc {
    [imageView release];
    
    
    [super dealloc];
}
#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

-(void)doBack: (id) sender
{
    [self.navigationController popViewControllerAnimated:YES]; 
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    /////////////////////
//    UIImage* image= [UIImage imageNamed:@"back_icon.png"]; 
//    CGRect frame_1= CGRectMake(0, 0, image.size.width, image.size.height); 
//    UIButton* backButton= [[UIButton alloc] initWithFrame:frame_1]; 
//    [backButton setBackgroundImage:image forState:UIControlStateNormal]; 
//    
//    [backButton addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside]; 
//    
//    //定制自己的风格的 UIBarButtonItem
//    UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton]; 
//    [self.navigationItem setLeftBarButtonItem:someBarButtonItem]; 
//    [someBarButtonItem release]; 
//    [backButton release]; 
    ////////////////////////
}

- (void)loadView {
    imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.backgroundColor = [UIColor whiteColor];
    
    imageView.image = [UIImage imageNamed:@"moren.png"];
    self.view = imageView;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.imageView = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
