//
//  Photo.h
//  REPhotoCollectionControllerExample
//
//  Created by Roman Efimov on 7/27/12.
//  Copyright (c) 2012 Roman Efimov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REPhotoObjectProtocol.h"

@interface Photo : NSObject <REPhotoObjectProtocol>

@property (nonatomic, strong) NSURL *thumbnailURL;
@property (nonatomic, strong) UIImage *thumbnail;
@property (nonatomic, strong) NSDate *date;

- (id)initWithThumbnailURL:(NSURL *)thumbnailURL date:(NSDate *)date;
+ (Photo *)photoWithURLString:(NSString *)urlString date:(NSDate *)date;
/*
 * 缩放图片
 * image 图片对象
 * toWidth 宽
 * toHeight 高
 * return 返回图片对象
 */
+(UIImage *)scaleImage:(UIImage *)image toWidth:(int)toWidth toHeight:(int)toHeight;

/*
 * 缩放图片数据
 * imageData 图片数据
 * toWidth 宽
 * toHeight 高
 * return 返回图片数据对象
 */
+(NSData *)scaleData:(NSData *)imageData toWidth:(int)toWidth toHeight:(int)toHeight;

/*
 * 圆角
 * image 图片对象
 * size 尺寸
 */
+(id) createRoundedRectImage:(UIImage*)image size:(CGSize)size;

/*
 * 图片转换为字符串
 */
+(NSString *) image2String:(UIImage *)image;

/*
 * 字符串转换为图片
 */
+(UIImage *) string2Image:(NSString *)string;
@end
