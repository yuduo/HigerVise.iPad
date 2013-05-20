//
//  commonManager.h
//  Locoso
//
//  Created by yongchang hu on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface commonManager : NSObject{
    NSDictionary * data;
}
@property (nonatomic, retain) NSDictionary * data;
+(NSString*)ManageAddDelete:(NSString*)path json:(NSDictionary*)modelDic;
+(NSString *)md5:(NSString *)str;
+(NSString*)getAccountStr;
+(NSString*)getCurrentTime;
+(NSString*)getFormHead:(NSString*)spermit;
+(NSString*)getFormMD5;
+(NSString*)getHostStr;
+(NSString*)getJsonStrFromDic:(NSDictionary*)dic;
+(NSString*)ManageLogion:(NSString*)path username:(NSString*)username password:(NSString*)passwrod ;
+(NSString*)ManageUploadPicture:(NSString*)path json:(NSString*)modelStr;
+(NSString*)ManageUploadImageData:(NSString*)path json:(NSData*)modelData;
+(NSString*)ManageUploadPictureNew;
+(BOOL)whetherLoginIn;
+(NSString*)getLoginOutStr:(NSString*)path;
+(NSString*)getDataSession;
@end
