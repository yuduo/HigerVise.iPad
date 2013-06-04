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
#import "LSImageMatch.h"
#import "LSString.h"
#import "ReadAllBook.h"
#import "LSDefine.h"
#define DOWNLOAD_STATE_NONE 0
#define DOWNLOAD_STATE_DOWNING 1//downloading
#define DOWNLOAD_STATE_STOP 2//stop
#define DOWNLOAD_STATE_FINISHED 3

#define RESOURCE_TITLE_SIZE 20
#define RESOURCE_DETAIL_SIZE  16

#define RESOURCE_TITLE_COLOR [UIColor whiteColor]
#define RESOURCE_DETAIL_COLOR  LSRGBA(86,38,12,1)
@implementation MyBookView

@synthesize delegate;
@synthesize bookID,downState;
@synthesize bookName,bookType;
@synthesize contentLength;
@synthesize bookPath,picturePath;

@synthesize downButton;

@synthesize zztjProView;
@synthesize imageProView;
@synthesize imageProBgView;
@synthesize bookNameText;
@synthesize downloadCompleteStatus,createTime,resourceSize,videoDuration,imageCount;

- (id)initWithFrame:(CGRect)frame picturePath:(NSString*)picturePath{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		self.backgroundColor = [UIColor clearColor];
		int offset = 40;
        //picture
        // 展示图片
        UIImageView *bookView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 130, 175)];
        
        [self addImage:bookView imageURL:picturePath];
        
        [self addSubview:bookView];
        
        UIImageView *markView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 120-10+offset, 130, 40)];
        markView.image = [UIImage imageNamed:@"mark.png"];
        [self addSubview:markView];
        
		//系统进度条的设置
		zztjProView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 150+offset, 130, 20)];
        zztjProView.hidden = YES;
		//自己的进度条设置,默认宽度为0
		imageProView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 171+offset, 0, 4)];
		[imageProView setImage:[UIImage imageNamed:@"proImage.png"]];
		//自己进度条的背景
//		imageProBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 102, 130, 6)];
		//[imageProBgView setImage:[UIImage imageNamed:@"proImage_bg.png"]];
		imageProBgView.backgroundColor = [UIColor blackColor];
        
		//初始化显示书名的Lable
		bookNameText = [[UILabel alloc] initWithFrame:CGRectMake(0, 120+offset, 130, 20)];
        bookNameText.backgroundColor = [UIColor clearColor];
        bookNameText.textColor = RESOURCE_TITLE_COLOR;
        bookNameText.font = [UIFont fontWithName:RESOURCE_TEXT_FONT size:RESOURCE_TITLE_SIZE];
		bookNameText.text = @"book";
        
        int lable_x = 80;
        
		//初始化下载按键
		self.downButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 160+offset, 60, 30) ];
        
//		self.downButton.frame = CGRectMake(lable_x-20, 160, 100, 40);
        self.downButton.backgroundColor = [UIColor clearColor];
        UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(116, 180-10+offset, 14, 18)];
        icon.image = [UIImage imageNamed:@"download.png"];
//		[self.downButton setBackgroundImage:[UIImage imageNamed:@"download.png"] forState:UIControlStateNormal];
		[self.downButton addTarget:self action:@selector(downButtonClick) forControlEvents:UIControlEventTouchDown];
        
		int lable_detail_x = 162+offset;
        //初始化显示书名的Lable
		sizeText = [[UILabel alloc] initWithFrame:CGRectMake(0, lable_detail_x, 50, 30)];
        sizeText.backgroundColor = [UIColor clearColor];
		sizeText.text = @"";
        sizeText.textColor = RESOURCE_DETAIL_COLOR;
        sizeText.font = [UIFont fontWithName:RESOURCE_TEXT_FONT size:RESOURCE_DETAIL_SIZE];
        
        //初始化显示书名的Lable
		detailText = [[UILabel alloc] initWithFrame:CGRectMake(50, lable_detail_x, 66, 30)];
        detailText.backgroundColor = [UIColor clearColor];
		detailText.text = @"";
        detailText.textColor = RESOURCE_DETAIL_COLOR;
        detailText.font = [UIFont fontWithName:RESOURCE_TEXT_FONT size:RESOURCE_DETAIL_SIZE];
        
        //初始化显示书名的Lable
