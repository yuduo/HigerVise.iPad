//
//  LoginService.m
//  HigerVise
//
//  Created by Kevin.Mao on 12-10-12.
//  Copyright (c) 2012年 JijeSoft. All rights reserved.
//

#import "LoginService.h"

@implementation LoginService

- (id)initWithViewModel:(LoginViewModel *)loginViewModel
{
    self = [super init];
    if (self) {
        _loginViewModel = loginViewModel;
        _dataService = [[DataService alloc] init];
    }
    return self;
}

- (void)dealloc
{
    _initDataZipName = nil;
    _initDataZipTempName = nil;
    _initDataVersion = nil;
    
    _userDataZipName = nil;
    _userDataZipTempName = nil;
    _userDataVersion = nil;
    
    _userName = nil;
    _userPwd = nil;
    _useriPadKey = nil;
    _userRealName = nil;
    _userArea = nil;
    _userLevel = nil;
    
    [_request clearDelegatesAndCancel];
    _request = nil;
    
    _loginViewModel = nil;
    _dataService = nil;
}

#pragma mark - login progress

- (void)requestLogin:(NSString *)userName userPwd:(NSString *)userPwd
{
    _userName = userName;
    _userPwd = userPwd;
    
    if ([BaseInfo isExistenceNetwork]) {
        //请求资源下载证书
        [self requestCertificate];
        //开始启动网络登陆
        NSDictionary *data = [_dataService requestLogin:_userName userPwd:_userPwd];
        if (data) {
            [self performSelector:@selector(hanlderRequestLogin:) withObject:data afterDelay:0.1];
            return;
        }
    }

    //判断是否需要联网下载数据初始化
    if ([ConfigInfo AppStatus] == kAppStatusInit) {
        [_loginViewModel setValue:[NSNumber numberWithInt:LoginErrorInit] forKey:@"result"];
        return;
    }
    
    //判断在非初始化状态下，依旧没有数据库，表示系统已经删除
    if (![BaseInfo isExistenceDatabase]) {
        [_loginViewModel setValue:[NSNumber numberWithInt:LoginErrorDelete] forKey:@"result"];
        return;
    }
    
    //判断是否锁定
    if ([ConfigInfo iPadStatus] == kiPadStatusLock) {
        [_loginViewModel setValue:[NSNumber numberWithInt:LoginErrorLock] forKey:@"result"];
        return;
    }
    
    //验证该帐号是否存在登录成功纪录
    //if (![self isUserSuccessLogin:_userName]) {
    //    [_loginViewModel setValue:[NSNumber numberWithInt:LoginErrorNotUser] forKey:@"result"];
    //    return;
    //}
    
    //判断帐号与密码正确与否
    if (![self isPasswordCorrect:_userName userPwd:_userPwd]) {
        //添加错误登录纪录
        [self logUserErrorLogin:_userName userPwd:_userPwd];
        //判断是否需要锁定系统
        if ([self isShouldLock]) {
            [ConfigInfo setConfigValue:[NSString stringWithFormat:@"%d", kiPadStatusLock] key:kiPadStatus];
        }
        [_loginViewModel setValue:[NSNumber numberWithInt:LoginErrorPassword] forKey:@"result"];
        return;
    }
    
    //判断密码是否过期
    if ([self isPasswordFailure:_userName]) {
        [_loginViewModel setValue:[NSNumber numberWithInt:LoginErrorFailure] forKey:@"result"];
        return;
    }
    
    [self setSharedUserInfoInfo:YES];
    [_loginViewModel setValue:[NSNumber numberWithInt:LoginSuccess] forKey:@"result"];
    return;
}

