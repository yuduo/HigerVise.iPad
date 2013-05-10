//
//  DataService.m
//  HigerVise
//
//  Created by Kevin.Mao on 12-10-12.
//  Copyright (c) 2012年 JijeSoft. All rights reserved.
//

#import "DataService.h"

@implementation DataService

- (void)dealloc
{
    
}

#pragma mark - request public method

- (NSDictionary *)requestLogin:(NSString *)userName userPwd:(NSString *)userPwd
{
    NSString *parameter = [self getLoginParameter:userName userPwd:userPwd];
    return [self request:[BaseInfo UrlLogin] parameter:parameter];
}

- (NSDictionary *)requestInitData:(NSString *)userName useriPadKey:(NSString *)useriPadKey
{
    NSString *parameter = [self getInitDataParameter:userName useriPadKey:useriPadKey];
    return [self request:[BaseInfo UrlInit] parameter:parameter];
}

- (NSDictionary *)requestSystemInfo:(NSString *)userName useriPadKey:(NSString *)useriPadKey
{
    NSString *parameter = [self getSystemInfoParameter:userName useriPadKey:useriPadKey];
    return [self request:[BaseInfo UrlSystemInfo] parameter:parameter];
}

- (NSDictionary *)requestUpdateData:(NSString *)appVersion userName:(NSString *)userName 
                     iPadMacAddress:(NSString *)iPadMacAddress useriPadKey:(NSString *)useriPadKey
{
    NSString *parameter = [self getUpdateDataParameter:appVersion 
                                              userName:userName 
                                        iPadMacAddress:iPadMacAddress
                                           useriPadKey:useriPadKey];
    return [self request:[BaseInfo UrlUpdate] parameter:parameter];
}

- (NSDictionary *)requestImageById:(NSString *)referenceId
{
    NSString *parameter = [self getImageByIdParameter:referenceId];
    return [self request:[BaseInfo UrlImageById] parameter:parameter];
}

- (NSDictionary *)requestUserData
{
    NSString *parameter = [self getUserDataParameter];
    return [self request:[BaseInfo UrlUserData] parameter:parameter];
}

- (NSDictionary *)requestCertificate:(BOOL)isRequest
{
    if (isRequest) {
        NSString *parameter = [self getCertificateParameter];
        return [self request:[BaseInfo UrlCertificate] parameter:parameter];
    }
    else {
        return nil;
    }
}

- (NSDictionary *)requestDialogueClass
{
    return [self request:[BaseInfo UrlGetDialogueClass] parameter:@"{}"];
}

- (NSDictionary *)requestUser
{
    return [self request:[BaseInfo UrlGetUser] parameter:@"{}"];
}

- (NSDictionary *)requestOrganization
{
    NSString *parameter = [self getOrganizationParameter];
    return [self request:[BaseInfo UrlGetOrganization] parameter:parameter];
}

- (NSDictionary *)requestGetDialogue:(int)row
{
    NSString *parameter = [self getDialogueParameter:row];
    return [self request:[BaseInfo UrlGetDialogue] parameter:parameter];
}

- (NSDictionary *)requestDeleteDialogueMaster:(NSString *)web_dialogue_master_ids
{
    NSString *parameter = [self deleteDialogueMasterParameter:web_dialogue_master_ids];
    return [self request:[BaseInfo UrlDeleteDialogueMaster] parameter:parameter];
}

- (NSDictionary *)requestDeleteDialogueDetail:(NSString *)web_dialogue_master_ids
{
    NSString *parameter = [self deleteDialogueDetailParameter:web_dialogue_master_ids];
    return [self request:[BaseInfo UrlDeleteDialogueDetail] parameter:parameter];
}

- (NSDictionary *)requestGetDialogueDetail:(NSString *)client_dialogue_master_id{
    NSString *parameter = [self getDialogueDetailParameter:client_dialogue_master_id];
    return [self request:[BaseInfo UrlGetDialogueDetail] parameter:parameter];
}

- (NSDictionary *)requestCloseDialogue:(NSString *)web_dialogue_master_id and:(NSString *)web_dialogue_result{
    NSString *parameter = [self getCloseDialogueParameter:web_dialogue_master_id and:web_dialogue_result];
    return [self request:[BaseInfo UrlCloseDialogue] parameter:parameter];
}
#pragma mark - upload public method

