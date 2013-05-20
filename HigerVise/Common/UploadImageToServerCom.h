//
//  UploadImageToServerCom.h
//  Locoso
//
//  Created by yongchang hu on 12-1-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadImageToServerCom : NSObject
+(NSURLRequest *)postRequestWithURL: (NSURL *)url		// IN
                            
                               data: (NSString *)data;
+(NSURLRequest *)postRequestWithURLNew: (NSURL *)url		// IN

                                  json: (NSString *)json	  // IN
                           uploadimage:(UIImage*)uploadimage;
@end