//处理网络登录信息
- (void)hanlderRequestLogin:(NSDictionary *)data 
{
    NSInteger code = [[data objectForKey:@"Code"] intValue];
    BOOL delete = [[data objectForKey:@"Delete"] boolValue];
    BOOL unLock = [[data objectForKey:@"UnLock"] boolValue];
    BOOL lock = [[data objectForKey:@"Lock"] boolValue];
    BOOL clearError = [[data objectForKey:@"ClearError"] boolValue];
    BOOL logError = [[data objectForKey:@"LogError"] boolValue];
    BOOL logSuccess = [[data objectForKey:@"LogSuccess"] boolValue];
    _useriPadKey = [data objectForKey:@"Key"];
    _userRealName = [data objectForKey:@"Name"];
    _userLevel = [data objectForKey:@"Level"];
    _userArea = [data objectForKey:@"Area"];
    
    if (delete) {
        [self deleteDatabaseFile];
        [ConfigInfo setConfigValue:[NSString stringWithFormat:@"%d", kAppStatusInit] key:kAppStatus];
    }
    if (unLock) {
        [ConfigInfo setConfigValue:[NSString stringWithFormat:@"%d", kiPadStatusNormal] key:kiPadStatus];
    }
    if (lock) {
        [ConfigInfo setConfigValue:[NSString stringWithFormat:@"%d", kiPadStatusLock] key:kiPadStatus];
    }
    if ([BaseInfo isExistenceDatabase]) {
        
        //如果用户登录成功并且该用户存在数据库
        if (code == 1001 || code == 1002) {
            //检查用户帐号或者用户级别或者用户区域是否变更
            [self checkUserData:_userName userLevel:_userLevel userArea:_userArea];
        }

        if (clearError) {
            [self clearUserErrorLogin];
        }
        if (logError) {
            [self logUserErrorLogin:_userName userPwd:_userPwd];
            if ([self isShouldLock]) {
                [ConfigInfo setConfigValue:[NSString stringWithFormat:@"%d", kiPadStatusLock] key:kiPadStatus];
            }
        }
        if (logSuccess) {
            [self logUserSuccessLogin:_userName userPwd:_userPwd useriPadKey:_useriPadKey userRealName:_userRealName userLevel:_userLevel userArea:_userArea];
        }
    }
    
    if (code == 1011) {
        [_loginViewModel setValue:[NSNumber numberWithInt:LoginErrorDelete] forKey:@"result"];
        return;
    }
    if (code == 1012 || code == 1014) {
        [_loginViewModel setValue:[NSNumber numberWithInt:LoginErrorLock] forKey:@"result"];
        return;
    }
    if (code == 1013) {
        [_loginViewModel setValue:[NSNumber numberWithInt:LoginErrorLoginKey] forKey:@"result"];;
        return;
    }
    if (code == 1015 || code == 1016) {
        [_loginViewModel setValue:[NSNumber numberWithInt:LoginErrorPassword] forKey:@"result"];
        return;
    }
    if (code == 1017) {
        [_loginViewModel setValue:[NSNumber numberWithInt:LoginErroriPadUser] forKey:@"result"];
        return;
    }
    if (code == 1001 || code == 1002) {
        if ([ConfigInfo AppStatus] == kAppStatusInit) {
            [_loginViewModel setValue:[NSNumber numberWithInt:LoginInitRequest] forKey:@"result"];
            [self performSelector:@selector(requestInitData) withObject:nil afterDelay:0.1];
            return;
        }
        else {
            [self setSharedUserInfoInfo:NO];
            [self requestSystemInfo];
            [self performSelectorInBackground:@selector(uploadSystemLog) withObject:nil];
            [self performSelectorInBackground:@selector(uploadVehicleLog) withObject:nil];
            //[self performSelector:@selector(uploadSystemLog) withObject:nil afterDelay:0.1];
            //[self performSelector:@selector(uploadVehicleLog) withObject:nil afterDelay:0.1];
            //[self uploadSystemLog];
            //[self uploadVehicleLog];
            return;
        }
    }
    
    [_loginViewModel setValue:[NSNumber numberWithInt:LoginErrorNotNet] forKey:@"result"];
    return;
}

#pragma mark - init progress

//请求初始化数据信息
- (void)requestInitData
{
    NSDictionary *data = [_dataService requestInitData:_userName useriPadKey:_useriPadKey];
    if (data) {
        NSInteger code = [[data objectForKey:@"Code"] intValue];
        _initDataVersion = [data objectForKey:@"Version"];
        NSString *url = [BaseInfo decrypt:[data objectForKey:@"Url"]];
        //NSString *url = [data objectForKey:@"Url"];
        
        if (code == 1011) {
            [_loginViewModel setValue:[NSNumber numberWithInt:LoginErrorUserKey] forKey:@"result"];
            return;
        }
        
        if (code == 1001) {
            [_loginViewModel setValue:[NSNumber numberWithInt:LoginInitDownload] forKey:@"result"];
            [self performSelector:@selector(handlerRequestInitData:) withObject:url afterDelay:0.1];
            return;
        }
    }
    
    [_loginViewModel setValue:[NSNumber numberWithInt:LoginErrorNotNet] forKey:@"result"];
}