- (BOOL)uploadSystemLog:(client_system_log *)model
{
    NSString *parameter = [self getSystemLogParameter:model];
    NSDictionary *data = [self request:[BaseInfo UrlUploadSystemLog] parameter:parameter];
    
    if (data) {
        NSInteger code = [[data objectForKey:@"Code"] intValue];
        if (code == 1001) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)uploadVehicleLog:(client_user_vehicle_log *)model
{
    NSString *parameter = [self getVehicleLogParameter:model];
    NSDictionary *data = [self request:[BaseInfo UrlUploadUserVehicleLog] parameter:parameter];
    
    if (data) {
        NSInteger code = [[data objectForKey:@"Code"] intValue];
        if (code == 1001) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - parameter

- (NSString *)getCertificateParameter
{
    NSString *parameter = [NSString stringWithFormat:@""];
    parameter = [parameter stringByAppendingString:@"{"];
    parameter = [parameter stringByAppendingFormat:@"'web_login_key':'%@'", [BaseInfo encrypt:[ConfigInfo ServerLoginKey]]];
    parameter = [parameter stringByAppendingString:@"}"];
    return parameter;
}

- (NSString *)getLoginParameter:(NSString *)userName userPwd:(NSString *)userPwd
{
    NSString *parameter = [NSString stringWithFormat:@""];
    parameter = [parameter stringByAppendingString:@"{"];
    parameter = [parameter stringByAppendingFormat:@"'web_user_name':'%@',", [BaseInfo encrypt:userName]];
    parameter = [parameter stringByAppendingFormat:@"'web_user_password':'%@',", [BaseInfo encrypt:userPwd]];
    parameter = [parameter stringByAppendingFormat:@"'web_login_key':'%@',", [BaseInfo encrypt:[ConfigInfo ServerLoginKey]]];
    parameter = [parameter stringByAppendingFormat:@"'web_ipad_status':'%@',", [BaseInfo encrypt:[NSString stringWithFormat:@"%d",[ConfigInfo iPadStatus]]]];
    parameter = [parameter stringByAppendingFormat:@"'web_ipad_mac_address':'%@',", [BaseInfo encrypt:[ConfigInfo iPadMacAddress]]];
    parameter = [parameter stringByAppendingFormat:@"'web_ipad_name':'%@',", [BaseInfo encrypt:[ConfigInfo iPadName]]];
    parameter = [parameter stringByAppendingFormat:@"'web_ipad_uuid':'%@',", [BaseInfo encrypt:[ConfigInfo iPadUUID]]];
    parameter = [parameter stringByAppendingFormat:@"'web_ipad_device_token':'%@'", [BaseInfo encrypt:[ConfigInfo iPadDeviceToken]]];
    parameter = [parameter stringByAppendingString:@"}"];
    return parameter;
}

- (NSString *)getInitDataParameter:(NSString *)userName useriPadKey:(NSString *)useriPadKey
{
    NSString *parameter = [NSString stringWithFormat:@""];
    parameter = [parameter stringByAppendingString:@"{"];
    parameter = [parameter stringByAppendingFormat:@"'web_user_name':'%@',", [BaseInfo encrypt:userName]];
    parameter = [parameter stringByAppendingFormat:@"'web_ipad_mac_address':'%@',", [BaseInfo encrypt:[ConfigInfo iPadMacAddress]]];
    parameter = [parameter stringByAppendingFormat:@"'web_key':'%@'", [BaseInfo encrypt:useriPadKey]];
    parameter = [parameter stringByAppendingString:@"}"];
    return parameter;
}

- (NSString *)getSystemInfoParameter:(NSString *)userName useriPadKey:(NSString *)useriPadKey
{
    NSString *parameter = [NSString stringWithFormat:@""];
    parameter = [parameter stringByAppendingString:@"{"];
    parameter = [parameter stringByAppendingFormat:@"'web_user_name':'%@',", [BaseInfo encrypt:userName]];
    parameter = [parameter stringByAppendingFormat:@"'web_ipad_mac_address':'%@',", [BaseInfo encrypt:[ConfigInfo iPadMacAddress]]];
    parameter = [parameter stringByAppendingFormat:@"'web_key':'%@'", [BaseInfo encrypt:useriPadKey]];
    parameter = [parameter stringByAppendingString:@"}"];
    return parameter;
}

- (NSString *)getUpdateDataParameter:(NSString *)appVersion userName:(NSString *)userName 
                      iPadMacAddress:(NSString *)iPadMacAddress useriPadKey:(NSString *)useriPadKey
{
    NSString *parameter = [NSString stringWithFormat:@""];
    parameter = [parameter stringByAppendingString:@"{"];
    parameter = [parameter stringByAppendingFormat:@"'web_data_version':'%@',", [BaseInfo encrypt:appVersion]];
    parameter = [parameter stringByAppendingFormat:@"'web_user_name':'%@',", [BaseInfo encrypt:userName]];
    parameter = [parameter stringByAppendingFormat:@"'web_ipad_mac_address':'%@',", [BaseInfo encrypt:iPadMacAddress]];
    parameter = [parameter stringByAppendingFormat:@"'web_key':'%@'", [BaseInfo encrypt:useriPadKey]];
    parameter = [parameter stringByAppendingString:@"}"];
    return parameter;
}

- (NSString *)getImageByIdParameter:(NSString *)referenceId
{
    NSString *parameter = [NSString stringWithFormat:@""];
    parameter = [parameter stringByAppendingString:@"{"];
    parameter = [parameter stringByAppendingFormat:@"'web_reference_id':'%@',", [BaseInfo encrypt:referenceId]];
    parameter = [parameter stringByAppendingFormat:@"%@", [self getTableIdAndDataVersionForImages:@"client_image" fieldName:@"image_id" where:[NSString stringWithFormat:@"reference_id='%@' AND image_type>2000", referenceId]]];
    parameter = [parameter stringByAppendingFormat:@"'web_user_name':'%@',", [BaseInfo encrypt:[UserInfo sharedUserInfo].userName]];
    parameter = [parameter stringByAppendingFormat:@"'web_ipad_mac_address':'%@',", [BaseInfo encrypt:[ConfigInfo iPadMacAddress]]];
    parameter = [parameter stringByAppendingFormat:@"'web_key':'%@'", [BaseInfo encrypt:[UserInfo sharedUserInfo].useriPadKey]];
    parameter = [parameter stringByAppendingString:@"}"];
    return parameter;
}

- (NSString *)getUserDataParameter
{
    NSString *parameter = [NSString stringWithFormat:@""];
    parameter = [parameter stringByAppendingString:@"{"];
    parameter = [parameter stringByAppendingFormat:@"'web_data_version':'%@',", 
                 [BaseInfo encrypt:[ConfigInfo AppVersion]]];
    parameter = [parameter stringByAppendingFormat:@"'web_user_name':'%@',", 
                 [BaseInfo encrypt:[UserInfo sharedUserInfo].userName]];
    parameter = [parameter stringByAppendingFormat:@"'web_ipad_mac_address':'%@',", 
                 [BaseInfo encrypt:[ConfigInfo iPadMacAddress]]];
    parameter = [parameter stringByAppendingFormat:@"'web_key':'%@'", 
                 [BaseInfo encrypt:[UserInfo sharedUserInfo].useriPadKey]];
    parameter = [parameter stringByAppendingString:@"}"];
    return parameter;
}

- (NSString *)getOrganizationParameter{
    NSString *parameter = [NSString stringWithFormat:@"{'web_user_name':'%@'}" , [BaseInfo encrypt:[UserInfo sharedUserInfo].userName]];
    return parameter;
}

- (NSString *)getDialogueParameter:(int)row{
    NSString *parameter = [NSString stringWithFormat:@"{'web_user_name':'%@' , 'web_message_count':'%@'}" , [BaseInfo encrypt:[UserInfo sharedUserInfo].userName] , [BaseInfo encrypt:[NSString stringWithFormat:@"%d" , row]]];
    return parameter;
}

- (NSString *)deleteDialogueMasterParameter:(NSString *)web_dialogue_master_ids{
    NSString *parameter = [NSString stringWithFormat:@"{'web_user_name':'%@' , 'web_dialogue_master_ids':'%@'}" , [BaseInfo encrypt:[UserInfo sharedUserInfo].userName] , [BaseInfo encrypt:web_dialogue_master_ids]];
    return parameter;
}

- (NSString *)deleteDialogueDetailParameter:(NSString *)web_dialogue_detail_ids{
    NSString *parameter = [NSString stringWithFormat:@"{'web_user_name':'%@' , 'web_dialogue_detail_ids':'%@'}" , [BaseInfo encrypt:[UserInfo sharedUserInfo].userName] , [BaseInfo encrypt:web_dialogue_detail_ids]];
    return parameter;
}

- (NSString *)getDialogueDetailParameter:(NSString *)client_dialogue_master_id{
    NSString *parameter = [NSString stringWithFormat:@"{'web_user_name':'%@' , 'web_dialogue_master_id':'%@'}" , [BaseInfo encrypt:[UserInfo sharedUserInfo].userName] , [BaseInfo encrypt:client_dialogue_master_id]];
    return parameter;
}

- (NSString *)getCloseDialogueParameter:(NSString *)web_dialogue_master_id and:(NSString *)web_dialogue_result{
    NSString *parameter = [NSString stringWithFormat:@"{'web_user_name':'%@' , 'web_dialogue_master_id':'%@' , 'web_dialogue_result':'%@'}" , [BaseInfo encrypt:[UserInfo sharedUserInfo].userName] , [BaseInfo encrypt:web_dialogue_master_id] , [BaseInfo encrypt:web_dialogue_result]];
    return parameter;
}

- (NSString *)getSystemLogParameter:(client_system_log *)model
{
    NSString *parameter = [NSString stringWithFormat:@""];
    parameter = [parameter stringByAppendingString:@"{"];
    parameter = [parameter stringByAppendingFormat:@"'web_log_level':'%@',", [BaseInfo encrypt:model.log_level]];
    parameter = [parameter stringByAppendingFormat:@"'web_log_user_name':'%@',", [BaseInfo encrypt:model.log_user_name]];
    parameter = [parameter stringByAppendingFormat:@"'web_log_module':'%@',", [BaseInfo encrypt:model.log_module]];
    parameter = [parameter stringByAppendingFormat:@"'web_log_operation':'%@',", [BaseInfo encrypt:model.log_operation]];
    parameter = [parameter stringByAppendingFormat:@"'web_log_time':'%@',", [BaseInfo encrypt:[BaseInfo getStringFromDate:model.log_time format:@"yyyy/MM/dd HH:mm:ss"]]];
    parameter = [parameter stringByAppendingFormat:@"'web_log_message':'%@',", [BaseInfo encrypt:model.log_message]];
    parameter = [parameter stringByAppendingFormat:@"'web_log_error':'%@',", [BaseInfo encrypt:model.log_error]];
    parameter = [parameter stringByAppendingFormat:@"'web_user_name':'%@',", [BaseInfo encrypt:[UserInfo sharedUserInfo].userName]];
    parameter = [parameter stringByAppendingFormat:@"'web_ipad_mac_address':'%@',", [BaseInfo encrypt:[ConfigInfo iPadMacAddress]]];
    parameter = [parameter stringByAppendingFormat:@"'web_key':'%@'", [BaseInfo encrypt:[UserInfo sharedUserInfo].useriPadKey]];
    parameter = [parameter stringByAppendingString:@"}"];
    return parameter;
}

- (NSString *)getVehicleLogParameter:(client_user_vehicle_log *)model
{
    NSString *parameter = [NSString stringWithFormat:@""];
    parameter = [parameter stringByAppendingString:@"{"];
    parameter = [parameter stringByAppendingFormat:@"'web_vehicle_user_name':'%@',", [BaseInfo encrypt:model.user_name]];
    parameter = [parameter stringByAppendingFormat:@"'web_vehicle_ipad_mac_address':'%@',", [BaseInfo encrypt:model.ipad_mac_address]];
    parameter = [parameter stringByAppendingFormat:@"'web_vehicle_configurator_id':'%@',", [BaseInfo encrypt:[NSString stringWithFormat:@"%d", [model.vehicle_configurator_id intValue]]]];
    parameter = [parameter stringByAppendingFormat:@"'web_vehicle_click_count':'%@',", [BaseInfo encrypt:[NSString stringWithFormat:@"%d", [model.click_count intValue]]]];
    parameter = [parameter stringByAppendingFormat:@"'web_vehicle_click_last_time':'%@',", [BaseInfo encrypt:[BaseInfo getStringFromDate:model.click_last_time format:@"yyyy/MM/dd HH:mm:ss"]]];
    parameter = [parameter stringByAppendingFormat:@"'web_user_name':'%@',", [BaseInfo encrypt:[UserInfo sharedUserInfo].userName]];
    parameter = [parameter stringByAppendingFormat:@"'web_ipad_mac_address':'%@',", [BaseInfo encrypt:[ConfigInfo iPadMacAddress]]];
    parameter = [parameter stringByAppendingFormat:@"'web_key':'%@'", [BaseInfo encrypt:[UserInfo sharedUserInfo].useriPadKey]];
    parameter = [parameter stringByAppendingString:@"}"];
    return parameter;
}

- (NSString *)getTableIdAndDataVersion:(NSString *)tableName fieldName:(NSString *)fieldName where:(NSString *)where
{
    NSString *rtn = @"";
    NSString *rtnIds = @"";
    NSString *rtnDs = @"";
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSString *strSql = [NSString stringWithFormat:@"SELECT %@,data_version FROM %@ WHERE %@ ORDER BY %@ ASC", fieldName, tableName, where, fieldName];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        if ([rtnIds isEqualToString:@""]) {
            rtnIds = [rtnIds stringByAppendingFormat:@"%d", [result intForColumn:fieldName]];
        }
        else {
            rtnIds = [rtnIds stringByAppendingFormat:@",%d", [result intForColumn:fieldName]];
        }
        if ([rtnDs isEqualToString:@""]) {
            rtnDs = [rtnDs stringByAppendingFormat:@"%d", [result intForColumn:@"data_version"]];
        }
        else {
            rtnDs = [rtnDs stringByAppendingFormat:@",%d", [result intForColumn:@"data_version"]];
        }
    }
    [db close];
    rtn = [NSString stringWithFormat:@"'web_ids':'%@','web_data_versions':'%@',", [BaseInfo encrypt:rtnIds], [BaseInfo encrypt:rtnDs]];
    return rtn;
}

- (NSString *)getTableIdAndDataVersionForImages:(NSString *)tableName fieldName:(NSString *)fieldName where:(NSString *)where
{
    NSString *rtn = @"";
    NSString *rtnIds = @"";
    NSString *rtnDs = @"";
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSString *strSql = [NSString stringWithFormat:@"SELECT %@,data_version,image_url FROM %@ WHERE %@ ORDER BY %@ ASC", fieldName, tableName, where, fieldName];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        
        BOOL isLoadFromDatabase = YES;
        
        NSString *imageName = [result stringForColumn:@"image_url"];
        if ((imageName == nil) || ([imageName isEqualToString:@""])) {
            //图片字段属性为空需要重新下载
            isLoadFromDatabase = NO;
        }
        else {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:@"images"];
            imagePath = [imagePath stringByAppendingPathComponent:imageName];
            if (![[NSFileManager defaultManager] fileExistsAtPath:imagePath]) { 
                //图片不存在需要重新下载
                isLoadFromDatabase = NO;
            }
        }
        
        if ([rtnIds isEqualToString:@""]) {
            rtnIds = [rtnIds stringByAppendingFormat:@"%d", [result intForColumn:fieldName]];
        }
        else {
            rtnIds = [rtnIds stringByAppendingFormat:@",%d", [result intForColumn:fieldName]];
        }
        
        if ([rtnDs isEqualToString:@""]) {
            if (isLoadFromDatabase) {
                rtnDs = [rtnDs stringByAppendingFormat:@"%d", [result intForColumn:@"data_version"]];
            }
            else {
                rtnDs = [rtnDs stringByAppendingFormat:@"%d", 0];//强制重新下载图片
            }
        }
        else {
            if (isLoadFromDatabase) {
                rtnDs = [rtnDs stringByAppendingFormat:@",%d", [result intForColumn:@"data_version"]];
            }
            else {
                rtnDs = [rtnDs stringByAppendingFormat:@",%d", 0];//强制重新下载图片
            }
        }
    }
    [db close];
    rtn = [NSString stringWithFormat:@"'web_ids':'%@','web_data_versions':'%@',", [BaseInfo encrypt:rtnIds], [BaseInfo encrypt:rtnDs]];
    return rtn;
}

