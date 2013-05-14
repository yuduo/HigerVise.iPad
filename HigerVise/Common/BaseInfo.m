#import "BaseInfo.h"

@implementation BaseInfo

#pragma mark - update sqlite database

+ (BOOL)updateSqliteDatabase
{
    BOOL rtn = YES;
    
    if ([BaseInfo isExistenceDatabase]) {
        NSString *dbPath = [BaseInfo getDataBasePath];
        FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
        [db open];
        
        //更新销售反馈平台数据结构 feedback.plist
        FMResultSet *result_fb = [db executeQuery:@"SELECT COUNT(name) FROM sqlite_master WHERE type = 'table' and name = 'client_dialogue_master'"];
        if ([result_fb next]) {
            int count = [result_fb intForColumnIndex:0];
            if (count == 0) {
                NSString *path = [[NSBundle mainBundle] pathForResource:@"feedback" ofType:@"plist"];
                NSArray *array = [NSArray arrayWithContentsOfFile:path];
                BOOL isRollback = NO;
                [db beginTransaction];
                for (NSString *strSql in array) {
                    if ([strSql isEqualToString:@""])
                        continue;
                    BOOL isRtn = [db executeUpdate:strSql];//SQL语句执行结果
                    if (!isRtn) {
                        isRollback = YES;//是否回滚
                        rtn = NO;
                        break;
                    }//执行失败则回滚数据
                }
                if (isRollback) {
                    [db rollback];//回滚数据
                }
                [db commit];
            }//不存在该表
        }//执行查询成功
        
        //更新意向订单平台数据结构 intentorder.plist
        if (rtn) {
            
        }//如果成功才执行下个版本的数据结构脚本
        
        [db close];
    }//判断是否存在数据库

    return rtn;
}

#pragma mark - log

//Info Error
+ (BOOL)addSystemLog:(NSString *)log_module
       log_operation:(NSString *)log_operation 
         log_message:(NSString *)log_message 
           log_error:(NSString *)log_error 
{
    if ([UserInfo sharedUserInfo].userName == nil || [[UserInfo sharedUserInfo].userName isEqualToString:@""]) {
        return YES;
    }
    client_system_log *model = [[client_system_log alloc] init];
    model.system_log_id = [client_system_log_dal getMaxId];
    model.log_level = @"Info";
    model.log_user_name = [UserInfo sharedUserInfo].userName;
    model.log_module = log_module;
    model.log_operation = log_operation;
    model.log_time = [NSDate date];
    model.log_message = log_message;
    model.log_error = log_error;
    model.log_upload = [NSNumber numberWithBool:NO];
    return [client_system_log_dal add:model];
}

+ (BOOL)addVehicleLog:(NSNumber *)vehicle_configurator_id vehicle_code:(NSString *)vehicle_code
{
    NSString *where = [NSString stringWithFormat:@"vehicle_configurator_id = %d", [vehicle_configurator_id intValue]];
    NSArray *array = [client_user_vehicle_log_dal getList:where];
    if (array.count > 0) {
        client_user_vehicle_log *model = [array objectAtIndex:0];
        int click_count = [model.click_count intValue] + 1;
        model.user_name = [UserInfo sharedUserInfo].userName;
        model.ipad_mac_address = [ConfigInfo iPadMacAddress];
        model.vehicle_code = vehicle_code;
        model.click_count = [NSNumber numberWithInt:click_count];
        model.click_last_time = [NSDate date];
        return [client_user_vehicle_log_dal update:model];
    }
    else {
        client_user_vehicle_log *model = [[client_user_vehicle_log alloc] init];
        model.user_vehicle_log_id = [client_user_vehicle_log_dal getMaxId];
        model.user_name = [UserInfo sharedUserInfo].userName;
        model.ipad_mac_address = [ConfigInfo iPadMacAddress];
        model.vehicle_configurator_id = vehicle_configurator_id;
        model.vehicle_code = vehicle_code;
        model.click_count = [NSNumber numberWithInt:1];
        model.click_last_time = [NSDate date];
        return [client_user_vehicle_log_dal add:model];
    }
}

