//
//  ConfigInfo.m
//  HigerVise
//
//  Created by Kevin.Mao on 12-10-12.
//  Copyright (c) 2012年 JijeSoft. All rights reserved.
//

#import "ConfigInfo.h"

@implementation ConfigInfo

+ (void)initialize
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *documentsPath = [paths objectAtIndex:0]; 
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:kAppConfigPlist];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) 
    { 
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
        
        [dictionary setObject:[BaseInfo encrypt:[NSString stringWithFormat:@"%d", kAppStatusInit]] 
                       forKey:[BaseInfo encrypt:kAppStatus]];
        [dictionary setObject:[BaseInfo encrypt:@""] 
                       forKey:[BaseInfo encrypt:kAppTimeOut]];
        [dictionary setObject:[BaseInfo encrypt:kAppVersionInit] 
                       forKey:[BaseInfo encrypt:kAppVersion]];
        [dictionary setObject:[BaseInfo encrypt:kAppLastUpdateInit] 
                       forKey:[BaseInfo encrypt:kAppLastUpdate]];
        [dictionary setObject:[BaseInfo encrypt:kAppUserDataInit] 
                       forKey:[BaseInfo encrypt:kAppUserData]];
        [dictionary setObject:[BaseInfo encrypt:@""] 
                       forKey:[BaseInfo encrypt:kAppLastLoginUserName]];
        
        [dictionary setObject:[BaseInfo encrypt:[NSString stringWithFormat:@"%d", kiPadStatusNormal]] 
                       forKey:[BaseInfo encrypt:kiPadStatus]];
        [dictionary setObject:[BaseInfo encrypt:[UIDevice currentDevice].name] 
                       forKey:[BaseInfo encrypt:kiPadName]];
        [dictionary setObject:[BaseInfo encrypt:[self getMacAddress]] 
                       forKey:[BaseInfo encrypt:kiPadMacAddress]];
        [dictionary setObject:[BaseInfo encrypt:[self getUUID]] 
                       forKey:[BaseInfo encrypt:kiPadUUID]];
        [dictionary setObject:[BaseInfo encrypt:@""] 
                       forKey:[BaseInfo encrypt:kiPadDeviceToken]];
        [dictionary setObject:[BaseInfo encrypt:kiPadDefaultUserName]
                       forKey:[BaseInfo encrypt:kiPadUserName]];
        [dictionary setObject:[BaseInfo encrypt:kiPadDefaultPassword]
                       forKey:[BaseInfo encrypt:kiPadPassword]];
        
        [dictionary setObject:[BaseInfo encrypt:[NSString stringWithFormat:@"%d", kServerDefaultFailureMinutes]] 
                       forKey:[BaseInfo encrypt:kServerFailureMinutes]];
        [dictionary setObject:[BaseInfo encrypt:[NSString stringWithFormat:@"%d", kServerDefaultErrorNumber]] 
                       forKey:[BaseInfo encrypt:kServerErrorNumber]];
        [dictionary setObject:[BaseInfo encrypt:[NSString stringWithFormat:@"%d", kServerDefaultLockMinutes]] 
                       forKey:[BaseInfo encrypt:kServerLockMinutes]];
        [dictionary setObject:[BaseInfo encrypt:[NSString stringWithFormat:@"%d", kServerDefaultVersion]] 
                       forKey:[BaseInfo encrypt:kServerVersion]];
        
        [dictionary setObject:[BaseInfo encrypt:@"1"]
                       forKey:[BaseInfo encrypt:kShowPriceEditBtn]];
        
        [dictionary setObject:[BaseInfo encrypt:@"1"] 
                       forKey:[BaseInfo encrypt:kShowIndexEdition]];
        [dictionary setObject:[BaseInfo encrypt:@"1"] 
                       forKey:[BaseInfo encrypt:kShowPriceEdition]];
        
        [dictionary setObject:[BaseInfo encrypt:@"1"] 
                       forKey:[BaseInfo encrypt:kShowEditionOriginal]];
        [dictionary setObject:[BaseInfo encrypt:@"1"] 
                       forKey:[BaseInfo encrypt:kShowEditionOriginalEdit]];
        
        [dictionary setObject:[BaseInfo encrypt:@"1"] 
                       forKey:[BaseInfo encrypt:kShowEditionSale]];
        [dictionary setObject:[BaseInfo encrypt:@"1"] 
                       forKey:[BaseInfo encrypt:kShowEditionSaleEdit]];
        
        [dictionary setObject:[BaseInfo encrypt:@"1"] 
                       forKey:[BaseInfo encrypt:kShowEditionDel]];
        [dictionary setObject:[BaseInfo encrypt:@"1"] 
                       forKey:[BaseInfo encrypt:kShowEditionDelEdit]];
        
        [dictionary setObject:[BaseInfo encrypt:@"1"] 
                       forKey:[BaseInfo encrypt:kShowEditionCustomer]];
        [dictionary setObject:[BaseInfo encrypt:@"1"] 
                       forKey:[BaseInfo encrypt:kShowEditionCustomerEdit]];
        
        [dictionary setObject:[BaseInfo encrypt:@"1"] 
                       forKey:[BaseInfo encrypt:kShowOptional]];
        [dictionary setObject:[BaseInfo encrypt:@"1"] 
                       forKey:[BaseInfo encrypt:kShowOptionalEdit]];
        
        [dictionary setObject:[BaseInfo encrypt:@"1"] 
                       forKey:[BaseInfo encrypt:kShowSettingOptional]];
        [dictionary setObject:[BaseInfo encrypt:@"1"] 
                       forKey:[BaseInfo encrypt:kShowSettingOptionalEdit]];
        
        [dictionary setObject:[BaseInfo encrypt:@"1"] 
                       forKey:[BaseInfo encrypt:kShowSettingStandard]];
        [dictionary setObject:[BaseInfo encrypt:@"1"] 
                       forKey:[BaseInfo encrypt:kShowSettingStandardEdit]];
        
        [dictionary setObject:[BaseInfo encrypt:@"1"] 
                       forKey:[BaseInfo encrypt:kHelpIndex]];
        [dictionary setObject:[BaseInfo encrypt:@"1"] 
                       forKey:[BaseInfo encrypt:kHelpSearch]];
        [dictionary setObject:[BaseInfo encrypt:@"1"] 
                       forKey:[BaseInfo encrypt:kHelpPriceTable]];
        [dictionary setObject:[BaseInfo encrypt:@"1"] 
                       forKey:[BaseInfo encrypt:kHelpCarColor]];
        
        [dictionary writeToFile:plistPath atomically:YES];
    }
    else {
        //[self setConfigValue:@"1" key:kHelpIndex];
        //[self setConfigValue:@"1" key:kHelpSearch];
        //[self setConfigValue:@"1" key:kHelpPriceTable];
        //[self setConfigValue:@"1" key:kHelpCarColor];
    }
}

