//
//  MgzWebView.m
//
//  Created by pubo on 11-5-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyWebView.h"


@implementation MyWebView

@synthesize delegate = delegate_;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		frame.origin.y += 44;
		frame.size.height -= 44;
		webView = [[UIWebView alloc] initWithFrame:frame];
		bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 44)];
		UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:nil];
		UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Exit" 
																   style:UIBarButtonItemStyleDone 
																  target:self 
																  action:@selector(removeSelf)];
		
		[self addSubview:bar];
		[self addSubview:webView];
		[bar pushNavigationItem:item animated:NO];
		[item setLeftBarButtonItem:button];
		[item release];
		[button release];
		
    }
    return self;
}

- (void) loadRequest:(NSURLRequest *)requeset {
	
	[webView loadRequest:requeset];
}

- (void)removeSelf {
	
	[delegate_ doneBtnWasClicked];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code.
 }
 */

- (void)dealloc {
	
	delegate_ = nil;
	[bar release];
	[webView release];
    [super dealloc];
}


@end