#pragma mark - database

+ (NSString *)getDataBasePath
{
    if (![[UserInfo sharedUserInfo].userName isEqualToString:kHigerViseClientOffLine]) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
        NSString *documentsPath = [paths objectAtIndex:0]; 
        NSString *databasePath = [documentsPath stringByAppendingPathComponent:kHigerDatabase]; 
        return databasePath;
    }
    else {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
        NSString *documentsPath = [paths objectAtIndex:0]; 
        NSString *databasePath = [documentsPath stringByAppendingPathComponent:kHigerDatabaseOffLine]; 
        return databasePath;
    }
}

+ (BOOL)isExistenceDatabase
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *documentsPath = [paths objectAtIndex:0]; 
    NSString *databasePath = [documentsPath stringByAppendingPathComponent:kHigerDatabase]; 
    return [[NSFileManager defaultManager] fileExistsAtPath:databasePath];
}

+ (BOOL)isDebug
{
    return YES;
}

//删除所有非该用户的数据
+ (void)clearDataByUserName:(NSString *)userName userLevel:(NSString *)userLevel userArea:(NSString *)userArea;
{
    BOOL isAllowDelete = YES;
    if (([userLevel isEqualToString:@"1000"]) && ([userArea compare:@"ALL" options:NSCaseInsensitiveSearch] == NSOrderedSame)) {
        isAllowDelete = NO;
    }
    
    
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    [db beginTransaction];
    
    
    //删除用户操作日志
    NSString *strSql = [NSString stringWithFormat:@"DELETE FROM client_system_log WHERE [log_user_name] != '%@'", userName];
    [db executeUpdate:strSql];
    
    
    //删除用户登录日志
    strSql = [NSString stringWithFormat:@"DELETE FROM client_user_login WHERE [user_name] != '%@'", [BaseInfo encrypt:userName]];
    [db executeUpdate:strSql];
    
    
    //删除用户车辆日志
    strSql = [NSString stringWithFormat:@"DELETE FROM client_user_vehicle_log WHERE [user_name] != '%@'", userName];
    [db executeUpdate:strSql];
    
    
    //删除用户关注
    strSql = [NSString stringWithFormat:@"DELETE FROM client_user_vehicle_relation WHERE [user_name] != '%@'", userName];
    [db executeUpdate:strSql];
    
    
    //删除用户区域
    strSql = [NSString stringWithFormat:@"DELETE FROM client_user_edition_relation WHERE [user_name] != '%@'", userName];
    [db executeUpdate:strSql];
    
    
    //非管理员权限才需要删除数据
    if (isAllowDelete) {
        //删除系统更新
        strSql = [NSString stringWithFormat:@"DELETE FROM client_system_version WHERE NOT EXISTS (SELECT vehicle_configurator_id FROM client_user_edition_relation WHERE client_system_version.vehicle_configurator_id = client_user_edition_relation.vehicle_configurator_id AND client_user_edition_relation.[user_name] = '%@')", userName];
        [db executeUpdate:strSql];

        
        //删除车辆信息
        strSql = [NSString stringWithFormat:@"DELETE FROM client_vehicle_configurator WHERE NOT EXISTS (SELECT vehicle_configurator_id FROM client_user_edition_relation WHERE client_vehicle_configurator.vehicle_configurator_id = client_user_edition_relation.vehicle_configurator_id AND client_user_edition_relation.[user_name] = '%@')", userName];
        [db executeUpdate:strSql];
        
        
        //删除车辆版本
        strSql = [NSString stringWithFormat:@"DELETE FROM client_vehicle_edition WHERE NOT EXISTS (SELECT vehicle_edition_id FROM client_user_edition_relation WHERE client_vehicle_edition.vehicle_edition_id = client_user_edition_relation.vehicle_edition_id AND client_user_edition_relation.[user_name] = '%@')", userName];
        [db executeUpdate:strSql];
        
        
        //删除车辆版本历史
        strSql = [NSString stringWithFormat:@"DELETE FROM client_vehicle_edition_his WHERE NOT EXISTS (SELECT vehicle_configurator_id FROM client_user_edition_relation WHERE client_vehicle_edition_his.vehicle_configurator_id = client_user_edition_relation.vehicle_configurator_id AND client_user_edition_relation.[user_name] = '%@')", userName];
        [db executeUpdate:strSql];
        
        
        //删除热门车辆
        strSql = [NSString stringWithFormat:@"DELETE FROM client_vehicle_edition_hot WHERE NOT EXISTS (SELECT vehicle_configurator_id FROM client_user_edition_relation WHERE client_vehicle_edition_hot.vehicle_configurator_id = client_user_edition_relation.vehicle_configurator_id AND client_user_edition_relation.[user_name] = '%@')", userName];
        [db executeUpdate:strSql];
        
        
        //删除版本配件
        strSql = [NSString stringWithFormat:@"DELETE FROM client_vehicle_edition_setting WHERE NOT EXISTS (SELECT vehicle_edition_id FROM client_user_edition_relation WHERE client_vehicle_edition_setting.vehicle_edition_id = client_user_edition_relation.vehicle_edition_id AND client_user_edition_relation.[user_name] = '%@')", userName];
        [db executeUpdate:strSql];
        
        
        //删除版本配件历史
        strSql = [NSString stringWithFormat:@"DELETE FROM client_vehicle_edition_setting_his WHERE NOT EXISTS (SELECT vehicle_edition_id FROM client_user_edition_relation WHERE client_vehicle_edition_setting_his.vehicle_configurator_id = client_user_edition_relation.vehicle_configurator_id AND client_user_edition_relation.[user_name] = '%@')", userName];
        [db executeUpdate:strSql];
        
        
        //删除车辆约束
        strSql = [NSString stringWithFormat:@"DELETE FROM client_vehicle_setting_relation WHERE NOT EXISTS (SELECT vehicle_configurator_id FROM client_user_edition_relation WHERE client_vehicle_setting_relation.vehicle_configurator_id = client_user_edition_relation.vehicle_configurator_id AND client_user_edition_relation.[user_name] = '%@')", userName];
        [db executeUpdate:strSql];
    }

    
    //删除车辆版本历史
    strSql = [NSString stringWithFormat:@"DELETE FROM client_vehicle_edition_his WHERE vehicle_configurator_id NOT IN (SELECT vehicle_configurator_id FROM client_vehicle_configurator)"];
    [db executeUpdate:strSql];

    
    //删除版本配件历史
    strSql = [NSString stringWithFormat:@"DELETE FROM client_vehicle_edition_setting_his WHERE vehicle_configurator_id NOT IN (SELECT vehicle_configurator_id FROM client_vehicle_configurator)"];
    [db executeUpdate:strSql];
    
    
    //删除版本配件历史
    strSql = [NSString stringWithFormat:@"DELETE FROM client_vehicle_edition_setting_his WHERE vehicle_edition_id NOT IN (SELECT vehicle_edition_id FROM client_vehicle_edition_his)"];
    [db executeUpdate:strSql];

    
    //删除待删除数据   
    strSql = @"DELETE FROM client_image WHERE data_version <= 0";
    [db executeUpdate:strSql];
    strSql = @"DELETE FROM client_search WHERE data_version <= 0";
    [db executeUpdate:strSql];
    strSql = @"DELETE FROM client_search_option WHERE data_version <= 0";
    [db executeUpdate:strSql];
    strSql = @"DELETE FROM client_search_option_relation WHERE data_version <= 0";
    [db executeUpdate:strSql];
    strSql = @"DELETE FROM client_search_option_setting_relation WHERE data_version <= 0";
    [db executeUpdate:strSql];
    strSql = @"DELETE FROM client_system_version WHERE data_version <= 0";
    [db executeUpdate:strSql];
    strSql = @"DELETE FROM client_user_edition_relation WHERE data_version <= 0";
    [db executeUpdate:strSql];
    strSql = @"DELETE FROM client_user_vehicle_relation WHERE data_version <= 0";
    [db executeUpdate:strSql];
    strSql = @"DELETE FROM client_vehicle_class WHERE data_version <= 0";
    [db executeUpdate:strSql];
    strSql = @"DELETE FROM client_vehicle_configurator WHERE data_version <= 0";
    [db executeUpdate:strSql];
    strSql = @"DELETE FROM client_vehicle_edition WHERE data_version <= 0";
    [db executeUpdate:strSql];
    strSql = @"DELETE FROM client_vehicle_edition_hot WHERE data_version <= 0";
    [db executeUpdate:strSql];
    strSql = @"DELETE FROM client_vehicle_edition_setting WHERE data_version <= 0";
    [db executeUpdate:strSql];
    strSql = @"DELETE FROM client_vehicle_setting_relation WHERE data_version <= 0";
    [db executeUpdate:strSql];
    
    [db commit];
    [db close];
}