#pragma mark - request

- (NSDictionary *)request:(NSString *)url parameter:(NSString *)parameter;
{
    NSDictionary *rtn = nil;
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    
    //指定基本身份认证模式 begin
    [request setAuthenticationScheme:(NSString *)kCFHTTPAuthenticationSchemeBasic];
    [request setUseSessionPersistence:NO];
    [request setUseKeychainPersistence:NO];
    [request setUsername:[ConfigInfo iPadUserName]];
    [request setPassword:[ConfigInfo iPadPassword]];
    //指定基本身份认证模式 end
    
    [request addRequestHeader:@"User-Agent" value:@"ASIHTTPRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
    [request appendPostData:[parameter dataUsingEncoding:NSUTF8StringEncoding]];
    if ([url isEqualToString:[BaseInfo UrlLogin]]) {
        [request setTimeOutSeconds:[BaseInfo getTimeOutLoginSeconds]];
    }
    else {
        [request setTimeOutSeconds:[BaseInfo getTimeOutSeconds]];
    }
    [request startSynchronous];
    NSError *error;
    if (!request.error) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[request responseData] options:kNilOptions error:&error];
        NSDictionary *data = [dictionary objectForKey:@"d"];
        if (data.count > 0) {
            rtn = [data mutableCopy];
        }
    }
    [request clearDelegatesAndCancel];
    request = nil;
    return rtn;
}

@end