//请求初始化数据下载
- (void)handlerRequestInitData:(NSString *)url
{
    [self createTempFolder];//创建断点续传临时文件夹
    
    _prgSumSize = 0.0;
    _prgDownloadSize = 0.0;
    _prgValue = 0.0;
    
    NSArray *urls = [url pathComponents];
    _initDataZipName = [urls objectAtIndex:(urls.count - 1)];
    _initDataZipTempName = [NSString stringWithFormat:@"temp/%@.temp", _initDataZipName];
    
    //下载数据初始化包
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *path = [paths objectAtIndex:0];
    NSString *savePath = [path stringByAppendingPathComponent:_initDataZipName];
    NSString *tempPath = [path stringByAppendingPathComponent:_initDataZipTempName];
    _request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    //指定基本身份认证模式 begin
    [_request setAuthenticationScheme:(NSString *)kCFHTTPAuthenticationSchemeBasic];
    [_request setUseSessionPersistence:NO];
    [_request setUseKeychainPersistence:NO];
    [_request setUsername:[ConfigInfo iPadUserName]];
    [_request setPassword:[ConfigInfo iPadPassword]];
    //NSLog(@"%@", [ConfigInfo iPadUserName]);
    //NSLog(@"%@", [ConfigInfo iPadPassword]);
    //指定基本身份认证模式 end
    
    _request.delegate = self;
    _request.downloadProgressDelegate = self;
    _request.showAccurateProgress = YES;
    [_request setTimeOutSeconds:[BaseInfo getTimeOutSeconds]];
    [_request setDownloadDestinationPath:savePath];
    [_request setTemporaryFileDownloadPath:tempPath];
    [_request setAllowResumeForFileDownloads:YES];
    [_request startAsynchronous];
}