#pragma mark - datetime

+ (NSString *)getDateFromMSDateString:(NSString*)msDateString format:(NSString *)formatString
{
    NSCharacterSet *setNum = [NSCharacterSet decimalDigitCharacterSet];
    NSRange numRange = [msDateString rangeOfCharacterFromSet:setNum];
    numRange.length = [msDateString length] - numRange.location - 2;
    NSString *numString = [msDateString substringWithRange:numRange];
    
    NSNumberFormatter * numberFormatter = [[NSNumberFormatter alloc] init];
    NSNumber * number = [numberFormatter numberFromString:numString];
    double time = [number doubleValue];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatString];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time / 1000];
    return [dateFormatter stringFromDate:date];
}

+ (NSDate *)getDateFromMSDateString:(NSString*)msDateString
{
    NSCharacterSet *setNum = [NSCharacterSet decimalDigitCharacterSet];
    NSRange numRange = [msDateString rangeOfCharacterFromSet:setNum];
    numRange.length = [msDateString length] - numRange.location - 2;
    NSString *numString = [msDateString substringWithRange:numRange];
    
    NSNumberFormatter * numberFormatter = [[NSNumberFormatter alloc] init];
    NSNumber * number = [numberFormatter numberFromString:numString];
    double time = [number doubleValue];

    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time / 1000];
    return date;
}

