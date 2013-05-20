//
//  MyBookView.h
//
//  Created by pubo on 11-5-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIProgressDelegate.h"

@class MyBookView;
//书的代理
@protocol MyBookDelegate <NSObject>
 @optional
- (void)downBtnOfBookWasClicked:(MyBookView *)book;//下载
- (void)pauseBtnOfBookWasClicked:(MyBookView *)book;//暂停
- (void)readBtnOfBookWasClicked:(MyBookView *)book;//查看
@end


@interface MyBookView : UIView <ASIProgressDelegate>{

	id delegate;
	int bookID;//ID
	NSString *bookName;//book名字
    NSString *bookType;
	float contentLength;//书的大小(BIT)
	NSString *bookPath;//书的路径
    NSString *picturePath;
	UIButton *downButton;//下载按键

	UIProgressView *zztjProView;//系统的进度条
	UIImageView *imageProView;//自己做的进度条VIEW
	UIImageView *imageProBgView;//自己做的进度条VIEW背景
	UILabel *downText;//显示书的名字
	BOOL downloadCompleteStatus;//下载状态(是否已经下载完成)
    NSInteger buttonState;
}

@property (nonatomic,assign)id<MyBookDelegate> delegate;

@property (nonatomic,assign)int bookID;
@property (nonatomic,assign)int downState;
@property (nonatomic,assign)int resourceType;
@property(nonatomic ,retain)NSString *bookName;
@property(nonatomic ,retain)NSString *bookType;
@property (nonatomic,assign)float contentLength;
@property(nonatomic ,retain)NSString *bookPath;
@property(nonatomic ,retain)NSString *picturePath;
@property(nonatomic ,retain)UIButton *downButton;

@property(nonatomic ,retain)UIProgressView *zztjProView;
@property(nonatomic ,retain)UIImageView *imageProView;
@property(nonatomic ,retain)UIImageView *imageProBgView;
@property(nonatomic ,retain)UILabel *downText;
@property (nonatomic,assign)BOOL downloadCompleteStatus;
@end
