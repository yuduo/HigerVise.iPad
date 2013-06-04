//
//  MyBookView.m
//
//  Created by pubo on 11-5-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ResourceView.h"
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

#define RESOURCE_TITLE_SIZE 28
#define RESOURCE_DETAIL_SIZE  18
#define RESOURCE_CATEGORY_FONT_SIZE  18


#define RESOURCE_TITLE_COLOR LSRGBA(51,51,51,1)
#define RESOURCE_DETAIL_COLOR  LSRGBA(102,102,102,1)
#define RESOURCE_CATEGORY_FONT_COLOR  LSRGBA(93,50,18,1)


#define DOWN_BUTTON_SIZE_X 68
#define DOWN_BUTTON_SIZE_Y 26
@implementation ResourceView

@synthesize delegate;
@synthesize bookID,downState;
@synthesize bookName,bookType;
@synthesize contentLength;
@synthesize bookPath,picturePath;

@synthesize downButton,addButton;

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
		
        //picture
        // 展示图片
        UIImageView *bookView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -30, 102, 136)];
        
        [self addImage:bookView imageURL:picturePath];
        
        [self addSubview:bookView];
        
		//系统进度条的设置
		zztjProView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 100, 102, 20)];
		//自己的进度条设置,默认宽度为0
        zztjProView.hidden = YES;
		imageProView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 121, 0, 4)];
		[imageProView setImage:[UIImage imageNamed:@"proImage.png"]];
		//自己进度条的背景
//		imageProBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 102, 130, 6)];
		//[imageProBgView setImage:[UIImage imageNamed:@"proImage_bg.png"]];
		imageProBgView.backgroundColor = [UIColor blackColor];
        
        int lable_x = 115;
        int lable_y = -30;
		//初始化显示书名的Lable
		bookNameText = [[UILabel alloc] initWithFrame:CGRectMake(lable_x, lable_y, 200, 30)];
        bookNameText.backgroundColor = [UIColor clearColor];
		bookNameText.text = @"";
        bookNameText.font = [UIFont fontWithName:RESOURCE_TEXT_FONT size:RESOURCE_TITLE_SIZE];
        bookNameText.textColor = RESOURCE_TITLE_COLOR;
        
        //初始化显示书名的Lable
		sizeText = [[UILabel alloc] initWithFrame:CGRectMake(lable_x, lable_y+28, 100, 30)];
        sizeText.backgroundColor = [UIColor clearColor];
		sizeText.text = @"";
        bookNameText.font = [UIFont fontWithName:RESOURCE_TEXT_FONT size:RESOURCE_DETAIL_SIZE];
        sizeText.textColor = RESOURCE_DETAIL_COLOR;
        
        //初始化显示书名的Lable
		detailText = [[UILabel alloc] initWithFrame:CGRectMake(lable_x+100, lable_y+28, 100, 30)];
        detailText.backgroundColor = [UIColor clearColor];
		detailText.text = @"";
        bookNameText.font = [UIFont fontWithName:RESOURCE_TEXT_FONT size:RESOURCE_DETAIL_SIZE];
        detailText.textColor = RESOURCE_DETAIL_COLOR;
        
        //初始化显示书名的Lable
		dateText = [[UILabel alloc] initWithFrame:CGRectMake(lable_x, lable_y+56, 100, 30)];
        dateText.backgroundColor = [UIColor clearColor];
		dateText.text = @"";
        bookNameText.font = [UIFont fontWithName:RESOURCE_TEXT_FONT size:RESOURCE_DETAIL_SIZE];
        dateText.textColor = RESOURCE_DETAIL_COLOR;
        
        
		//初始化下载按键
		self.downButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		downButton.frame = CGRectMake(lable_x, 60, DOWN_BUTTON_SIZE_X, DOWN_BUTTON_SIZE_Y);
		[downButton setTitle:@"未下载" forState:UIControlStateNormal];
		[downButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[downButton addTarget:self action:@selector(downButtonClick) forControlEvents:UIControlEventTouchDown];
		
        [self addSubview:zztjProView];
		[self addSubview:imageProBgView];
		[self addSubview:imageProView];
		[self addSubview:bookNameText];
        [self addSubview:sizeText];
        [self addSubview:detailText];
        [self addSubview:dateText];
		[self addSubview:downButton];
        

        //add button
        self.addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		addButton.frame = CGRectMake(lable_x+150, 80, 50, 30);
//		[addButton setTitle:@"add" forState:UIControlStateNormal];
		[addButton setBackgroundImage:[UIImage imageNamed:@"add_button.png"] forState:UIControlStateNormal];
		[addButton addTarget:self action:@selector(markButtonClick) forControlEvents:UIControlEventTouchDown];
        [self addSubview:addButton];
        
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureUpdated:)];
        _tapGesture.delegate = self;
        _tapGesture.numberOfTapsRequired = 1;
        _tapGesture.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:_tapGesture];
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
		