+ (NSString *)getStringFromDate:(NSDate *)date format:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
}

#pragma mark - message

+ (UIImageView *)getMsgPrompt
{
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"msg-prompt.png"]];
}

+ (UIImageView *)getMsgSuccess
{
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"msg-success.png"]];;
}

#pragma mark - network

+ (NSTimeInterval)getTimeOutSeconds
{
    return 30.0;
}

+ (NSTimeInterval)getTimeOutLoginSeconds
{
    return 15.0;
}

+ (BOOL)isExistenceNetwork
{
	BOOL isExistenceNetwork;
	Reachability *reachability = [Reachability reachabilityWithHostName:kHigerNetworkTest];
    switch ([reachability currentReachabilityStatus]) {
        case NotReachable:
			isExistenceNetwork = NO;
            break;
        case ReachableViaWWAN:
			isExistenceNetwork = YES;//3G
            break;
        case ReachableViaWiFi:
			isExistenceNetwork = YES;//WIFI
            break;
    }
	return isExistenceNetwork;
}

+ (BOOL)isExistenceNetwork:(NSString *)url
{
	BOOL isExistenceNetwork;
	Reachability *reachability = [Reachability reachabilityWithHostName:url];
    switch ([reachability currentReachabilityStatus]) {
        case NotReachable:
			isExistenceNetwork = NO;
            break;
        case ReachableViaWWAN:
			isExistenceNetwork = YES;//3G
            break;
        case ReachableViaWiFi:
			isExistenceNetwork = YES;//WIFI
            break;
    }
	return isExistenceNetwork;
}