//		dateText = [[UILabel alloc] initWithFrame:CGRectMake(lable_x, 80, 100, 30)];
//        dateText.backgroundColor = [UIColor clearColor];
//		dateText.text = @"";
//        dateText.textColor = [UIColor blackColor];
        
        [self addSubview:zztjProView];
		[self addSubview:imageProBgView];
		[self addSubview:imageProView];
        
		[self addSubview:bookNameText];
        [self addSubview:sizeText];
        [self addSubview:detailText];
        [self addSubview:icon];
		[self addSubview:downButton];
        
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureUpdated:)];
        _tapGesture.delegate = self;
        _tapGesture.numberOfTapsRequired = 1;
        _tapGesture.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:_tapGesture];
        
        
        _sortingLongPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(sortingLongPressGestureUpdated:)];
        _sortingLongPressGesture.numberOfTouchesRequired = 1;
        _sortingLongPressGesture.delegate = self;
        [self addGestureRecognizer:_sortingLongPressGesture];
        
        //CLOSE
        closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		closeButton.frame = CGRectMake(130-15, 10, 30, 28);
		[closeButton setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
		[closeButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchDown];
        closeButton.hidden = YES;
        [self addSubview:closeButton];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code.
	//设置书的名字
	bookNameText.text = bookName;
    sizeText.text = resourceSize;
    switch (bookType) {
        case RESOURCE_TYPE_IMAGE:
            detailText.text = imageCount;
            break;
        case RESOURCE_TYPE_MP4:
            detailText.text = videoDuration;
//            detailText.text = @"";
            break;
        case RESOURCE_TYPE_PDF:
            detailText.text = @"";
            break;
        default:
            break;
    }
    dateText.text = createTime;
	//判断是否下载成功
	if (downloadCompleteStatus) {//下载状态(已经下载成功)
		

//		//下载按键隐藏

		self.downState = DOWNLOAD_STATE_FINISHED;
        
		
		//系统进度条隐藏
		zztjProView.hidden = YES;
		//自己的进度条隐藏
		imageProView.hidden = YES;
		//自己的进度条背景隐藏
		imageProBgView.hidden = YES;
		
		
	}else {
		
		
	}
}
-(BOOL)checkZip
{
    if ([bookPath hasSuffix:@"zip"]) {
        return YES;
    }
    return NO;
}
#pragma mark -
#pragma mark click method
-(void)startDownload
{
    if ([delegate respondsToSelector:@selector(downBtnOfBookWasClicked:)]) {
		//下载按键禁用
        
		//调用 DownAndASIRequestViewController 的 downBtnOfBookWasClicked 方法
		[delegate downBtnOfBookWasClicked:self];
	}
}
- (void)downButtonClick {//下载按键事件
    
	if (downState == DOWNLOAD_STATE_FINISHED ) {
        
        
        
        //read
        if ([delegate respondsToSelector:@selector(readBtnOfBookWasClicked:)]) {
            
            //调用 DownAndASIRequestViewController 的 readBtnOfBookWasClicked 方法
            [delegate readBtnOfBookWasClicked:self];
        }
        return;
    }

    
    switch (downState) {
        case DOWNLOAD_STATE_NONE:
            downState = DOWNLOAD_STATE_DOWNING;//downloading
//            [downButton setTitle:@"downing" forState:UIControlStateNormal];
            [self startDownload];
            break;
        case DOWNLOAD_STATE_DOWNING:
            downState = DOWNLOAD_STATE_STOP;//stop
//            [downButton setTitle:@"stop" forState:UIControlStateNormal];
            [self pauseButtonClick];
            break;
        case DOWNLOAD_STATE_STOP:
            downState = DOWNLOAD_STATE_DOWNING;
//            [downButton setTitle:@"downing" forState:UIControlStateNormal];
            [self startDownload];
            break;
        default:
            break;
    }
}
- (void)pauseButtonClick {//暂停按键事件
	
	if ([delegate respondsToSelector:@selector(pauseBtnOfBookWasClicked:)]) {
		//下载按键启用

		//调用 DownAndASIRequestViewController 的 pauseBtnOfBookWasClicked 方法
		[delegate pauseBtnOfBookWasClicked:self];
	}
	
}
-(void)startUnZip
{
    //unzip first
    if ([self checkZip]) {
        [self unZipClick];
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
	NSString *unZipPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"unzip/book_%d/",bookID]];
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
            //delete download zip file
            [self deleteDownloadZip:filePath];
			
			
		}

		[zip UnzipCloseFile];//关闭
	}
	
	[self performSelector:@selector(threeClick) withObject:nil afterDelay:3];
}

