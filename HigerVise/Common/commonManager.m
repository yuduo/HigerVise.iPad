//
//  commonManager.m
//  Locoso
//
//  Created by yongchang hu on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import <CommonCrypto/CommonDigest.h>
#import "commonManager.h"
#import "CheckNetwork.h"
#import "MyDataSource.h"
#import "SBJsonWriter.h"

@implementation commonManager
@synthesize data;
+(NSString*)getTestAccount
{
    NSString *subgson = [NSString stringWithFormat: @"{\"uaid\":%d,\"session\":\"%@\"}",[[[NSUserDefaults standardUserDefaults] stringForKey:@"uaid"] intValue], [[NSUserDefaults standardUserDefaults] stringForKey:@"session"]];
    return subgson;
}

+(NSString*)getJsonStrFromDic:(NSDictionary*)dic
{
    //NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"data", @"2", @"contentType", @"3", @"fileName", @"4", @"key", nil];
    
    SBJsonWriter *jsonWriter = [[SBJsonWriter alloc] init];
    
    NSString *jsonString = [jsonWriter stringWithObject:dic]; 
    
    
    [jsonWriter release];
    return jsonString;
}
+(NSString*)getDataSession
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults stringForKey:@"session"];
    
}
+(NSString*)getLoginOutStr:(NSString*)path
{
    NSString *subgson = [NSString stringWithFormat: @"{\"account\":{\"session\":%@},\"model\":\"\",\"verify\":{\"time\":\"2012-01-10\",\"permit\":\"verify\"}}",[self getDataSession]];
    return [path stringByAppendingString:subgson];
}
+(NSString*)ManageAddDelete:(NSString*)path json:(NSDictionary*)modelDic
{
    NSString *hostStr  = [path stringByAppendingString:@"&subgson="];
    NSString *modeStr = @"";
    if (modelDic != nil){
        modeStr = [self getJsonStrFromDic:modelDic];
    }
//    
//    NSString *verifystr = @"{\"permit\":\"123\",\"time\":\"Fri Jan 13 05:35:14 GMT+00:00 2012\"}";
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys: modeStr, @"model", [self getVerifyDic:@"123"], @"verify",[self getAccountDic], @"account", nil];
    
    NSString *dicStr = [self getJsonStrFromDic:dic];
    NSLog(@"加密前=%@",dicStr);
    

    
    NSString *dicStrmd5 = [self md5:dicStr];
    NSLog(@"加密后=%@",dicStrmd5);
    
    NSDictionary *dicmd5 = 
    [NSDictionary dictionaryWithObjectsAndKeys:modeStr, @"model", [self getVerifyDic:dicStrmd5], @"verify", [self getAccountDic], @"account", nil];
    
    NSString *complStrmd5 = [self getJsonStrFromDic:dicmd5];
    
    
    hostStr = [hostStr stringByAppendingString:complStrmd5];
    NSLog(@"提交=%@",hostStr);
    
    return hostStr;
}
+(NSString*)ManageUploadImageData:(NSString*)path json:(NSData*)modelData
{
    NSString *hostStr  = [path stringByAppendingString:@"&subgson="];
    
//    NSString *accountstr = [self getTestAccount];
    //    
//    NSString *modeStr = [self getJsonStrFromDic:modelDic];
    //    
    //    NSString *verifystr = @"{\"permit\":\"123\",\"time\":\"Fri Jan 13 05:35:14 GMT+00:00 2012\"}";
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys: modelData, @"model", [self getVerifyDic:@"123"], @"verify",[self getAccountDic], @"account", nil];
    
    NSString *dicStr = [self getJsonStrFromDic:dic];
//    NSLog(@"加密前=%@",dicStr);
    
    
    
    NSString *dicStrmd5 = [self md5:dicStr];
//    NSLog(@"加密后=%@",dicStrmd5);
    
    NSDictionary *dicmd5 = 
    [NSDictionary dictionaryWithObjectsAndKeys:modelData, @"model", [self getVerifyDic:dicStrmd5], @"verify", [self getAccountDic], @"account", nil];
    
    NSString *complStrmd5 = [self getJsonStrFromDic:dicmd5];
    
    
    hostStr = [hostStr stringByAppendingString:complStrmd5];
//    NSLog(@"提交=%@",hostStr);
    
    return hostStr;
}
+(NSString*)ManageUploadPicture:(NSString*)path json:(NSString*)modeStr
{
    NSString *hostStr  = [path stringByAppendingString:@"&subgson="];
    
//    NSString *accountstr = [self getTestAccount];
    //    
//    NSString *modeStr = [self getJsonStrFromDic:modelDic];
    //    
    //    NSString *verifystr = @"{\"permit\":\"123\",\"time\":\"Fri Jan 13 05:35:14 GMT+00:00 2012\"}";
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys: modeStr, @"model", [self getVerifyDic:@"123"], @"verify",[self getAccountDic], @"account", nil];
    
    NSString *dicStr = [self getJsonStrFromDic:dic];
//    NSLog(@"加密前=%@",dicStr);
    
    
    
    NSString *dicStrmd5 = [self md5:dicStr];