+ (NetworkStatus)getNetworkType
{
	Reachability *reachability = [Reachability reachabilityWithHostName:kHigerNetworkTest];
    return reachability.currentReachabilityStatus;
}

#pragma mark - encrypt

+ (NSString *)encrypt:(NSString *)value
{
    return [StringEncryption encryptString:value encryptKey:kHigerEncryptKey];
}

+ (NSString *)decrypt:(NSString *)value
{
    return [StringEncryption decryptString:value encryptKey:kHigerEncryptKey];
}

#pragma mark - file

+ (NSString *)getImageFullPath:(NSString *)imageName
{
    NSString *rtn = nil;
    if ((imageName == nil) || ([imageName isEqualToString:@""])) {
        rtn = [[NSBundle mainBundle] pathForResource:@"msg-no-image" ofType:@"png"];
    }
    else {
        if (![[UserInfo sharedUserInfo].userName isEqualToString:kHigerViseClientOffLine]) {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            rtn = [documentsDirectory stringByAppendingPathComponent:@"images"];
            rtn = [rtn stringByAppendingPathComponent:imageName];
            if (![[NSFileManager defaultManager] fileExistsAtPath:rtn]) { 
                rtn = [[NSBundle mainBundle] pathForResource:@"msg-no-image" ofType:@"png"];
            }
        }
        else {
            rtn = [[NSBundle mainBundle] pathForResource:imageName ofType:@""];
            if (![[NSFileManager defaultManager] fileExistsAtPath:rtn]) { 
                rtn = [[NSBundle mainBundle] pathForResource:@"msg-no-image" ofType:@"png"];
            }
        }
    }
    return rtn;
}

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    @try {
        const char* filePath = [[URL path] fileSystemRepresentation];
        const char* attrName = "com.apple.MobileBackup";
        u_int8_t attrValue = 1;
        setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
    }
    @catch (NSException *exception) {
        return NO;
    }
    @finally {
        return YES;
    }
}

#pragma mark - url

+ (NSString *)UrlBase
{
    return kHigerUrlBase;
}

+ (NSString *)UrlBaseTwo
{
    return kHigerUrlBaseTwo;
}

+ (NSString *)UrlLogin
{
    NSString *method = @"GetLogin";
    NSString *url = [[self UrlBase] stringByAppendingString:method];
    return url;
}

+ (NSString *)UrlInit
{
    NSString *method = @"GetInit";
    NSString *url = [[self UrlBase] stringByAppendingString:method];
    return url;
}

+ (NSString *)UrlSystemInfo
{
    NSString *method = @"GetSystemInfo";
    NSString *url = [[self UrlBase] stringByAppendingString:method];
    return url;
}

+ (NSString *)UrlUpdate
{
    NSString *method = @"GetUpdate";
    NSString *url = [[self UrlBase] stringByAppendingString:method];
    return url;
}

+ (NSString *)UrlUserData
{
    NSString *method = @"GetUserData";
    NSString *url = [[self UrlBase] stringByAppendingString:method];
    return url;
}

+ (NSString *)UrlImageById
{
    NSString *method = @"GetImageById";
    NSString *url = [[self UrlBase] stringByAppendingString:method];
    return url;
}

+ (NSString *)UrlUploadSystemLog
{
    NSString *method = @"UploadSystemLog";
    NSString *url = [[self UrlBase] stringByAppendingString:method];
    return url;
}

+ (NSString *)UrlUploadUserVehicleLog
{
    NSString *method = @"UploadUserVehicleLog";
    NSString *url = [[self UrlBase] stringByAppendingString:method];
    return url;
}

+ (NSString *)UrlCertificate
{
    NSString *method = @"GetCertificate";
    NSString *url = [[self UrlBase] stringByAppendingString:method];
    return url;
}

+ (NSString *)UrlAddDialogue{
    NSString *method = @"AddDialogue";
    NSString *url = [[self UrlBaseTwo] stringByAppendingString:method];
    return url;
}