//解压初始化数据包
- (void)unZipInitData
{
    ZipArchive *zip = [[ZipArchive alloc] init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *path = [paths objectAtIndex:0];
    NSString *imagePath = [path stringByAppendingPathComponent:@"images"];
    NSString *zipPath = [path stringByAppendingPathComponent:_initDataZipName];
    //NSString *zipTempPath = [path stringByAppendingPathComponent:@"temp"];
    NSString *zipUnPath = path;
    
    if([zip UnzipOpenFile:zipPath])
    {
        BOOL result = [zip UnzipFileTo:zipUnPath overWrite:YES];
        if (!result) {
            [zip UnzipCloseFile];
            [_loginViewModel setValue:[NSNumber numberWithInt:LoginErrorExpandZip] forKey:@"result"];
            [self deleteInitDataZip];
            return;
        }
        [zip UnzipCloseFile];
    }
    else {
        [_loginViewModel setValue:[NSNumber numberWithInt:LoginErrorExpandZip] forKey:@"result"];
        [self deleteInitDataZip];
        return;
    }
    
    //不同步至iCloud
    [BaseInfo addSkipBackupAttributeToItemAtURL:[[NSURL alloc] initWithString:[BaseInfo  getDataBasePath]]];
    [BaseInfo addSkipBackupAttributeToItemAtURL:[[NSURL alloc] initWithString:imagePath]];
    
    //删除数据包以及临时文件夹
    [self deleteInitDataZip];
    
    //删除所有非该用户数据
    [BaseInfo clearDataByUserName:_userName userLevel:_userLevel userArea:_userArea];
    
    //纪录登录成功状态
    if ([BaseInfo isExistenceDatabase]) {
        [self logUserSuccessLogin:_userName userPwd:_userPwd useriPadKey:_useriPadKey userRealName:_userRealName userLevel:_userLevel userArea:_userArea];
    }
    
    [ConfigInfo setConfigValue:@"0" key:kAppUserData];
    [ConfigInfo setConfigValue:[NSString stringWithFormat:@"%d", kAppStatusNormal] key:kAppStatus];//修改初始化状态
    [ConfigInfo setConfigValue:_initDataVersion key:kAppVersion];//纪录数据版本号

    [self setSharedUserInfoInfo:NO];
    [self requestSystemInfo];
    [self performSelectorInBackground:@selector(uploadSystemLog) withObject:nil];
    [self performSelectorInBackground:@selector(uploadVehicleLog) withObject:nil];
}

#pragma mark - systeminfo

//处理系统配置信息请求
- (void)requestSystemInfo
{
    NSDictionary *data = [_dataService requestSystemInfo:_userName useriPadKey:_useriPadKey];
    if (data) {
        NSInteger code = [[data objectForKey:@"Code"] intValue];
        if (code == 1001) {
            NSString *errorNumber = [data objectForKey:@"ErrorNumber"];
            NSString *failureMinutes = [data objectForKey:@"FailureMinutes"];
            NSString *lockMinutes = [data objectForKey:@"LockMinutes"];
            NSString *dataVersion = [data objectForKey:@"DataVersion"];
            
            //修改配置信息
            [ConfigInfo setConfigValue:errorNumber key:kServerErrorNumber];
            [ConfigInfo setConfigValue:failureMinutes key:kServerFailureMinutes];
            [ConfigInfo setConfigValue:lockMinutes key:kServerLockMinutes];
            [ConfigInfo setConfigValue:dataVersion key:kServerVersion];
        }
    }
    
    [_loginViewModel setValue:[NSNumber numberWithInt:LoginSuccess] forKey:@"result"];
}

#pragma mark - systemlog

//上传系统日志
- (void)uploadSystemLog
{
    NSArray *array = [client_system_log_dal getList:@"log_upload=0"];
    for (int i = 0; i < array.count; i++) {
        //@autoreleasepool {
        client_system_log *model = [array objectAtIndex:i];
        BOOL rtn = [_dataService uploadSystemLog:model];
        if (rtn) {
            [client_system_log_dal delete:model.system_log_id];
        }
        else {
            break;
        }
        //}
    }
}

#pragma mark - vehiclelog

//上传车辆点击日志
- (void)uploadVehicleLog
{
    NSArray *array = [client_user_vehicle_log_dal getList:@"1=1"];
    for (int i = 0; i < array.count; i++) {
        //@autoreleasepool {
        client_user_vehicle_log *model = [array objectAtIndex:i];
        BOOL rtn = [_dataService uploadVehicleLog:model];
        if (!rtn) {
            break;
        }
        //}
    }
}

#pragma mark - certificate

- (void)requestCertificate
{
    NSDictionary *data = [_dataService requestCertificate:YES];
    if (data) {
        NSInteger code = [[data objectForKey:@"Code"] intValue];
        if (code == 1001) {
            
            //获取帐号以及密码
            NSString *iPadUserName = [data objectForKey:@"UserName"];
            NSString *iPadPassword = [data objectForKey:@"Password"];
            iPadUserName = [BaseInfo decrypt:iPadUserName];
            iPadPassword = [BaseInfo decrypt:iPadPassword];
            
            //资源请求帐号以及资源请求密码存在则修改
            if (iPadUserName != nil && (![iPadUserName isEqualToString:@""]) &&
                iPadPassword != nil && (![iPadPassword isEqualToString:@""])) {
                //修改客户端请求资源配置信息
                [ConfigInfo setConfigValue:iPadUserName key:kiPadUserName];
                [ConfigInfo setConfigValue:iPadPassword key:kiPadPassword];
            }
        }
    }
}

#pragma mark - user data progress

//请求用户新的权限数据
- (void)requestUserData:(NSString *)userName
{
    NSDictionary *data = [_dataService requestUserData];
    if (data) {
        NSInteger code = [[data objectForKey:@"Code"] intValue];
        NSString *url = [BaseInfo decrypt:[data objectForKey:@"Url"]];
        _userDataVersion = [data objectForKey:@"Version"];
        
        if (code == 1011) {
            [_loginViewModel setValue:[NSNumber numberWithInt:LoginErrorUserKey] forKey:@"result"];
            return;
        }
        
        if (code == 1001) {
            [self performSelector:@selector(hanlderRequestUserData:) withObject:url afterDelay:0.1];
            [_loginViewModel setValue:[NSNumber numberWithInt:LoginDataDownload] forKey:@"result"];
            return;
        }
        
        if (code == 1002) {
            [self performSelector:@selector(handlerRequestInitData:) withObject:url afterDelay:0.1];
            [_loginViewModel setValue:[NSNumber numberWithInt:LoginInitDownload] forKey:@"result"];
            return;
        }
    }
    
    [_loginViewModel setValue:[NSNumber numberWithInt:LoginErrorNotNet] forKey:@"result"];
}

//处理用户新的权限数据下载
- (void)hanlderRequestUserData:(NSString *)url
{
    [self createTempFolder];//创建断点续传临时文件夹
    
    _prgSumSize = 0.0;
    _prgDownloadSize = 0.0;
    _prgValue = 0.0;
    
    NSArray *urls = [url pathComponents];
    _userDataZipName = [urls objectAtIndex:(urls.count - 1)];
    _userDataZipTempName = [NSString stringWithFormat:@"temp/%@.temp", _userDataZipName];
    
    //下载数据初始化包
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *path = [paths objectAtIndex:0];
    NSString *savePath = [path stringByAppendingPathComponent:_userDataZipName];
    NSString *tempPath = [path stringByAppendingPathComponent:_userDataZipTempName];
    if (_request) {
        [_request clearDelegatesAndCancel];
        _request = nil;
    }
    _request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
    //指定基本身份认证模式 begin
    [_request setAuthenticationScheme:(NSString *)kCFHTTPAuthenticationSchemeBasic];
    [_request setUseSessionPersistence:NO];
    [_request setUseKeychainPersistence:NO];
    [_request setUsername:[ConfigInfo iPadUserName]];
    [_request setPassword:[ConfigInfo iPadPassword]];
    //指定基本身份认证模式 end
    _request.delegate = self;
    _request.downloadProgressDelegate = self;
    _request.showAccurateProgress = YES;
    _request.username = @"UserData";
    [_request setTimeOutSeconds:[BaseInfo getTimeOutSeconds]];
    [_request setDownloadDestinationPath:savePath];
    [_request setTemporaryFileDownloadPath:tempPath];
    [_request setAllowResumeForFileDownloads:YES];
    [_request startAsynchronous];
}

//解压处理用户数据包
- (void)unZipUserData
{
    ZipArchive *zip = [[ZipArchive alloc] init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *path = [paths objectAtIndex:0];
    NSString *imagePath = [path stringByAppendingPathComponent:@"images"];//图片文件夹
    NSString *zipPath = [path stringByAppendingPathComponent:_userDataZipName];//压缩包路径
    //NSString *zipTempPath = [path stringByAppendingPathComponent:@"temp"];//临时文件夹目录
    NSString *zipUnPath = path;//解压到的目录
    
    if([zip UnzipOpenFile:zipPath])
    {
        BOOL result = [zip UnzipFileTo:zipUnPath overWrite:YES];
        if (!result) {
            [zip UnzipCloseFile];
            [_loginViewModel setValue:[NSNumber numberWithInt:LoginErrorExpandZip] forKey:@"result"];
            [self deleteUserDataZip];
            return;
        }
        [zip UnzipCloseFile];
    }
    else {
        [_loginViewModel setValue:[NSNumber numberWithInt:LoginErrorExpandZip] forKey:@"result"];
        [self deleteUserDataZip];
        return;
    }

    //不同步至iCloud
    [BaseInfo addSkipBackupAttributeToItemAtURL:[[NSURL alloc] initWithString:imagePath]];
    
    //删除数据包以及临时文件夹
    [self deleteUserDataZip];
    
    [self performSelector:@selector(modifyUserData) withObject:nil afterDelay:0.1];
    [_loginViewModel setValue:[NSNumber numberWithInt:LoginDataModify] forKey:@"result"];
}

//根据文本内容修改用户数据
- (void)modifyUserData
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *path = [paths objectAtIndex:0];
    path = [path stringByAppendingPathComponent:kUserTextName];
    
    if (![fileManager fileExistsAtPath:path]) {
        [_loginViewModel setValue:[NSNumber numberWithInt:LoginErrorDataModify] forKey:@"result"];
    }
    else {
        
        //获取数据库执行脚本
        NSStringEncoding stringEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000); 
        NSString *stringData = [[NSString alloc] initWithContentsOfFile:path encoding:stringEncoding error:nil];
        NSArray *array = [stringData componentsSeparatedByString:@"\r\n"];
        
        //执行数据库脚本
        BOOL isRollback = NO;
        NSString *dbPath = [BaseInfo getDataBasePath];
        FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
        [db open];
        [db beginTransaction];
        for (NSString *strSql in array) {
            if ([strSql isEqualToString:@""])
                continue;
            BOOL isRtn = [db executeUpdate:strSql];//SQL语句执行结果
            if (!isRtn) {
                isRollback = YES;//是否回滚
                if ([BaseInfo isDebug]) {
                    NSLog(@"数据批量更新错误：%@", db.lastErrorMessage);
                }
                break;
            }//执行失败则回滚数据
        }
        if (isRollback) {
            [db rollback];//回滚数据
        }
        [db commit];
        [db close];
        
        //执行删除相关脚本
        [fileManager removeItemAtPath:path error:nil];//删除脚本文件
        if (!isRollback) {
            
            //删除所有非该用户数据
            [BaseInfo clearDataByUserName:[UserInfo sharedUserInfo].userName userLevel:[UserInfo sharedUserInfo].userLevel userArea:[UserInfo sharedUserInfo].userArea];
            
            NSString *versionWhere = [NSString stringWithFormat:@"data_version > %@", [ConfigInfo AppVersion]];
            NSArray *versionArray = [client_system_version_dal getListForIndex:versionWhere];
            NSString *versionMessage = @"";
            NSString *editionWhere = @"";
            for (client_system_version *versionModel in versionArray) {
                //获取更新文本提示
                if (![versionModel.version_desc isEqualToString:@""]) {
                    NSString *versionDesc = [NSString stringWithFormat:@"%@\r\n%@\r\n\r\n", versionModel.vehicle_code, versionModel.version_desc];
                    versionMessage = [versionMessage stringByAppendingString:versionDesc];
                }
                
                //更新车辆历史版本条件
                if ([editionWhere isEqualToString:@""]) {
                    editionWhere = [NSString stringWithFormat:@"%d", [versionModel.vehicle_configurator_id intValue]];
                }
                else {
                    editionWhere = [NSString stringWithFormat:@"%@, %d", editionWhere, [versionModel.vehicle_configurator_id intValue]];
                }
            }
            _loginViewModel.updateDesc = versionMessage;
            
            //更新车辆历史版本
            if (![editionWhere isEqualToString:@""]) {
                editionWhere = [NSString stringWithFormat:@"WHERE edition_cancel = 0 AND vehicle_configurator_id IN (%@)", editionWhere];
                NSString *strSql = [NSString stringWithFormat:@"UPDATE client_vehicle_edition_his SET edition_cancel = 1 %@", editionWhere];
                dbPath = [BaseInfo getDataBasePath];
                db = [[FMDatabase alloc] initWithPath:dbPath];
                [db open];
                [db executeUpdate:strSql];
                [db close];
            }
            
            [ConfigInfo setConfigValue:@"0" key:kAppUserData];
            [ConfigInfo setConfigValue:_userDataVersion key:kAppVersion];//更新版本号
            [_loginViewModel setValue:[NSNumber numberWithInt:LoginSuccess] forKey:@"result"];
        }
        else {
            [_loginViewModel setValue:[NSNumber numberWithInt:LoginErrorDataModify] forKey:@"result"];
        }
    }
}