- (void)deleteDownloadZip:(NSString*)filePath
{

    //删除数据包以及临时文件夹
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:filePath error:nil];

}
- (void)threeClick {
	
	[MBProgressHUD hideHUDForView:self animated:YES];

}
-(void)closeButtonClick
{
    if ([delegate respondsToSelector:@selector(closeBtnOfBookWasClicked:)]) {
		
		//调用 DownAndASIRequestViewController 的 readBtnOfBookWasClicked 方法
		[delegate closeBtnOfBookWasClicked:self];
	}
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
	bookNameText.text = [NSString stringWithFormat:@"%.2f/%.2fM",self.contentLength*newProgress,self.contentLength];
	//设置自己的进度条
	imageProView.frame = CGRectMake(75, 121, 150*newProgress, 4);
	//设置系统的进度条
    zztjProView.hidden = NO;
	zztjProView.progress = newProgress;
}



#pragma mark -
#pragma mark dealloc method

- (void)dealloc {
	
	[downButton release];

	[zztjProView release];
	[imageProView release];
	[imageProBgView release];
	[bookNameText release];
	
    [super dealloc];
}

#pragma mark custom methods
- (void)addImage:(UIImageView*)aImageView imageURL:(NSString*)aImageURL
{
    [self addImage:aImageView imageURL:aImageURL useCache:YES];
}

- (void)addImage:(UIImageView*)aImageView imageURL:(NSString*)aImageURL useCache:(BOOL)aUseCache
{
    if (nil == aImageView || [aImageURL length] == 0)
    {
        NSLog(@"%@ addImage failed!",NSStringFromClass([self class]));
        return;
    }
    
    if (NO == aUseCache)
    {
        [_memoryCache removeObjectForKey:aImageURL];
    }
    else
    {
        UIImage* image = [self imageInMemoryCache:aImageURL];
        if (image)
        {
            aImageView.image = [self handleImageHook:image];
            //            [self didImageFinished:_imageKit imageURL:aImageURL image:image];
            NSLog(@"imageURL= %@\n image memeory cache",aImageURL);
            return;
        }
    }
    
    if (nil == _imageKit)
    {
        _imageKit = [[LSHTTPImageKit alloc] init];
    }
    [_imageKit addImage:aImageURL delegate:self useCache:aUseCache];
    
    if (nil == _arrMatch)
    {
        _arrMatch = [[NSMutableArray alloc] initWithCapacity:10];
    }
    LSImageMatch* match = [[LSImageMatch alloc] init];
    match.view  = aImageView;
    match.imageURL = aImageURL;
    [_arrMatch addObject:match];
    [match release];
}

- (void)addImageForButton:(UIButton*)aButton imageURL:(NSString*)aImageURL
{
    [self addImageForButton:aButton imageURL:aImageURL useCache:YES];
}

- (void)addImageForButton:(UIButton*)aButton imageURL:(NSString*)aImageURL useCache:(BOOL)aUseCache
{
    if (nil == aButton || [aImageURL length] == 0)
    {
        NSLog(@"%@ addImage failed!",NSStringFromClass([self class]));
        return;
    }
    
    if (NO == aUseCache)
    {
        [_memoryCache removeObjectForKey:aImageURL];
    }
    else
    {
        UIImage* image = [self imageInMemoryCache:aImageURL];
        if (image)
        {
            [aButton setImage:[self handleImageHook:image] forState:UIControlStateNormal];
            NSLog(@"imageURL= %@\n image memeory cache",aImageURL);
            return;
        }
    }
    
    if (nil == _imageKit)
    {
        _imageKit = [[LSHTTPImageKit alloc] init];
    }
    [_imageKit addImage:aImageURL delegate:self useCache:aUseCache];
    
    if (nil == _arrMatch)
    {
        _arrMatch = [[NSMutableArray alloc] initWithCapacity:10];
    }
    LSImageMatch* match = [[LSImageMatch alloc] init];
    match.view  = aButton;
    match.imageURL = aImageURL;
    [_arrMatch addObject:match];
    [match release];
}