+ (NSString *)UrlAddDialogueDetail{
    NSString *method = @"AddDialogueDetail";
    NSString *url = [[self UrlBaseTwo] stringByAppendingString:method];
    return url;
}

+ (NSString *)UrlGetDialogueClass{
    NSString *method = @"GetDialogueClass";
    NSString *url = [[self UrlBaseTwo] stringByAppendingString:method];
    return url;
}

+ (NSString *)UrlGetUser{
    NSString *method = @"GetUser";
    NSString *url = [[self UrlBaseTwo] stringByAppendingString:method];
    return url;
}

+ (NSString *)UrlGetOrganization{
    NSString *method = @"GetOrganization";
    NSString *url = [[self UrlBaseTwo] stringByAppendingString:method];
    return url;
}

+ (NSString *)UrlGetDialogue{
    NSString *method = @"GetDialogue";
    NSString *url = [[self UrlBaseTwo] stringByAppendingString:method];
    return url;
}

+ (NSString *)UrlDeleteDialogueMaster{
    NSString *method = @"DeleteDialogueMaster";
    NSString *url = [[self UrlBaseTwo] stringByAppendingString:method];
    return url;
}

+ (NSString *)UrlDeleteDialogueDetail{
    NSString *method = @"DeleteDialogueDetail";
    NSString *url = [[self UrlBaseTwo] stringByAppendingString:method];
    return url;
}

+ (NSString *)UrlGetDialogueDetail{
    NSString *method = @"GetDialogueDetail";
    NSString *url = [[self UrlBaseTwo] stringByAppendingString:method];
    return url;
}

+ (NSString *)UrlCloseDialogue{
    NSString *method = @"CloseDialogue";
    NSString *url = [[self UrlBaseTwo] stringByAppendingString:method];
    return url;
}

+ (NSString *)UrlGetImageDownloadBasePath{
    NSString *url = kHigerUrlBaseThree;
    return url;
}

#pragma mark - string

+ (BOOL)isExistenceString:(NSString *)searchString string:(NSString *)string
{
    BOOL rtn = NO;
    NSArray *array = [string componentsSeparatedByString:@"^"];
    for (NSString *unitString in array) {
        if ([unitString compare:searchString options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            rtn = YES;
            break;
        }
    }
    return rtn;
}

+ (UIView *)addLabelToImage:(NSString *)text font:(UIFont *)font color:(UIColor *)color width:(float)width height:(float)height
{
    //int label_height = font.pointSize;
    //int label_width = sqrtf(powf(width, 2) + powf(height, 2)) - label_height * 2;
    //int label_x = sqrtf((powf(label_height, 2)/2));
    //int label_y = height - sqrtf((powf(label_height, 2)/2));
    
    int margin_x = 50;
    //int margin_y = 100;
    
    int label_height = font.pointSize;// * 2 + font.pointSize / 4;
    int label_width = width - margin_x * 2;
    int label_x = margin_x;
    int label_y = (height - label_height)/2;
    
    if (text.length == 2) {
        NSRange rang;
        rang.length = 1;
        rang.location = 0;
        NSString *text1 = [text substringWithRange:rang];
        rang.length = 1;
        rang.location = 1;
        NSString *text2 = [text substringWithRange:rang];
        text = [NSString stringWithFormat:@"%@　%@", text1, text2];
    }

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, label_width, label_height)];
    label.font = font;
    label.text = text;//[NSString stringWithFormat:@"%@\r\n%@", text, text_uuid];
    label.textAlignment = UITextAlignmentCenter;
    label.minimumFontSize = 10;
    label.adjustsFontSizeToFitWidth = YES;
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    label.lineBreakMode = UILineBreakModeWordWrap;
    label.numberOfLines = 1;
    //CGAffineTransform transform = label.transform;
    //label.transform = CGAffineTransformRotate(transform, -((M_PI*2)/360*15));
    
    NSString *text_uuid = [[ConfigInfo iPadUUID] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    text_uuid = [text_uuid substringToIndex:6];
    UILabel *label_uuid = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 + label_height, label_width, label_height)];
    label_uuid.font = font;
    label_uuid.text = text_uuid;//[NSString stringWithFormat:@"%@\r\n%@", text, text_uuid];
    label_uuid.textAlignment = UITextAlignmentCenter;
    label_uuid.minimumFontSize = 10;
    label_uuid.adjustsFontSizeToFitWidth = YES;
    label_uuid.textColor = color;
    label_uuid.backgroundColor = [UIColor clearColor];
    label_uuid.lineBreakMode = UILineBreakModeWordWrap;
    label_uuid.numberOfLines = 1;
    //CGAffineTransform transform_uuid = label_uuid.transform;
    //label_uuid.transform = CGAffineTransformRotate(transform_uuid, -((M_PI*2)/360*15));

    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    view.frame = CGRectMake(label_x, label_y, label_width, label_height * 2);
    [view addSubview:label];
    [view addSubview:label_uuid];
    CGAffineTransform transform = view.transform;
    view.transform = CGAffineTransformRotate(transform, -((M_PI*2)/360*15));
    
    return view;
}