#pragma mark - ASIHTTPRequestDelegate

- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders
{
    if (_prgSumSize == 0) {
        _prgSumSize = request.contentLength / 1024.0 / 1024.0;
        [_loginViewModel setValue:[NSNumber numberWithFloat:_prgSumSize] forKey:@"prgSumSize"];
    }
}

- (void)setProgress:(float)newProgress
{
    _prgValue = newProgress;
    _prgDownloadSize = _prgSumSize * newProgress;
    [_loginViewModel setValue:[NSNumber numberWithFloat:_prgDownloadSize] forKey:@"prgDownloadSize"];
    [_loginViewModel setValue:[NSNumber numberWithFloat:_prgValue] forKey:@"prgValue"];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [_request clearDelegatesAndCancel];
    _request = nil;
    [_loginViewModel setValue:[NSNumber numberWithInt:LoginInitExpandZip] forKey:@"result"];
    if ([request.username isEqualToString:@"UserData"]) {
        [self performSelector:@selector(unZipUserData) withObject:nil afterDelay:0.1];
    }
    else {
        [self performSelector:@selector(unZipInitData) withObject:nil afterDelay:0.1];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [_request clearDelegatesAndCancel];
    _request = nil;
    [_loginViewModel setValue:[NSNumber numberWithInt:LoginErrorNotNet] forKey:@"result"];
}

#pragma mark - custom function

- (void)deleteInitDataZip
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *path = [paths objectAtIndex:0];
    NSString *zipPath = [path stringByAppendingPathComponent:_initDataZipName];
    NSString *zipTempPath = [path stringByAppendingPathComponent:@"temp"];
    
    //删除数据包以及临时文件夹
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:zipPath error:nil];
    [fileManager removeItemAtPath:zipTempPath error:nil];
}

