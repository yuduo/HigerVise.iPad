//
//  MyWebView.h
//
//  Created by pubo on 11-5-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyWebViewDelegate <NSObject>
@optional
- (void)doneBtnWasClicked;
@end

@interface MyWebView : UIView {
	
	id delegate_;
	UINavigationBar *bar;
	UIWebView *webView;
}
@property (nonatomic, assign) id<MyWebViewDelegate> delegate;

- (void) loadRequest:(NSURLRequest *)requeset;


@end
