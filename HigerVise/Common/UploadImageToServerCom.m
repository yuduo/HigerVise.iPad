//
//  UploadImageToServerCom.m
//  Locoso
//
//  Created by yongchang hu on 12-1-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UploadImageToServerCom.h"

@implementation UploadImageToServerCom

+(NSURLRequest *)postRequestWithURL: (NSURL *)url		// IN
							 
								data: (NSString *)data	  // IN
{
	
	NSMutableURLRequest *urlRequest =
	[NSMutableURLRequest requestWithURL:url];
	[urlRequest setHTTPMethod:@"POST"];
    

    NSMutableData *postData = [NSMutableData dataWithCapacity:[data length] + 512];
    [postData appendData:[[NSString stringWithFormat:@"&subgson=%@", data] dataUsingEncoding:NSUTF8StringEncoding]];

    
	[urlRequest setHTTPBody:postData];
	return urlRequest;
}
//+(NSURLRequest *)postRequestWithURLNew: (NSURL *)url		// IN
//
//                               json: (NSString *)json	  // IN
//                           uploadimage:(UIImage*)uploadimage
//{
////	NSLog(url);
//    NSLog(json);
//	NSMutableURLRequest *urlRequest =
//	[NSMutableURLRequest requestWithURL:url];
//	[urlRequest setHTTPMethod:@"POST"];
//    
//    NSString *boundary = @"0xKhTmLbOuNdArY";
//    NSString*contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
//    [urlRequest addValue:@"utf-8" forHTTPHeaderField: @"Charset"];
//    [urlRequest addValue:@"keep-alive" forHTTPHeaderField: @"connection"];
//    [urlRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
//    
//    int size = 102400;
//    int current_size = 0;
//    int actual_size = 0;
//    
//    NSData *imagedata = UIImageJPEGRepresentation(uploadimage, 1.0);
//    current_size = [imagedata length];
//    if (current_size > size) {
//        actual_size = size/current_size;
//        imagedata = UIImageJPEGRepresentation(uploadimage, actual_size);
//    }
////    NSMutableData*postbody = [NSMutableData imagedata];
//    NSMutableData *postbody = [NSMutableData dataWithCapacity:[imagedata length] + 512];
//    
//    NSMutableString*str=[[NSMutableString alloc] init];
//    NSMutableString*str1=[[NSMutableString alloc] init];
//    //第一个字段
//    [str appendFormat:@"\r\n\r\n--%@\r\n" ,boundary];
//    [str appendFormat: @"Content-Disposition:form-data; name=\"image\"; filename=\"%@\"\r\n\r\n",@"test"];
//
//    //第二个字段
//
//    [str appendFormat: @"Content-Type: application/octet-stream; charset=utf-8 \r\n\r\n"];
//
//    [postbody appendData:[str dataUsingEncoding:NSUTF8StringEncoding]];
//    [postbody appendData:imagedata];
//    
//    //第三个字段
//    [str1 appendFormat: @"\r\n--%@\r\n",boundary];
//    [str1 appendFormat: @"Content-Disposition: form-data; name=\"subgson\"\r\n\r\n%@",json];
//
//    //第四个字段
//    [str1 appendFormat: @"\r\n--%@--\r\n\r\n",boundary];
//    
//
//    [postbody appendData:[str1 dataUsingEncoding:NSUTF8StringEncoding]];
//    [urlRequest setHTTPBody:postbody];
//    [str release];
//    [str1 release];
//	return urlRequest;
//}
+(NSURLRequest *)postRequestWithURLNew: (NSURL *)url		// IN

                                  json: (NSString *)json	  // IN
                           uploadimage:(UIImage*)uploadimage
{
    //	NSLog(url);

	NSMutableURLRequest *urlRequest =
	[NSMutableURLRequest requestWithURL:url];
	[urlRequest setHTTPMethod:@"POST"];
    
    NSString *boundary = @"0xKhTmLbOuNdArY";
    NSString*contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [urlRequest addValue:@"utf-8" forHTTPHeaderField: @"Charset"];
    [urlRequest addValue:@"keep-alive" forHTTPHeaderField: @"connection"];
    [urlRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    int size = 102400;
    int current_size = 0;
    int actual_size = 0;
    
    NSData *imagedata = UIImageJPEGRepresentation(uploadimage, 1.0);
    current_size = [imagedata length];
    if (current_size > size) {
        actual_size = size/current_size;
        imagedata = UIImageJPEGRepresentation(uploadimage, actual_size);
    }
    //    NSMutableData*postbody = [NSMutableData imagedata];
    NSMutableData *postbody = [NSMutableData dataWithCapacity:[imagedata length] + 512];
    
    NSMutableString*str=[[NSMutableString alloc] init];
    NSMutableString*str1=[[NSMutableString alloc] init];
    //第一个字段
    [str appendFormat:@"--%@\r\n" ,boundary];
    [str appendFormat: @"Content-Disposition:form-data; name=\"image\"; filename=\"%@\"\r\n",@"1111.jpg"];
    
    //第二个字段
    
    [str appendFormat: @"Content-Type: application/octet-stream; charset=utf-8 \r\n\r\n"];
    
    [postbody appendData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:imagedata];
    
    //第三个字段
    [str1 appendFormat: @"\r\n--%@\r\n",boundary];
    [str1 appendFormat: @"Content-Disposition: form-data; name=\"subgson\"\r\n\r\n%@",json];
    
    //第四个字段
    [str1 appendFormat: @"\r\n--%@--\r\n\r\n",boundary];
    
    
    [postbody appendData:[str1 dataUsingEncoding:NSUTF8StringEncoding]];
    [urlRequest setHTTPBody:postbody];
    [str release];
    [str1 release];
	return urlRequest;
}
@end