#pragma mark - public app

+ (NSInteger)AppStatus
{
    NSString *value = [self getConfigValue:kAppStatus];
    if (value) {
        return [value intValue];
    }
    else {
        return kAppStatusInit;
    }
}

+ (NSDate *)AppTimeOut
{
    NSString *value = [self getConfigValue:kAppTimeOut];
    if (value) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date  = [dateFormatter dateFromString:value];
        return date;
    }
    else {
        return nil;
    }
}

+ (NSString *)AppVersion
{
    NSString *value = [self getConfigValue:kAppVersion];
    if (value) {
        return value;
    }
    else {
        return kAppVersionInit;
    }
}

+ (BOOL)AppHasLastUpdate
{
    BOOL rtn = YES;
    NSString *dateString = [self getConfigValue:kAppLastUpdate];
    if (dateString) {
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *dateNow = [NSDate date];
        NSString *dateStringNow = [formatter stringFromDate:dateNow];
        if ([dateString isEqualToString:dateStringNow]) {
            rtn = NO;
        }
    }
    if (rtn) {
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *dateNow = [NSDate date];
        NSString *dateStringNow = [formatter stringFromDate:dateNow];
        [self setConfigValue:dateStringNow key:kAppLastUpdate];
    }
    return rtn;
}

+ (BOOL)AppHasUserData
{
    NSString *value = [self getConfigValue:kAppUserData];
    if (value) {
        return [value boolValue];
    }
    else {
        return [kAppUserDataInit boolValue];
    }
}

+ (NSString *)AppLastLoginUserName
{
    NSString *value = [self getConfigValue:kAppLastLoginUserName];
    if (value) {
        return value;
    }
    else {
        return @"";
    }
}

#pragma mark - public iPad

+ (NSInteger)iPadStatus
{
    NSString *value = [self getConfigValue:kiPadStatus];
    if ((value != nil) && (![value isEqualToString:@""])) {
        return [value intValue];
    }
    else {
        return kiPadStatusNormal;
    }
}

+ (NSString *)iPadName
{
    NSString *value = [self getConfigValue:kiPadName];
    if (value) {
        return value;
    }
    else {
        return @"";
    }
}