+ (UILabel *)addLabelToImage:(float)width height:(float)height
{
    float font_max_size = 12;       //字体最大大小
    float font_min_size = 8;        //字体最小大小
    float label_height = font_max_size;
    float label_width = width < 200 ? width : 200;
    float label_x = (width - label_width) / 2;
    float label_y = height - label_height - 10;
    NSString *text = @"图片仅供造型参考  不作签订合同依据";

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(label_x, label_y, label_width, label_height)];
    label.font = [UIFont fontWithName:@"Helvetica" size:font_max_size];
    label.text = text;
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    //label.layer.cornerRadius = 4;
    //label.layer.masksToBounds = YES;
    label.lineBreakMode = UILineBreakModeWordWrap;
    label.adjustsFontSizeToFitWidth = YES;
    label.minimumFontSize = font_min_size;
    label.numberOfLines = 1;
    return label;
}

+ (NSString *)getValueWithKey:(NSString *)key inString:(NSString *)string
{
    NSString *value = @"";
    NSArray *stringArray = [string componentsSeparatedByString:@"^"];
    for (int i = 0; i < [stringArray count]; i++) {
        NSString *string = [stringArray objectAtIndex:i];
        NSArray *keyValue = [string componentsSeparatedByString:@":"];
        if ([[keyValue objectAtIndex:0] isEqualToString:key]) {
            if ([keyValue count] > 1) {
                value = [keyValue objectAtIndex:1];
            }else {
                value = @"";
            }
            break;
        }else {
            continue;
        }
    }
    
    return value;
}

+ (NSArray *)getLabelsWithString:(NSString *)string point:(CGPoint)point size:(CGSize)size font:(UIFont *)font color:(UIColor *)color
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSArray *stringArray = [string componentsSeparatedByString:@"^"];
    float label_y = point.y;
    for (int i = 0; i < [stringArray count]; i++) {
        NSString *string = [stringArray objectAtIndex:i];
        
        //NSArray *keyValue = [string componentsSeparatedByString:@":"];
        //if (keyValue.count > 1) {
        //    NSString *value = [keyValue objectAtIndex:1];
        //    if ([value isEqualToString:@""]) {
        //        continue;
        //    }
        //}
        
        if ([string isEqualToString:@""]) {
            continue;
        }
        
        UILabel *label = [[UILabel alloc] init];
        label.text = string;
        label.font = font;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = color;
        label.lineBreakMode = UILineBreakModeWordWrap;
        label.numberOfLines = 0;
        CGSize label_size = [string sizeWithFont:font constrainedToSize:size lineBreakMode:label.lineBreakMode];
        label.frame = CGRectMake(point.x, label_y, label_size.width, label_size.height);
        label_y = label_y + label_size.height + 10;
        [array addObject:label];
    }
    return array;
}