- (void)deleteUserDataZip
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *path = [paths objectAtIndex:0];
    NSString *zipPath = [path stringByAppendingPathComponent:_userDataZipName];//压缩包路径
    NSString *zipTempPath = [path stringByAppendingPathComponent:@"temp"];//临时文件夹目录
    
    //删除数据包以及临时文件夹
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:zipPath error:nil];
    [fileManager removeItemAtPath:zipTempPath error:nil];
}

//纪录用户信息存储于单件模式内存
- (void)setSharedUserInfoInfo:(BOOL)isFromDatabase
{
    if (isFromDatabase) {
        [UserInfo sharedUserInfo].userName = _userName;
        [UserInfo sharedUserInfo].userPassword = _userPwd;
        _useriPadKey = [self getUseriPadKey:_userName userPwd:_userPwd];
        _userRealName = [self getUserRealName:_userName userPwd:_userPwd];
        _userLevel = [self getUserLevel:_userName userPwd:_userPwd];
        _userArea = [self getUserArea:_userName userPwd:_userPwd];
        [UserInfo sharedUserInfo].useriPadKey = _useriPadKey;
        [UserInfo sharedUserInfo].userRealName = _userRealName;
        [UserInfo sharedUserInfo].userLevel = _userLevel;
        [UserInfo sharedUserInfo].userArea = _userArea;
    }
    else {
        [UserInfo sharedUserInfo].userName = _userName;
        [UserInfo sharedUserInfo].userPassword = _userPwd;
        [UserInfo sharedUserInfo].useriPadKey = _useriPadKey;
        [UserInfo sharedUserInfo].userRealName = _userRealName;
        [UserInfo sharedUserInfo].userLevel = _userLevel;
        [UserInfo sharedUserInfo].userArea = _userArea;
    }
}