+ (NSString *)iPadMacAddress
{
    NSString *value = [self getConfigValue:kiPadMacAddress];
    if (value) {
        return value;
    }
    else {
        return @"";
    }
}

+ (NSString *)iPadUUID
{
    NSString *value = [self getConfigValue:kiPadUUID];
    if (value) {
        return value;
    }
    else {
        return @"";
    }
}

+ (NSString *)iPadDeviceToken
{
    NSString *value = [self getConfigValue:kiPadDeviceToken];
    if (value) {
        return value;
    }
    else {
        return @"";
    }
}

+ (NSString *)iPadUserName
{
    NSString *value = [self getConfigValue:kiPadUserName];
    if (value) {
        return value;
    }
    else {
        return kiPadDefaultUserName;
    }
}

+ (NSString *)iPadPassword
{
    NSString *value = [self getConfigValue:kiPadPassword];
    if (value) {
        return value;
    }
    else {
        return kiPadDefaultPassword;
    }
}

#pragma mark - public server

//密码错误锁定次数
+ (NSInteger)ServerErrorNumber
{
    NSString *value = [self getConfigValue:kServerErrorNumber];
    if (value) {
        return [value intValue];
    }
    else {
        return kServerDefaultErrorNumber;
    }
}

//密码失效时长（分钟）
+ (NSInteger)ServerFailureMinutes
{
    NSString *value = [self getConfigValue:kServerFailureMinutes];
    if (value) {
        return [value intValue];
    }
    else {
        return kServerDefaultFailureMinutes;
    }
}

//系统锁定时长（分钟）
+ (NSInteger)ServerLockMinutes
{
    NSString *value = [self getConfigValue:kServerLockMinutes];
    if (value) {
        return [value intValue];
    }
    else {
        return kServerDefaultLockMinutes;
    }
}

//系统登录密钥
+ (NSString *)ServerLoginKey
{
    return kServerDefaultLoginKey;
}

//服务器端最新数据版本
+ (NSInteger)ServerVersion
{
    NSString *value = [self getConfigValue:kServerVersion];
    if (value) {
        return [value intValue];
    }
    else {
        return kServerDefaultVersion;
    }
}

#pragma mark - public show

+ (BOOL)ShowPriceEditBtn
{
    NSString *value = [self getConfigValue:kShowPriceEditBtn];
    if (value) {
        return [value boolValue];
    }
    else {
        return YES;
    }
}

+ (BOOL)ShowIndexEdition
{
    NSString *value = [self getConfigValue:kShowIndexEdition];
    if (value) {
        return [value boolValue];
    }
    else {
        return YES;
    }
}
+ (BOOL)ShowPriceEdition
{
    NSString *value = [self getConfigValue:kShowPriceEdition];
    if (value) {
        return [value boolValue];
    }
    else {
        return YES;
    }
}

+ (BOOL)ShowEditionSale
{
    NSString *value = [self getConfigValue:kShowEditionSale];
    if (value) {
        return [value boolValue];
    }
    else {
        return YES;
    }
}
+ (BOOL)ShowEditionSaleEdit
{
    NSString *value = [self getConfigValue:kShowEditionSaleEdit];
    if (value) {
        return [value boolValue];
    }
    else {
        return YES;
    }
}

+ (BOOL)ShowEditionDel
{
    NSString *value = [self getConfigValue:kShowEditionDel];
    if (value) {
        return [value boolValue];
    }
    else {
        return YES;
    }
}
+ (BOOL)ShowEditionDelEdit
{
    NSString *value = [self getConfigValue:kShowEditionDelEdit];
    if (value) {
        return [value boolValue];
    }
    else {
        return YES;
    }
}

+ (BOOL)ShowEditionCustomer
{
    NSString *value = [self getConfigValue:kShowEditionCustomer];
    if (value) {
        return [value boolValue];
    }
    else {
        return YES;
    }
}
+ (BOOL)ShowEditionCustomerEdit
{
    NSString *value = [self getConfigValue:kShowEditionCustomerEdit];
    if (value) {
        return [value boolValue];
    }
    else {
        return YES;
    }
}

+ (BOOL)ShowEditionOriginal
{
    NSString *value = [self getConfigValue:kShowEditionOriginal];
    if (value) {
        return [value boolValue];
    }
    else {
        return YES;
    }
}
+ (BOOL)ShowEditionOriginalEdit
{
    NSString *value = [self getConfigValue:kShowEditionOriginalEdit];
    if (value) {
        return [value boolValue];
    }
    else {
        return YES;
    }
}