- (void)addImage:(NSString*)aImageURL useCache:(BOOL)aUseCache
{
    if ([aImageURL length] == 0)
    {
        NSLog(@"%@ addImage failed_2!",NSStringFromClass([self class]));
        //        return;
    }
    
    if (NO == aUseCache)
    {
        [_memoryCache removeObjectForKey:aImageURL];
    }
    else
    {
        UIImage* image = [self imageInMemoryCache:aImageURL];
        if (image)
        {
            image = [self handleImageHook:image];
            [self didImageFinished:_imageKit imageURL:aImageURL image:image];
            NSLog(@"imageURL= %@\n image memeory cache",aImageURL);
            return;
        }
    }
    
    if (nil == _imageKit)
    {
        _imageKit = [[LSHTTPImageKit alloc] init];
    }
    [_imageKit addImage:aImageURL delegate:self useCache:aUseCache];
}

- (UIImage*)handleImageHook:(UIImage*)aSrcImage
{
    return aSrcImage;
}

- (void)addImageToMemoryCache:(UIImage*)aImage urlString:(NSString*)aImageURL
{
    if (nil == _memoryCache)
    {
        _memoryCache = [[NSMutableDictionary alloc] initWithCapacity:20];
    }
    
    NSInteger cacheCount = [[_memoryCache allKeys] count];
    if (cacheCount <= 30)
    {
        [_memoryCache setObject:aImage forKey:aImageURL];
    }
    else
    {
        NSString* key = [[_memoryCache allKeys] objectAtIndex:0];
        [_memoryCache removeObjectForKey:key];
        [_memoryCache setObject:aImage forKey:aImageURL];
    }
}

- (UIImage*)imageInMemoryCache:(NSString*)aImageURL
{
    if ([aImageURL length] == 0)
    {
        return nil;
    }
    
    if (nil == _memoryCache)
    {
        _memoryCache = [[NSMutableDictionary alloc] initWithCapacity:20];
        return nil;
    }
    else
    {
        UIImage* image = [_memoryCache valueForKey:aImageURL];
        return image;
    }
}
#pragma mark LSHTTPImageKitDelegate
- (void)didImageFinished:(LSHTTPImageKit*)aKit imageURL:(NSString*)aImageURL image:(UIImage*)aImage
{
    NSAssert(_imageKit == aKit, @"");
    
    for (LSImageMatch* match in _arrMatch)
    {
        if ([match.imageURL isEqualToString:aImageURL])
        {
            if ([match.view isKindOfClass:[UIImageView class]])
            {
                UIImageView* imageView = (UIImageView*)match.view;
                imageView.image = [self handleImageHook:aImage];
            }
            else if ([match.view isKindOfClass:[UIButton class]])
            {
                UIButton* button = (UIButton*)match.view;
                [button setImage:[self handleImageHook:aImage] forState:UIControlStateNormal];
            }
        }
    }
    
    [self addImageToMemoryCache:aImage urlString:aImageURL];
}

- (void)didImageFailed:(LSHTTPImageKit*)aKit imageURL:(NSString*)aImageURL
{
    NSAssert(_imageKit == aKit, @"");
    NSLog(@"%@ get image failed. url= %@",NSStringFromClass([self class]), aImageURL);
}

//////////////////////////////////////////////////////////////
#pragma mark Tap
//////////////////////////////////////////////////////////////

- (void)tapGestureUpdated:(UITapGestureRecognizer *)tapGesture
{
    CGPoint locationTouch = [_tapGesture locationInView:self];
    closeButtonShow = NO;
    closeButton.hidden = YES;
    if (locationTouch.x < 130 && locationTouch.y < 175) {
        [self downButtonClick];
    }
}


//////////////////////////////////////////////////////////////
#pragma mark Sorting gestures & logic
//////////////////////////////////////////////////////////////

- (void)sortingLongPressGestureUpdated:(UILongPressGestureRecognizer *)longPressGesture
{
    switch (longPressGesture.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            
            closeButtonShow = YES;
            closeButton.hidden = NO;
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        {
            
            
            break;
        }
        default:
            break;
    }
}

@end
