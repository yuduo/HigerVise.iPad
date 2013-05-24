//
//  FlowCoverViewController.m
//  FlowCover
//
//  Created by William Woody on 12/13/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "FlowCoverViewController.h"
#import "BookshelfViewController.h"
#import "book_list_model.h"
#import "client_catgory.h"
@implementation FlowCoverViewController

@synthesize data;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/
-(id)init
{
    self = [super init];
    data = [[NSMutableArray alloc] init];
    
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBarHidden = YES;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    return ((interfaceOrientation == UIInterfaceOrientationLandscapeLeft) ||
			(interfaceOrientation == UIInterfaceOrientationLandscapeRight));
}


- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}


/************************************************************************/
/*																		*/
/*	FlowCover Callbacks													*/
/*																		*/
/************************************************************************/

- (int)flowCoverNumberImages:(FlowCoverView *)view
{
	return [data count];
}
- (UIImage *)backgroundImage
{

    return [UIImage imageNamed:@"cover_bg.png"];
}
- (UIImage *)flowCover:(FlowCoverView *)view cover:(int)image
{
	switch (image % [data count]) {
		case 0:
		default:
			return [UIImage imageNamed:@"book.png"];
		case 1:
			return [UIImage imageNamed:@"book.png"];
		case 2:
			return [UIImage imageNamed:@"book.png"];
		case 3:
			return [UIImage imageNamed:@"book.png"];
		case 4:
			return [UIImage imageNamed:@"book.png"];
		case 5:
			return [UIImage imageNamed:@"book.png"];
        
	}
}
- (NSString *)flowCover:(FlowCoverView *)view text:(int)index
{
	if (index <= [data count]) {
        client_catgory *cat = [data objectAtIndex:index];
        return cat.catgory_name;
    }
    return @"";
}
- (void)flowCover:(FlowCoverView *)view didSelect:(int)image
{
	NSLog(@"Selected Index %d",image);
    //start animate
    
    //read database
    NSInteger index = abs(image % [data count]);
    client_catgory *cat = [data objectAtIndex:index];
    NSArray *db = [book_list_model getBookList:[cat.resource_class_id integerValue]];
    if (db != nil) {
        //
    }
    
    //stop animate
    
    //go to book
    BookshelfViewController *ibook = [[BookshelfViewController alloc]init];
    ibook.data = [[NSMutableArray alloc]initWithArray: db];
    [self.navigationController pushViewController:ibook animated:YES];
}


@end