//    NSLog(@"加密后=%@",dicStrmd5);
    
    NSDictionary *dicmd5 = 
    [NSDictionary dictionaryWithObjectsAndKeys:modeStr, @"model", [self getVerifyDic:dicStrmd5], @"verify", [self getAccountDic], @"account", nil];
    
    NSString *complStrmd5 = [self getJsonStrFromDic:dicmd5];
    
    
    hostStr = [hostStr stringByAppendingString:complStrmd5];
    NSLog(@"提交=%@",hostStr);
    
    return complStrmd5;
}
+(NSString*)ManageUploadPictureNew
{

    
//    NSString *accountstr = [self getTestAccount];
    //    
    //    NSString *modeStr = [self getJsonStrFromDic:modelDic];
    //    
    //    NSString *verifystr = @"{\"permit\":\"123\",\"time\":\"Fri Jan 13 05:35:14 GMT+00:00 2012\"}";
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys: @"", @"model", [self getVerifyDic:@"123"], @"verify",[self getAccountDic], @"account", nil];
    
    NSString *dicStr = [self getJsonStrFromDic:dic];
    //    NSLog(@"加密前=%@",dicStr);
    
    
    
    NSString *dicStrmd5 = [self md5:dicStr];
    //    NSLog(@"加密后=%@",dicStrmd5);
    
    NSDictionary *dicmd5 = 
    [NSDictionary dictionaryWithObjectsAndKeys:@"", @"model", [self getVerifyDic:dicStrmd5], @"verify", [self getAccountDic], @"account", nil];
    
    NSString *complStrmd5 = [self getJsonStrFromDic:dicmd5];
    
    

    return complStrmd5;
}

+(NSString*)getAccountStr
{
    NSString *subgson = [NSString stringWithFormat: @"{\"uaid\":%@,\"session\":\"%@\"}",[[NSUserDefaults standardUserDefaults] stringForKey:@"uaid"], [[NSUserDefaults standardUserDefaults] stringForKey:@"session"]];
    return subgson;
}
+(NSDictionary*)getAccountDic
{
    NSString *struaid = [[NSUserDefaults standardUserDefaults] stringForKey:@"uaid"];
    NSInteger ii = [struaid intValue];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:ii], @"uaid", [[NSUserDefaults standardUserDefaults] stringForKey:@"session"], @"session", nil];
    return dic;
}

+(NSDictionary*)getVerifyDic:(NSString*)strmd5
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:strmd5, @"permit",@"2012" , @"time", nil];
    return dic;
}
+ (NSString*)md5HexDigest:(NSString*)input {
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

+(NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
+(NSString*)getCurrentTime
{
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"YYYYMMddhhmmss"];
    NSString *locationString=[formatter stringFromDate: [NSDate date]];
    return locationString;
}

+(NSString*)getFormHead:(NSString*)spermit
{
    NSString *ac = [commonManager getAccountStr];
    NSString *sTime = [commonManager getCurrentTime];
    NSString *sverify = [NSString stringWithFormat: @"{\"permit\":\"%@\",\"time\":\"%@\"}",spermit,sTime];
    NSString *subgson = [NSString stringWithFormat: @"{\"account\":%@,\"model\":\"\",\"verify\":%@}",ac,sverify];
    return subgson;
}
+(NSString*)getFormMD5
{
    NSString *header = [self getFormHead:@"123"];
    NSLog(@"head = %@",header);
    NSString *md5 = [self md5HexDigest:header];
//    NSString *md52 = [self md5:header];
    NSLog(@"old = %@",md5);
//    NSLog(@"new = %@",md52);
    NSLog(@"md5 - %@",[self getFormHead:md5]);
    return [self getFormHead:md5];
}
+(NSString*)getHostStr
{
    
//   NSString *host = @"http://api.locoso.net/v1";
//    NSString *host = @"http://apidev.locoso.org/v1";
    NSString *host = @"http://api.locoso.org/v1";
//    NSString *host = @"http://10.99.1.17:8080/locoso_api";
    return host;
}
+(NSString*)getLogionAccount:(NSString*)username password:(NSString*)passwrod
{
    NSString *subgson = [NSString stringWithFormat: @"{\"loginname\":%@,\"password\":\"%@\",\"uaid\":%d}",username, passwrod,0];
    return subgson;
}
+(NSDictionary*)getLogionDic:(NSString*)username password:(NSString*)passwrod
{

    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:username, @"loginname", passwrod, @"password", nil];
    return dic;
}
+(NSString*)ManageLogion:(NSString*)path username:(NSString*)username password:(NSString*)passwrod 
{
    NSString *hostStr  = [path stringByAppendingString:@"&subgson="];
    
    
    //    
    NSString *modeStr = @"";
    //    
    //    NSString *verifystr = @"{\"permit\":\"123\",\"time\":\"Fri Jan 13 05:35:14 GMT+00:00 2012\"}";
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys: modeStr, @"model", [self getVerifyDic:@"123"], @"verify",[self getLogionDic:username password:passwrod], @"account", nil];
    
    NSString *dicStr = [self getJsonStrFromDic:dic];
    NSLog(@"加密前=%@",dicStr);
    
    
    
    NSString *dicStrmd5 = [self md5:dicStr];
    NSLog(@"加密后=%@",dicStrmd5);
    
    NSDictionary *dicmd5 = 
    [NSDictionary dictionaryWithObjectsAndKeys:modeStr, @"model", [self getVerifyDic:dicStrmd5], @"verify", [self getLogionDic:username password:passwrod], @"account", nil];
    
    NSString *complStrmd5 = [self getJsonStrFromDic:dicmd5];
    
    
    hostStr = [hostStr stringByAppendingString:complStrmd5];
    NSLog(@"提交=%@",hostStr);
    
    return hostStr;
}

+(BOOL)whetherLoginIn
{
    
    return [[[NSUserDefaults standardUserDefaults] stringForKey:@"whetherLoginIn"] boolValue];
}
@end