//创建下载初始化数据包的临时文件夹
- (void)createTempFolder
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *path = [paths objectAtIndex:0];
    NSString *tempFolderPath = [path stringByAppendingPathComponent:@"temp"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:tempFolderPath])
    {
        [fileManager createDirectoryAtPath:tempFolderPath 
               withIntermediateDirectories:YES 
                                attributes:nil
                                     error:nil];
    }
}

//验证该帐号是否存在登录成功纪录
- (BOOL)isUserSuccessLogin:(NSString *)userName
{
    BOOL rtn = NO;
    NSString *where = [NSString stringWithFormat:@"user_name = '%@' AND login_result = 1 ORDER BY user_login_id DESC", [BaseInfo encrypt:userName]];
    NSArray *array = [client_user_login_dal getList:where];
    if (array.count > 0) {
        rtn = YES;
    }
    else {
        rtn = NO;
    }
    return rtn;
}

//密码是否过期
- (BOOL)isPasswordFailure:(NSString *)userName
{
    BOOL rtn = YES;
    NSString *where = [NSString stringWithFormat:@"user_name = '%@' AND login_result = 1 ORDER BY user_login_id DESC", [BaseInfo encrypt:userName]];
    NSArray *array = [client_user_login_dal getList:where];
    if (array.count > 0) {
        client_user_login *model = [array objectAtIndex:0];
        NSDate *date = [NSDate date];//当前时间
        NSTimeInterval time = [date timeIntervalSinceDate:model.login_time];//秒单位
        int minutes = ((int)time) / 60;
        if (minutes >= [ConfigInfo ServerFailureMinutes]) {
            rtn = YES;
        }
        else {
            rtn = NO;
        }
    }
    else {
        rtn = YES;
    }
    return rtn;
}

//密码是否正确
- (BOOL)isPasswordCorrect:(NSString *)userName userPwd:(NSString *)userPwd
{
    BOOL rtn = NO;
    NSString *where = [NSString stringWithFormat:@"user_name = '%@' AND user_password = '%@' AND login_result = 1 ORDER BY user_login_id DESC", [BaseInfo encrypt:userName], [BaseInfo encrypt:userPwd]];
    NSArray *array = [client_user_login_dal getList:where];
    if (array.count > 0) {
        rtn = YES;
    }
    else {
        rtn = NO;
    }
    return rtn;
}

//添加用户错误登录纪录
- (void)logUserErrorLogin:(NSString *)userName userPwd:(NSString *)userPwd
{
    client_user_login *model = [[client_user_login alloc] init];
    model.user_login_id = [client_user_login_dal getMaxId];
    model.user_name = [BaseInfo encrypt:userName];
    model.user_real_name = [BaseInfo encrypt:@""];
    model.user_level = [BaseInfo encrypt:@""];
    model.user_area = [BaseInfo encrypt:@""];
    model.user_password = [BaseInfo encrypt:userPwd];
    model.ipad_mac_address = [BaseInfo encrypt:[ConfigInfo iPadMacAddress]];
    model.user_ipad_key = [BaseInfo encrypt:@""];
    model.login_time = [NSDate date];
    model.login_result = [NSNumber numberWithBool:NO];
    [client_user_login_dal add:model];
}

//添加用户成功登录纪录
- (void)logUserSuccessLogin:(NSString *)userName userPwd:(NSString *)userPwd useriPadKey:(NSString *)useriPadKey userRealName:(NSString *)userRealName userLevel:(NSString *)userLevel userArea:(NSString *)userArea
{
    //[self clearUserSuccessLogin:userName];
    [self clearUserSuccessLogin];
    
    client_user_login *model = [[client_user_login alloc] init];
    model.user_login_id = [client_user_login_dal getMaxId];
    model.user_name = [BaseInfo encrypt:userName];
    model.user_real_name = [BaseInfo encrypt:userRealName];
    model.user_level = [BaseInfo encrypt:userLevel];
    model.user_area = [BaseInfo encrypt:userArea];
    model.user_password = [BaseInfo encrypt:userPwd];
    model.ipad_mac_address = [BaseInfo encrypt:[ConfigInfo iPadMacAddress]];
    model.user_ipad_key = [BaseInfo encrypt:useriPadKey];
    model.login_time = [NSDate date];
    model.login_result = [NSNumber numberWithBool:YES];
    [client_user_login_dal add:model];
}

//清除所有错误登录纪录
- (void)clearUserErrorLogin
{
    [client_user_login_dal deleteList:[NSString stringWithFormat:@"login_result = 0"]];
}

//清除用户所有成功登录纪录
- (void)clearUserSuccessLogin:(NSString *)userName
{
    [client_user_login_dal deleteList:[NSString stringWithFormat:@"user_name = '%@' AND login_result = 1", [BaseInfo encrypt:userName]]];
}

//清除所有成功登录纪录
- (void)clearUserSuccessLogin
{
    [client_user_login_dal deleteList:[NSString stringWithFormat:@"login_result = 1"]];
}