//		//下载按键启用
		downButton.enabled = YES;
//		//下载按键隐藏
//		downButton.hidden = YES;
		self.downState = DOWNLOAD_STATE_FINISHED;
        [downButton setTitle:@"已下载" forState:UIControlStateNormal];
		[downButton setBackgroundImage:[UIImage imageNamed:@"button_finish.png"] forState:UIControlStateNormal];
		//系统进度条隐藏
		zztjProView.hidden = YES;
		//自己的进度条隐藏
		imageProView.hidden = YES;
		//自己的进度条背景隐藏
		imageProBgView.hidden = YES;
		
		
	}else {
		
		[downButton setBackgroundImage:[UIImage imageNamed:@"button_wait.png"] forState:UIControlStateNormal];
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
        //		downButton.enabled = NO;
		
		//调用 DownAndASIRequestViewController 的 downBtnOfBookWasClicked 方法
		[delegate downBtnOfBookWasClicked:self];
	}
}
-(void)markButtonClick
{
    addButton.hidden = YES;
    if ([delegate respondsToSelector:@selector(markBtnOfBookWasClicked:)]) {
        
        //调用 DownAndASIRequestViewController 的 readBtnOfBookWasClicked 方法
        [delegate markBtnOfBookWasClicked:self];
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
            [downButton setTitle:@"下载中" forState:UIControlStateNormal];
            [downButton setBackgroundImage:[UIImage imageNamed:@"button_down.png"] forState:UIControlStateNormal];
            [self startDownload];
            break;
        case DOWNLOAD_STATE_DOWNING:
            downState = DOWNLOAD_STATE_STOP;//stop
            [downButton setTitle:@"暂停" forState:UIControlStateNormal];
            [downButton setBackgroundImage:[UIImage imageNamed:@"button_down.png"] forState:UIControlStateNormal];
            [self pauseButtonClick];
            break;
        case DOWNLOAD_STATE_STOP:
            downState = DOWNLOAD_STATE_DOWNING;
            [downButton setTitle:@"下载中" forState:UIControlStateNormal];
            [downButton setBackgroundImage:[UIImage imageNamed:@"button_down.png"] forState:UIControlStateNormal];
            [self startDownload];
            break;
        default:
            break;
    }
}
- (void)pauseButtonClick {//暂停按键事件
	
	if ([delegate respondsToSelector:@selector(pauseBtnOfBookWasClicked:)]) {
		//下载按键启用
//		downButton.enabled = YES;
		
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
			//因为文件小,解压太快,为了更好的看到效果,故添加了一个3秒之后执行的取消"菊花"操作.
			
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
    zztjProView.hidden = NO;
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

-(void)setButtonState:(BOOL)addButtonState isMarked:(BOOL)isMarked
{
    if (addButtonState) {
        addButton.hidden = NO;
        if (isMarked) {
            [addButton setEnabled:NO];
            [addButton setBackgroundImage:[UIImage imageNamed:@"added.png"] forState:UIControlStateNormal];
        }else
        {
            [addButton setEnabled:YES];
            [addButton setBackgroundImage:[UIImage imageNamed:@"add_button.png"] forState:UIControlStateNormal];
        }
    }else
    {
        addButton.hidden = YES;
    }
    
}

//////////////////////////////////////////////////////////////
#pragma mark Tap
//////////////////////////////////////////////////////////////

- (void)tapGestureUpdated:(UITapGestureRecognizer *)tapGesture
{
    CGPoint locationTouch = [_tapGesture locationInView:self];
    
    if (locationTouch.x < 102 && locationTouch.y < 136) {
        [self downButtonClick];
    }
}
@end