+ (NSString *)getReplaceWithString:(NSString *)string
{
    NSString *rtn = [string stringByReplacingOccurrencesOfString:@"'" withString:@""];
    rtn = [rtn stringByReplacingOccurrencesOfString:@"." withString:@""];
    rtn = [rtn stringByReplacingOccurrencesOfString:@"。" withString:@""];
    return rtn;
}

#pragma mark - cache image

+ (NSString *)createCacheImage:(NSString *)imagePath size:(CGSize)size version:(int)version
{
    return [self createCacheImage:imagePath size:size version:version fill:NO center:NO];
}

//创建缓存图片
//imagePath:图片物理路径
//size:压缩至的大小
//version:图片版本号
//fill:是否按照size填充,其他未填充位置使用透明色彩,在no的情况下以图片适应size的大小下输出
//center:在填充之后,是否居中显示,只有在fill为yes的情况下才有效
+ (NSString *)createCacheImage:(NSString *)imagePath size:(CGSize)size version:(int)version fill:(BOOL)fill center:(BOOL)center
{
    //return imagePath;
    
    //判断图片是否存在
    NSString *baseImagePath = [[NSBundle mainBundle] pathForResource:@"msg-no-image" ofType:@"png"];
    if ([imagePath isEqualToString:baseImagePath]) {
        return baseImagePath;
    }
    
    //判断缓存文件夹是否存在
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"images"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:cachePath])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:cachePath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:NULL];
    }
    
    //获取图片文件夹名称
    NSArray *array = [imagePath pathComponents];
    if (array.count <= 0) {
        return baseImagePath;
    }
    NSString *imageName = [array objectAtIndex:(array.count - 1)];
    
    NSString *subImageName = [NSString stringWithFormat:@"%@.%d.%.0fx%.0f.png", imageName, version, size.width, size.height];
    NSString *subImagePath = [cachePath stringByAppendingPathComponent:subImageName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:subImagePath])
    {
        return subImagePath;
    }
    
    //生成缓存缩略图片
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    CGSize oldSize = image.size;//原有图片大小
    CGRect rect = CGRectNull;//图片压缩框架
    if (size.width / size.height > oldSize.width / oldSize.height) {
        rect.size.width = size.height * oldSize.width / oldSize.height;
        rect.size.height = size.height;
        if (fill) {
            rect.origin.x = center ? (size.width - rect.size.width) / 2 : 0;
        }
        else {
            rect.origin.x = 0;
        }
        rect.origin.y = 0;
    }
    else {
        rect.size.width = size.width;
        rect.size.height = size.width * oldSize.height / oldSize.width;
        rect.origin.x = 0;
        if (fill) {
            rect.origin.y = center ? (size.height - rect.size.height) / 2 : 0;
        }
        else {
            rect.origin.y = 0;
        }
    }
    
    if (fill) {
        UIGraphicsBeginImageContext(size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, size.width, size.height));
        [image drawInRect:rect];
        UIImage *subImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        NSData *subImageData = UIImagePNGRepresentation(subImage);
        [subImageData writeToFile:subImagePath atomically:YES];
        context = nil;
        subImageData = nil;
        subImage = nil;
        return subImagePath;
    }
    else {
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, rect.size.width, rect.size.height));
        [image drawInRect:rect];
        UIImage *subImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        NSData *subImageData = UIImagePNGRepresentation(subImage);
        [subImageData writeToFile:subImagePath atomically:YES];
        context = nil;
        subImageData = nil;
        subImage = nil;
        return subImagePath;
    }
}

#pragma mark - vehicle edition setting his sql

//+ (NSString *)getVehicleEditionSettingHisSql:(SqlType)sqlType
//{
//    if (sqlType == SqlTypeSettingChanged) {
//        
//    }
//}
+ (NSString*)getLocalDocmentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

    return [paths objectAtIndex:0];
}
+ (NSString*)getDownloadManageFile
{
    return [[self getLocalDocmentPath] stringByAppendingPathComponent:DOWNLOAD_SOURCE_LIST];
}
@end