//根据错误次数统计是否需要锁定系统
- (BOOL)isShouldLock
{ 
    BOOL rtn = YES;
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *localDate = [dateFormatter stringFromDate:date];
    NSString *where = [NSString stringWithFormat:@"date(login_time, 'unixepoch', 'localtime') = '%@' AND login_result = 0 ORDER BY user_login_id DESC", localDate];
    NSArray *array = [client_user_login_dal getList:where];
    if (array.count >= [ConfigInfo ServerErrorNumber]) {
        rtn = YES;
    }
    else {
        rtn = NO;
    }
    return rtn;
}

//删除数据库文件
- (BOOL)deleteDatabaseFile
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:[BaseInfo getDataBasePath] error:nil];
}

//获取离线登录密钥
- (NSString *)getUseriPadKey:(NSString *)userName userPwd:(NSString *)userPwd
{
    NSString *rtn = nil;
    NSString *where = [NSString stringWithFormat:@"user_name = '%@' AND user_password = '%@' AND login_result = 1 ORDER BY user_login_id DESC", [BaseInfo encrypt:userName], [BaseInfo encrypt:userPwd]];
    NSArray *array = [client_user_login_dal getList:where];
    if (array.count > 0) {
        client_user_login *model = (client_user_login *)[array objectAtIndex:0];
        rtn = [BaseInfo decrypt:model.user_ipad_key];
    }
    return rtn;
}

//获取离线登录用户姓名
- (NSString *)getUserRealName:(NSString *)userName userPwd:(NSString *)userPwd
{
    NSString *rtn = nil;
    NSString *where = [NSString stringWithFormat:@"user_name = '%@' AND user_password = '%@' AND login_result = 1 ORDER BY user_login_id DESC", [BaseInfo encrypt:userName], [BaseInfo encrypt:userPwd]];
    NSArray *array = [client_user_login_dal getList:where];
    if (array.count > 0) {
        client_user_login *model = (client_user_login *)[array objectAtIndex:0];
        rtn = [BaseInfo decrypt:model.user_real_name];
    }
    return rtn;
}

//获取离线登录用户级别
- (NSString *)getUserLevel:(NSString *)userName userPwd:(NSString *)userPwd
{
    NSString *rtn = nil;
    NSString *where = [NSString stringWithFormat:@"user_name = '%@' AND user_password = '%@' AND login_result = 1 ORDER BY user_login_id DESC", [BaseInfo encrypt:userName], [BaseInfo encrypt:userPwd]];
    NSArray *array = [client_user_login_dal getList:where];
    if (array.count > 0) {
        client_user_login *model = (client_user_login *)[array objectAtIndex:0];
        rtn = [BaseInfo decrypt:model.user_level];
    }
    return rtn;
}

//获取离线登录用户区域
- (NSString *)getUserArea:(NSString *)userName userPwd:(NSString *)userPwd
{
    NSString *rtn = nil;
    NSString *where = [NSString stringWithFormat:@"user_name = '%@' AND user_password = '%@' AND login_result = 1 ORDER BY user_login_id DESC", [BaseInfo encrypt:userName], [BaseInfo encrypt:userPwd]];
    NSArray *array = [client_user_login_dal getList:where];
    if (array.count > 0) {
        client_user_login *model = (client_user_login *)[array objectAtIndex:0];
        rtn = [BaseInfo decrypt:model.user_area];
    }
    return rtn;
}

//检查用户帐号或者用户级别或者用户区域是否变更
- (void)checkUserData:(NSString *)userName userLevel:(NSString *)userLevel userArea:(NSString *)userArea
{
    //1.检查数据库中是否存在登陆成功的纪录
    NSString *where = [NSString stringWithFormat:@"login_result = 1 ORDER BY user_login_id DESC"];
    NSArray *array = [client_user_login_dal getList:where];
    if (array.count <= 0) {
        return;
    }
    client_user_login *model = [array objectAtIndex:0];
    
    //2.对比该帐号与登录的帐号是否相同
    if (![model.user_name isEqualToString:[BaseInfo encrypt:userName]]) {
        [ConfigInfo setConfigValue:@"1" key:kAppUserData];
        return;
    }
    
    //3.对比该帐号与登录的帐号的级别是否相同
    if (![model.user_level isEqualToString:[BaseInfo encrypt:userLevel]]) {
        [ConfigInfo setConfigValue:@"1" key:kAppUserData];
        return;
    }

    //4.对比该帐号与登录的帐号的区域是否相同
    if (![model.user_area isEqualToString:[BaseInfo encrypt:userArea]]) {
        [ConfigInfo setConfigValue:@"1" key:kAppUserData];
        return;
    }
}

@end
