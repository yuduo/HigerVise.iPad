//
//  MyBookView.h
//
//  Created by pubo on 11-5-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIProgressDelegate.h"
#import "LSHTTPImageKit.h"

@class ResourceView;
//书的代理
@protocol ResourceViewDelegate <NSObject>
 @optional
- (void)downBtnOfBookWasClicked:(ResourceView *)book;//下载
- (void)pauseBtnOfBookWasClicked:(ResourceView *)book;//暂停
- (void)readBtnOfBookWasClicked:(ResourceView *)book;//查看
- (void)markBtnOfBookWasClicked:(ResourceView *)book;
- (void)viewBtnOfBookWasClicked:(ResourceView *)book;
@end


@interface ResourceView : UIView <ASIProgressDelegate,LSHTTPImageKitDelegate,UIGestureRecognizerDelegate>{

	id delegate;
	int bookID;//ID
	NSString *bookName;//book名字
    int bookType;
	float contentLength;//书的大小(BIT)
	NSString *bookPath;//书的路径
    NSString *picturePath;
	UIButton *downButton;//下载按键
    UIButton *addButton;//添加按键
	UIProgressView *zztjProView;//系统的进度条
	UIImageView *imageProView;//自己做的进度条VIEW
	UIImageView *imageProBgView;//自己做的进度条VIEW背景
	UILabel *bookNameText;//显示书的名字
    UILabel *sizeText;
    UILabel *detailText;
    UILabel *dateText;
	BOOL downloadCompleteStatus;//下载状态(是否已经下载完成)
    NSInteger buttonState;
    LSHTTPImageKit* _imageKit;
    NSMutableArray* _arrMatch;
    NSMutableDictionary* _memoryCache;
    UITapGestureRecognizer       *_tapGesture;

}
@property (nonatomic, retain) LSHTTPImageKit* imageKit;
@property (nonatomic,assign)id<ResourceViewDelegate> delegate;

@property (nonatomic,assign)int bookID;
@property (nonatomic,assign)int downState;

@property(nonatomic ,retain)NSString *bookName;
@property(nonatomic ,retain)NSString *createTime;
@property(nonatomic ,retain)NSString *resourceSize;
@property(nonatomic ,retain)NSString *videoDuration;
@property(nonatomic ,retain)NSString *imageCount;
@property(nonatomic ,assign)int bookType;
@property (nonatomic,assign)float contentLength;
@property(nonatomic ,retain)NSString *bookPath;
@property(nonatomic ,retain)NSString *picturePath;
@property(nonatomic ,retain)UIButton *downButton;
@property(nonatomic ,retain)UIButton *addButton;
@property(nonatomic ,retain)UIProgressView *zztjProView;
@property(nonatomic ,retain)UIImageView *imageProView;
@property(nonatomic ,retain)UIImageView *imageProBgView;
@property(nonatomic ,retain)UILabel *bookNameText;
@property (nonatomic,assign)BOOL downloadCompleteStatus;

-(void)startUnZip;
- (id)initWithFrame:(CGRect)frame picturePath:(NSString*)picturePath;
-(void)setButtonState:(BOOL)addButtonState;
@end
