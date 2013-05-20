//
//  CustomMessageView.m
//  Locoso
//
//  Created by yongchang hu on 11-12-29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "CustomMessageView.h"
#import "UIColorTool.h"
#import "SizeOfControllerFont.h"
@implementation CustomMessageView
@synthesize coustomMsg,coustomName,leavedata,leaveMessage;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.opaque = YES;
		self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)setCellNSStringValue:(NSString*)MsgContent MsgName:(NSString*)usrName LeaveData:(NSString*)leaveData LeaveMsg:(NSString*)leaveMsg
{
     coustomMsg = MsgContent;
     coustomName = usrName;
     leavedata = leaveData;
     leaveMessage = leaveMsg;

    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
#define LEFT_COLUMN_OFFSET 10
#define LEFT_COLUMN_WIDTH 130
	
#define MIDDLE_COLUMN_OFFSET 140
#define MIDDLE_COLUMN_WIDTH 110
    
#define RIGHT_COLUMN_OFFSET 270
	
#define UPPER_ROW_TOP 8
#define LOWER_ROW_TOP 34
	
#define MAIN_FONT_SIZE 18
#define MIN_MAIN_FONT_SIZE 16
#define SECONDARY_FONT_SIZE 12
#define MIN_SECONDARY_FONT_SIZE 10
    
	// Color and font for the main text items (time zone name, time)

	//UIFont *mainFont = [UIFont systemFontOfSize:MAIN_FONT_SIZE];
    UIFont *mainFont = [UIFont fontWithName:@"Arial" size:13];
	// Color and font for the secondary text items (GMT offset, day)

	//UIFont *secondaryFont = [UIFont systemFontOfSize:SECONDARY_FONT_SIZE];
	UIFont *secondaryFont = [UIFont fontWithName:@"Arial" size:12];
	
//	CGRect contentRect = CGRectMake(0, 0, 320, MESSAGEMANAGEVIEWCONTROLLER_LIST_HEIGHT);
    CGFloat actualFontSize;

    // Drawing code

//    size = [coustomMsg sizeWithFont:mainFont minFontSize:MIN_MAIN_FONT_SIZE actualFontSize:&actualFontSize forWidth:MIDDLE_COLUMN_WIDTH lineBreakMode:UILineBreakModeTailTruncation];
    [[UIColor blackColor] set];


    [coustomMsg drawAtPoint:CGPointMake(13, 0) forWidth:320 withFont:mainFont minFontSize:13 actualFontSize:&actualFontSize lineBreakMode:UILineBreakModeTailTruncation baselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    
    [[UIColorTool colorWithHexString:@"#6a6a6a"] set];
    
    [coustomName drawAtPoint:CGPointMake(13, 30) forWidth:160 withFont:secondaryFont minFontSize:12 actualFontSize:&actualFontSize lineBreakMode:UILineBreakModeTailTruncation baselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    
    [leavedata drawAtPoint:CGPointMake(140, 30) forWidth:160 withFont:secondaryFont minFontSize:12 actualFontSize:&actualFontSize lineBreakMode:UILineBreakModeTailTruncation baselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    
    
    
    if (![leaveMessage isEqualToString:@""]) {
        CGRect newRect = CGRectMake(0, 60, 320, 60); 
        UIColor *myColor = [UIColor colorWithRed:((float)255.0f/255.0f) green:((float)252.0f/255.0f) blue:((float)237.0f/255.0f) alpha:1.0]; 
        [myColor set]; 
        UIRectFill(newRect); 
    }
    
    
    [[UIColorTool colorWithHexString:@"#eb7a00"] set];
    [leaveMessage drawAtPoint:CGPointMake(13, 70) forWidth:160 withFont:mainFont minFontSize:13 actualFontSize:&actualFontSize lineBreakMode:UILineBreakModeTailTruncation baselineAdjustment:UIBaselineAdjustmentAlignBaselines];
}
- (void)dealloc {
	[coustomMsg release];
	[coustomName release];
	[leaveMessage release];
    [leavedata release];
    [super dealloc];
}
-(void)SetCCoustomMsg:(NSString *)setStr
{
    
}
-(void)SetCCoustomName:(NSString * )setStr
{
    
}
-(void)SetCLeaveData:(NSString *)setStr
{
    
}
-(void)SetCLeaveMsg:(NSString *)setStr
{
    
}
@end
