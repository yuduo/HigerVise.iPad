//
//  LSImagesViewController.h
//  Test1
//
//  Created by yongchang hu on 12-3-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSBaseViewController.h"
#import "LSHTTPImageKit.h"
#import "LSImageMatch.h"
#define LSImageMemoryCacheMaxCount 30

@interface LSImagesViewController : LSBaseViewController
<LSHTTPImageKitDelegate>
{
    LSHTTPImageKit* _imageKit;
    NSMutableArray* _arrMatch;
    NSMutableDictionary* _memoryCache;
}
@property (nonatomic, retain) LSHTTPImageKit* imageKit;

- (void)addImage:(UIImageView*)aImageView imageURL:(NSString*)aImageURL;//use cache
- (void)addImage:(UIImageView*)aImageView imageURL:(NSString*)aImageURL useCache:(BOOL)aUseCache;

- (void)addImageForButton:(UIButton*)aButton imageURL:(NSString*)aImageURL;//use cache
- (void)addImageForButton:(UIButton*)aButton imageURL:(NSString*)aImageURL useCache:(BOOL)aUseCache;

- (void)addImage:(NSString*)aImageURL useCache:(BOOL)aUseCache;
- (UIImage*)handleImageHook:(UIImage*)aSrcImage;//图片返回后，在显示前提供一次处理的机会.默认返回原图.
@end
