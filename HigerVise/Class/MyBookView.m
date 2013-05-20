//
//  MyBookView.m
//
//  Created by pubo on 11-5-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyBookView.h"
#import "ASIHTTPRequest.h"
#import "ZipArchive.h"
#import "MBProgressHUD.h"

@implementation MyBookView

@synthesize delegate;
@synthesize bookID,downState,resourceType;
@synthesize bookName,bookType;
@synthesize contentLength;
@synthesize bookPath,picturePath;

@synthesize downButton;

@synthesize zztjProView;
@synthesize imageProView;
@synthesize imageProBgView;
@synthesize downText;
@synthesize downloadCompleteStatus;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		self.backgroundColor = [UIColor clearColor];
		
        //picture
        // 展示图片
        UIImageView *bookView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, 130, 175)];
        NSString *bookName = @"Book_Cover.png";
        bookView.image = [UIImage imageNamed:bookName];
        [self addSubview:bookView];
        
		//系统进度条的设置
		zztjProView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 100, 150, 20)];
		//自己的进度条设置,默认宽度为0
		imageProView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 121, 0, 4)];
		[imageProView setImage:[UIImage imageNamed:@"proImage.png"]];
		//自己进度条的背景
		imageProBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 120, 150, 6)];
		//[imageProBgView setImage:[UIImage imageNamed:@"proImage_bg.png"]];
		imageProBgView.backgroundColor = [UIColor blackColor];
        
		//初始化显示书名的Lable
		downText = [[UILabel alloc] initWithFrame:CGRectMake(0, 180-15, 50, 30)];
        downText.backgroundColor = [UIColor clearColor];
		downText.text = @"book";
        
		//初始化下载按键
		self.downButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		downButton.frame = CGRectMake(50, 180-15, 100, 30);
		[downButton setTitle:@"down" forState:UIControlStateNormal];
		[downButton setTitle:@"waiting..." forState:UIControlStateDisabled];
		[downButton addTarget:self action:@selector(downButtonClick) forControlEvents:UIControlEventTouchDown];
		
        [self addSubview:zztjProView];
		[self addSubview:imageProBgView];
		[self addSubview:imageProView];
		[self addSubview:downText];

		[self addSubview:downButton];
        

    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code.
	//设置书的名字
	downText.text = bookName;
	//判断是否下载成功
	if (downloadCompleteStatus) {//下载状态(已经下载成功)
		
//		//下载按键启用
		downButton.enabled = YES;
//		//下载按键隐藏
//		downButton.hidden = YES;
		self.downState = 2;
        [downButton setTitle:@"read" forState:UIControlStateNormal];
		
		//系统进度条隐藏
		zztjProView.hidden = YES;
		//自己的进度条隐藏
		imageProView.hidden = YES;
		//自己的进度条背景隐藏
		imageProBgView.hidden = YES;
		
		
	}else {
		
		//下载按键显示
//		downButton.hidden =	NO;
//		//下载按键启用
//		downButton.enabled = YES;
	}
}

#pragma mark -
#pragma mark click method
- (void)downButtonClick {//下载按键事件
	if (downState) {
        //read
        if ([delegate respondsToSelector:@selector(readBtnOfBookWasClicked:)]) {
            
            //调用 DownAndASIRequestViewController 的 readBtnOfBookWasClicked 方法
            [delegate readBtnOfBookWasClicked:self];
        }
        return;
    }
	if ([delegate respondsToSelector:@selector(downBtnOfBookWasClicked:)]) {
		//下载按键禁用
		downButton.enabled = NO;
		
		//调用 DownAndASIRequestViewController 的 downBtnOfBookWasClicked 方法
		[delegate downBtnOfBookWasClicked:self];
	}
}

-(void)unZipClick {//解压按键事件
	
	MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self animated:YES];
	mbp.labelText = @"   解压中,请等待...   ";
	//初始化Documents路径
	NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
	//设置ZIP文件路径
	NSString *filePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"book_%d.zip",bookID]];
	//设置解压文件夹的路径
	NSString *unZipPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"book_%d",bookID]];
	//初始化ZipArchive
	ZipArchive *zip = [[ZipArchive alloc] init];
	
	BOOL result;
	
	if ([zip UnzipOpenFile:filePath]) {
		
		result = [zip UnzipFileTo:unZipPath overWrite:YES];//解压文件
		if (!result) {
			//解压失败
			NSLog(@"unzip fail................");
		}else {
			//解压成功
			NSLog(@"unzip success.............");
			//因为文件小,解压太快,为了更好的看到效果,故添加了一个3秒之后执行的取消"菊花"操作.
			[self performSelector:@selector(threeClick) withObject:nil afterDelay:3];
		}

		[zip UnzipCloseFile];//关闭
	}
	
	
}
- (void)threeClick {
	
	[MBProgressHUD hideHUDForView:self animated:YES];

}

-(void)readClick {//查看按键事件
	
	if ([delegate respondsToSelector:@selector(readBtnOfBookWasClicked:)]) {
		
		//调用 DownAndASIRequestViewController 的 readBtnOfBookWasClicked 方法
		[delegate readBtnOfBookWasClicked:self];
	}
}

- (void)deleteButtonClick {//删除按键事件
	//初始化Documents路径
	NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
	//设置ZIP文件路径
	NSString *zipPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"book_%d.zip",bookID]];
	//设置文件夹路径
	NSString *folderPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"book_%d",bookID]];
	//创建文件管理器
	NSFileManager *fileManager = [NSFileManager defaultManager];
	//判断ZIP文件是否存在
	if ([fileManager fileExistsAtPath:zipPath]) {
		//如果存在就删除
		[fileManager removeItemAtPath:zipPath error:nil];
	}
	BOOL result;
	//判断文件夹是否存在
	if ([fileManager fileExistsAtPath:folderPath]) {
		//如果存在就删除
		result = [fileManager removeItemAtPath:folderPath error:nil];
	}
	//删除成功,所有按键回到最初状态
	if (result) {
		//系统进度条显示
		zztjProView.hidden = NO;
		//进度值为0
		zztjProView.progress = 0;
		//自己的进度条显示
		imageProView.hidden = NO;
		//自己的进度条背景显示
		imageProBgView.hidden = NO;
		//设置自己的进度条VIEW的frame的width为0
		imageProView.frame = CGRectMake(75, 121, 0, 4);
		//下载状态为NO
		downloadCompleteStatus = NO;

		//把持久化的大小设置为0,当重新下载时重新赋值
		NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
		[userDefaults setObject:[NSNumber numberWithFloat:0.0] forKey:[NSString stringWithFormat:@"book_%d_contentLength",bookID]];
	}
}



#pragma mark -
#pragma mark ASIProgressDelegate method


- (void)setProgress:(float)newProgress {//进度条的代理
	
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	//从持久化里面取出内容的总大小
	self.contentLength = [[userDefaults objectForKey:[NSString stringWithFormat:@"book_%d_contentLength",bookID]] floatValue];
	//设置进度文本
	downText.text = [NSString stringWithFormat:@"%.2f/%.2fM",self.contentLength*newProgress,self.contentLength];
	//设置自己的进度条
	imageProView.frame = CGRectMake(75, 121, 150*newProgress, 4);
	//设置系统的进度条
	zztjProView.progress = newProgress;
}



#pragma mark -
#pragma mark dealloc method

- (void)dealloc {
	
	[downButton release];

	[zztjProView release];
	[imageProView release];
	[imageProBgView release];
	[downText release];
	
    [super dealloc];
}


@end