+ (BOOL)ShowOptional
{
    NSString *value = [self getConfigValue:kShowOptional];
    if (value) {
        return [value boolValue];
    }
    else {
        return YES;
    }
}
+ (BOOL)ShowOptionalEdit
{
    NSString *value = [self getConfigValue:kShowOptionalEdit];
    if (value) {
        return [value boolValue];
    }
    else {
        return YES;
    }
}

+ (BOOL)ShowSettingOptional
{
    NSString *value = [self getConfigValue:kShowSettingOptional];
    if (value) {
        return [value boolValue];
    }
    else {
        return YES;
    }
}
+ (BOOL)ShowSettingOptionalEdit
{
    NSString *value = [self getConfigValue:kShowSettingOptionalEdit];
    if (value) {
        return [value boolValue];
    }
    else {
        return YES;
    }
}

+ (BOOL)ShowSettingStandard
{
    NSString *value = [self getConfigValue:kShowSettingStandard];
    if (value) {
        return [value boolValue];
    }
    else {
        return YES;
    }
}
+ (BOOL)ShowSettingStandardEdit
{
    NSString *value = [self getConfigValue:kShowSettingStandardEdit];
    if (value) {
        return [value boolValue];
    }
    else {
        return YES;
    }
}

#pragma mark - public help

+ (BOOL)HelpIndex
{
    NSString *value = [self getConfigValue:kHelpIndex];
    if (value) {
        return [value boolValue];
    }
    else {
        return NO;
    }
}

+ (BOOL)HelpSearch
{
    NSString *value = [self getConfigValue:kHelpSearch];
    if (value) {
        return [value boolValue];
    }
    else {
        return NO;
    }
}

+ (BOOL)HelpPriceTable
{
    NSString *value = [self getConfigValue:kHelpPriceTable];
    if (value) {
        return [value boolValue];
    }
    else {
        return NO;
    }
}

+ (BOOL)HelpCarColor
{
    NSString *value = [self getConfigValue:kHelpCarColor];
    if (value) {
        return [value boolValue];
    }
    else {
        return NO;
    }
}

#pragma mark - public config

+ (NSString *)getConfigValue:(NSString *)key
{
    NSString *rtn = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; 
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:kAppConfigPlist];   
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    rtn = [dictionary objectForKey:[BaseInfo encrypt:key]];
    if ((rtn == nil) || [rtn isEqualToString:@""]) {
        return nil;
    }
    else {
        rtn = [BaseInfo decrypt:rtn];
        if ((rtn == nil) || [rtn isEqualToString:@""]) {
            return nil;
        }
        else {
            return rtn;
        }
    }
}

+ (BOOL)setConfigValue:(NSString *)value key:(NSString *)key
{
    BOOL rtn = NO;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *documentsPath = [paths objectAtIndex:0]; 
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:kAppConfigPlist];   
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    NSMutableDictionary *dictionaryNew = [dictionary mutableCopy];
    [dictionaryNew setObject:[BaseInfo encrypt:value] forKey:[BaseInfo encrypt:key]];
    rtn = [dictionaryNew writeToFile:plistPath atomically:YES];
    return rtn;
}

#pragma mark - private

+ (NSString *)getMacAddress
{
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        return @"";
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        return @"";
    }
    
    if ((buf = malloc(len)) == NULL) {
        return @"";
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        return @"";
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    //NSString *outstring = [NSString stringWithFormat:@"x:x:x:x:x:x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    //NSString *outstring = [NSString stringWithFormat:@"%x:%x:%x:%x:%x:%x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    NSString *outstring = @"";
    for (int i = 0; i < 6; i++) {
        NSString *str = [NSString stringWithFormat:@"%x", *(ptr + i)];
        if (str.length == 1) {
            str = [NSString stringWithFormat:@"0%@", str];
        }
        if (i == 0) {
            outstring = [NSString stringWithFormat:@"%@", str];
        }
        else {
            outstring = [NSString stringWithFormat:@"%@:%@", outstring, str];
        }
    }
    free(buf);
    return [outstring uppercaseString];
}

+ (NSString *)getUUID 
{  
    NSString *rtn = nil; 
    CFUUIDRef uuid = CFUUIDCreate(nil);
    CFStringRef uuidString = CFUUIDCreateString(nil, uuid);
    rtn = [NSString stringWithFormat:@"%@", uuidString];
    CFRelease(uuidString);
    CFRelease(uuid);
    return rtn;  
}

@end
