//
//  IndexService.m
//  HigerVise
//
//  Created by Kevin.Mao on 12-10-12.
//  Copyright (c) 2012年 JijeSoft. All rights reserved.
//

#import "IndexService.h"

@implementation IndexService

- (id)initWithViewModel:(IndexViewModel *)indexViewModel
{
    self = [super init];
    if (self) {
        _indexViewModel = indexViewModel;
        _dataService = [[DataService alloc] init];
    }
    return self;
}

- (void)dealloc
{
    _indexViewModel = nil;
    _dataService = nil;
    
    if (_request) {
        [_request clearDelegatesAndCancel];
        _request = nil;
    }
    
    _serverVersion = nil;
    _updateZipName = nil;
    _updateZipTempName = nil;
}

#pragma mark - requestUpdateData progress

//请求更新数据
- (void)requestUpdateData
{
    _isDownloadInitZip = NO;
    
    NSDictionary *data = [_dataService requestUpdateData:[ConfigInfo AppVersion] 
                                                userName:[UserInfo sharedUserInfo].userName 
                                          iPadMacAddress:[ConfigInfo iPadMacAddress] 
                                             useriPadKey:[UserInfo sharedUserInfo].useriPadKey];
    if (data) {
        NSString *code = [data objectForKey:@"Code"];
        NSString *url = [BaseInfo decrypt:[data objectForKey:@"Url"]];
        _serverVersion = [data objectForKey:@"Version"];
        
        if ([code isEqualToString:@"1001"]) {
            if ((url == nil) || [url isEqualToString:@""]) {
                [_indexViewModel setValue:[NSNumber numberWithInt:IndexUpdateErrorNotNet] forKey:@"result"];
            }
            else {
                [_indexViewModel setValue:[NSNumber numberWithInt:IndexUpdateDownload] forKey:@"result"];
                [self performSelector:@selector(requestDownloadData:) withObject:url afterDelay:0.1];
            }
            return;
        }//下载更新包
        if ([code isEqualToString:@"1002"]) {
            [_indexViewModel setValue:[NSNumber numberWithInt:IndexUpdateNewest] forKey:@"result"];
            return;
        }//数据已经最新
        if ([code isEqualToString:@"1003"]) {
            if ((url == nil) || [url isEqualToString:@""]) {
                [_indexViewModel setValue:[NSNumber numberWithInt:IndexUpdateErrorNotNet] forKey:@"result"];
            }
            else {
                _isDownloadInitZip = YES;
                [_indexViewModel setValue:[NSNumber numberWithInt:IndexUpdateDownload] forKey:@"result"];
                [self performSelector:@selector(requestDownloadData:) withObject:url afterDelay:0.1];
            }
            return;
        }//下载初始化包
        if ([code isEqualToString:@"1011"]) {
            [_indexViewModel setValue:[NSNumber numberWithInt:IndexUpdateErrorUserKey] forKey:@"result"];
            return;
        }//异常错误
        
        [_indexViewModel setValue:[NSNumber numberWithInt:IndexUpdateErrorNotNet] forKey:@"result"];
        return;
    }
    else {
        [_indexViewModel setValue:[NSNumber numberWithInt:IndexUpdateErrorNotNet] forKey:@"result"];
        return;
    }
}

//下载更新数据
- (void)requestDownloadData:(NSString *)url
{
    [self createTempFolder];//创建断点续传临时文件夹
    
    _prgSumSize = 0.0;
    _prgDownloadSize = 0.0;
    _prgValue = 0.0;
    
    NSArray *urls = [url pathComponents];
    _updateZipName = [urls objectAtIndex:(urls.count - 1)];
    _updateZipTempName = [NSString stringWithFormat:@"temp/%@.temp", _updateZipName];
    
    //下载数据初始化包
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *path = [paths objectAtIndex:0];
    NSString *savePath = [path stringByAppendingPathComponent:_updateZipName];
    NSString *tempPath = [path stringByAppendingPathComponent:_updateZipTempName];
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
    [_request setTimeOutSeconds:[BaseInfo getTimeOutSeconds]];
    [_request setDownloadDestinationPath:savePath];
    [_request setTemporaryFileDownloadPath:tempPath];
    [_request setAllowResumeForFileDownloads:YES];
    [_request startAsynchronous];
}

//解压更新数据
- (void)unZipUpdateData
{
    ZipArchive *zip = [[ZipArchive alloc] init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *path = [paths objectAtIndex:0];
    NSString *imagePath = [path stringByAppendingPathComponent:@"images"];
    NSString *zipPath = [path stringByAppendingPathComponent:_updateZipName];
    //NSString *zipTempPath = [path stringByAppendingPathComponent:@"temp"];
    NSString *zipUnPath = path;
    
    //解压数据
    if([zip UnzipOpenFile:zipPath])
    {
        BOOL result = [zip UnzipFileTo:zipUnPath overWrite:YES];
        if (!result) {
            [zip UnzipCloseFile];
            [_indexViewModel setValue:[NSNumber numberWithInt:IndexUpdateErrorExpandZip] forKey:@"result"];
            [self deleteUpdateDataZip];
            return;
        }
        [zip UnzipCloseFile];
    }
    else {
        [_indexViewModel setValue:[NSNumber numberWithInt:IndexUpdateErrorExpandZip] forKey:@"result"];
        [self deleteUpdateDataZip];
        return;
    }
    
    //不同步至iCloud
    [BaseInfo addSkipBackupAttributeToItemAtURL:[[NSURL alloc] initWithString:imagePath]];
    
    //删除数据包以及临时文件夹
    [self deleteUpdateDataZip];
    
    [_indexViewModel setValue:[NSNumber numberWithInt:IndexUpdateModifyData] forKey:@"result"];
    [self performSelector:@selector(modifyUpdateData) withObject:nil afterDelay:0.1];
}

//根据文本内容修改更新数据
- (void)modifyUpdateData
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *path = [paths objectAtIndex:0];
    path = [path stringByAppendingPathComponent:kUpdateTextName];

    if (![fileManager fileExistsAtPath:path]) {
        if (!_isDownloadInitZip) {
            [_indexViewModel setValue:[NSNumber numberWithInt:IndexUpdateErrorModifyData] forKey:@"result"];
        }//下载更新包
        else {
            //删除所有非该用户数据
            [BaseInfo clearDataByUserName:[UserInfo sharedUserInfo].userName userLevel:[UserInfo sharedUserInfo].userLevel userArea:[UserInfo sharedUserInfo].userArea];
            
            //获取更新提示信息
            NSString *versionWhere = [NSString stringWithFormat:@"data_version > %@", [ConfigInfo AppVersion]];
            NSArray *versionArray = [client_system_version_dal getListForIndex:versionWhere];
            NSString *versionMessage = @"";
            NSString *versionGroup = @"";
            int tempVersion = -1;
            for (client_system_version *versionModel in versionArray) {
                if (![versionModel.version_desc isEqualToString:@""]) {
                    
                    //获取版本分组数据
                    int currentVersion = [versionModel.system_version intValue];
                    if (tempVersion != currentVersion) {
                        tempVersion = currentVersion;
                        versionGroup = [NSString stringWithFormat:@"更新版本号：%d\r\n", currentVersion];
                        versionMessage = [versionMessage stringByAppendingString:versionGroup];
                    }
                    
                    //获取每个版本的描述信息
                    NSString *versionDesc = [NSString stringWithFormat:@"%@\r\n%@\r\n\r\n", versionModel.vehicle_code, versionModel.version_desc];
                    versionMessage = [versionMessage stringByAppendingString:versionDesc];
                }
            }
            _indexViewModel.updateDesc = versionMessage;
            
            //更新相关配置
            [ConfigInfo setConfigValue:_serverVersion key:kAppVersion];//更新版本号
            [self performSelector:@selector(loadData) withObject:nil afterDelay:0.1];//重新加载所有数据
            [_indexViewModel setValue:[NSNumber numberWithInt:IndexUpdateSuccess] forKey:@"result"];
        }//下载初始化包
    }//文件不存在(sql.txt)
    else {
        
        //设置文件编码方式
        NSStringEncoding stringEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSString *stringData = [[NSString alloc] initWithContentsOfFile:path encoding:stringEncoding error:nil];
        NSArray *array = [stringData componentsSeparatedByString:@"\r\n"];
        stringData = nil;
     //  NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
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
        db = nil;
        
        array = nil;
        
        //执行删除相关脚本
        [fileManager removeItemAtPath:path error:nil];//删除脚本文件
        
        //判断是否执行成功
        if (!isRollback) {
            //删除所有非该用户数据
            [BaseInfo clearDataByUserName:[UserInfo sharedUserInfo].userName userLevel:[UserInfo sharedUserInfo].userLevel userArea:[UserInfo sharedUserInfo].userArea];
            
            NSString *versionWhere = [NSString stringWithFormat:@"data_version > %@", [ConfigInfo AppVersion]];
            NSArray *versionArray = [client_system_version_dal getListForIndex:versionWhere];
            NSString *versionMessage = @"";
            NSString *editionWhere = @"";
            NSString *versionGroup = @"";
            int tempVersion = -1;
            for (client_system_version *versionModel in versionArray) {
                if (![versionModel.version_desc isEqualToString:@""]) {
                    
                    //获取版本分组数据
                    int currentVersion = [versionModel.system_version intValue];
                    if (tempVersion != currentVersion) {
                        tempVersion = currentVersion;
                        versionGroup = [NSString stringWithFormat:@"更新版本号：%d\r\n", currentVersion];
                        versionMessage = [versionMessage stringByAppendingString:versionGroup];
                    }
                    
                    //获取每个版本的描述信息
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
            _indexViewModel.updateDesc = versionMessage;
            
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

            [ConfigInfo setConfigValue:_serverVersion key:kAppVersion];//更新版本号
            [self performSelector:@selector(loadData) withObject:nil afterDelay:0.1];//重新加载所有数据
            [_indexViewModel setValue:[NSNumber numberWithInt:IndexUpdateSuccess] forKey:@"result"];
        }
        else {
            [_indexViewModel setValue:[NSNumber numberWithInt:IndexUpdateErrorModifyData] forKey:@"result"];
        }
    }
}

- (void)deleteUpdateDataZip
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *path = [paths objectAtIndex:0];
    NSString *zipPath = [path stringByAppendingPathComponent:_updateZipName];
    NSString *zipTempPath = [path stringByAppendingPathComponent:@"temp"];
    
    //删除数据包以及临时文件夹
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:zipPath error:nil];
    [fileManager removeItemAtPath:zipTempPath error:nil];
}

#pragma mark - load data

//加载数据
- (void)loadData
{
    NSArray *vehicleClasses = [client_vehicle_class_dal getList:@"1=1" order:@"vehicle_class_id ASC"];
    for (int i = 0; i < vehicleClasses.count; i++) {
        client_vehicle_class *vehicleClasse = [vehicleClasses objectAtIndex:i];
        NSArray *images = [client_image_dal getList:[NSString stringWithFormat:@"image_type=1001 AND reference_id='%d'", [vehicleClasse.vehicle_class_id intValue]]];
        if (images.count > 0) {
            client_image *image = [images objectAtIndex:0];
            vehicleClasse.image_url = [BaseInfo getImageFullPath:image.image_url];
        }
        else {
            vehicleClasse.image_url = [BaseInfo getImageFullPath:@""];
        }
    }
    _indexViewModel.vehicleClasses = vehicleClasses;

    NSArray *vehicleUsers = [client_vehicle_configurator_dal getListForIndex:@"vehicle_configurator_id IN (SELECT client_user_vehicle_relation.vehicle_configurator_id FROM client_user_vehicle_relation)"];
    for (int i = 0; i <vehicleUsers.count; i++) {
        client_vehicle_configurator *vehicle = [vehicleUsers objectAtIndex:i];
        NSArray *images = [client_image_dal getList:[NSString stringWithFormat:@"image_type=1002 AND reference_id='%@'", vehicle.vehicle_code]];
        if (images.count > 0) {
            client_image *image = [images objectAtIndex:0];
            vehicle.image_url = [BaseInfo getImageFullPath:image.image_url];
            vehicle.image_data_version = image.data_version;
        }
        else {
            vehicle.image_url = [BaseInfo getImageFullPath:@""];
            vehicle.image_data_version = [NSNumber numberWithInt:0];
        }
    }
    _indexViewModel.vehicleUsers = vehicleUsers;
    
    NSArray *vehicleHots = [client_vehicle_configurator_dal getListForIndex:@"vehicle_configurator_id IN (SELECT client_vehicle_hot.vehicle_configurator_id FROM client_vehicle_hot)"];
    for (int i = 0; i <vehicleHots.count; i++) {
        client_vehicle_configurator *vehicle = [vehicleHots objectAtIndex:i];
        NSArray *images = [client_image_dal getList:[NSString stringWithFormat:@"image_type=1002 AND reference_id='%@'", vehicle.vehicle_code]];
        if (images.count > 0) {
            client_image *image = [images objectAtIndex:0];
            vehicle.image_url = [BaseInfo getImageFullPath:image.image_url];
            vehicle.image_data_version = image.data_version;
        }
        else {
            vehicle.image_url = [BaseInfo getImageFullPath:@""];
            vehicle.image_data_version = [NSNumber numberWithInt:0];
        }
    }
    _indexViewModel.vehicleHots = vehicleHots;
    
    NSArray *vehicleHises = [client_vehicle_edition_his_dal getListForIndex:@"1=1" order:@"update_time DESC" top:20];
    _indexViewModel.vehicleHises = vehicleHises;
    
    [_indexViewModel setValue:[NSNumber numberWithInt:IndexLoadSuccess] forKey:@"result"];
}

- (void)loadClassData
{
    NSArray *vehicleClasses = [client_vehicle_class_dal getList:@"1=1" order:@"vehicle_class_id ASC"];
    for (int i = 0; i < vehicleClasses.count; i++) {
        client_vehicle_class *vehicleClasse = [vehicleClasses objectAtIndex:i];
        NSArray *images = [client_image_dal getList:[NSString stringWithFormat:@"image_type=1001 AND reference_id='%d'", [vehicleClasse.vehicle_class_id intValue]]];
        if (images.count > 0) {
            client_image *image = [images objectAtIndex:0];
            vehicleClasse.image_url = [BaseInfo getImageFullPath:image.image_url];
        }
        else {
            vehicleClasse.image_url = [BaseInfo getImageFullPath:@""];
        }
    }
    _indexViewModel.vehicleClasses = vehicleClasses;
    
    [_indexViewModel setValue:[NSNumber numberWithInt:IndexLoadClassSuccess] forKey:@"result"]; 
}

- (void)loadUserData
{
    NSArray *vehicleUsers = [client_vehicle_configurator_dal getListForIndex:@"vehicle_configurator_id IN (SELECT client_user_vehicle_relation.vehicle_configurator_id FROM client_user_vehicle_relation)"];
    for (int i = 0; i <vehicleUsers.count; i++) {
        client_vehicle_configurator *vehicle = [vehicleUsers objectAtIndex:i];
        NSArray *images = [client_image_dal getList:[NSString stringWithFormat:@"image_type=1002 AND reference_id='%@'", vehicle.vehicle_code]];
        if (images.count > 0) {
            client_image *image = [images objectAtIndex:0];
            vehicle.image_url = [BaseInfo getImageFullPath:image.image_url];
            vehicle.image_data_version = image.data_version;
        }
        else {
            vehicle.image_url = [BaseInfo getImageFullPath:@""];
            vehicle.image_data_version = [NSNumber numberWithInt:0];
        }
    }
    _indexViewModel.vehicleUsers = vehicleUsers;
    
    [_indexViewModel setValue:[NSNumber numberWithInt:IndexLoadUserSuccess] forKey:@"result"];
}

- (void)loadHisData
{
    NSArray *vehicleHises = [client_vehicle_edition_his_dal getListForIndex:@"1=1" order:@"update_time DESC" top:20];
    _indexViewModel.vehicleHises = vehicleHises;
    
     [_indexViewModel setValue:[NSNumber numberWithInt:IndexLoadHisSuccess] forKey:@"result"];
}

- (void)loadHotData
{
    NSArray *vehicleHots = [client_vehicle_configurator_dal getListForIndex:@"vehicle_configurator_id IN (SELECT client_vehicle_hot.vehicle_configurator_id FROM client_vehicle_hot)"];
    for (int i = 0; i <vehicleHots.count; i++) {
        client_vehicle_configurator *vehicle = [vehicleHots objectAtIndex:i];
        NSArray *images = [client_image_dal getList:[NSString stringWithFormat:@"image_type=1002 AND reference_id='%@'", vehicle.vehicle_code]];
        if (images.count > 0) {
            client_image *image = [images objectAtIndex:0];
            vehicle.image_url = [BaseInfo getImageFullPath:image.image_url];
            vehicle.image_data_version = image.data_version;
        }
        else {
            vehicle.image_url = [BaseInfo getImageFullPath:@""];
            vehicle.image_data_version = [NSNumber numberWithInt:0];
        }
    }
    _indexViewModel.vehicleHots = vehicleHots;
    
    [_indexViewModel setValue:[NSNumber numberWithInt:IndexLoadHotSuccess] forKey:@"result"];
}

- (client_vehicle_configurator *)loadHisVehicleData:(NSNumber *)vehicleConfiguratorId
{
    client_vehicle_configurator *vehicle = [client_vehicle_configurator_dal getForPirceTable:vehicleConfiguratorId];
    NSArray *images = [client_image_dal getList:[NSString stringWithFormat:@"image_type=1002 AND reference_id='%@'", vehicle.vehicle_code]];
    if (images.count > 0) {
        client_image *image = [images objectAtIndex:0];
        vehicle.image_url = [BaseInfo getImageFullPath:image.image_url];
        vehicle.image_data_version = image.data_version;
    }
    else {
        vehicle.image_url = [BaseInfo getImageFullPath:@""];
        vehicle.image_data_version = [NSNumber numberWithInt:0];
    }
    return vehicle;
}

//90:非标配（永远不显示）
//100:标配（永远不显示）
- (client_vehicle_edition_his *)loadHisEditionData:(NSNumber *)hisEditionIndex
{
    NSLog(@"editions 0 Start");
    client_vehicle_edition_his *model = [_indexViewModel.vehicleHises objectAtIndex:[hisEditionIndex intValue]];
    
    model.all_settings = [[NSMutableArray alloc] init];
    model.dp_settings = [[NSMutableArray alloc] init];
    model.cs_settings = [[NSMutableArray alloc] init];
    model.op_settings = [[NSMutableArray alloc] init];
    model.bp_settings = [[NSMutableArray alloc] init];
    model.pc_settings = [[NSMutableArray alloc] init];
    model.sql_list = [[NSMutableArray alloc] init];
    
    model.all_settings = [[client_vehicle_edition_setting_his_dal getListForPriceTable:[NSString stringWithFormat:@"vehicle_edition_id = %d", [model.vehicle_edition_id intValue]]] mutableCopy];
    NSLog(@"editions 0 End");
    
    NSLog(@"editions 1 Start");
    for (int i = 0; i < model.all_settings.count; i++) {
        client_vehicle_edition_setting_his *setting = [model.all_settings objectAtIndex:i];
        if ([setting.sale_group_code isEqualToString:@"1001"]) {
            if ([setting.is_selected intValue] == 1) {
                [model.dp_settings addObject:[setting copy]];
            }
        }
        
        if ([setting.sale_group_code isEqualToString:@"1002"]) {
            if ([setting.is_selected intValue] == 1) {
                [model.cs_settings addObject:[setting copy]];
            }
        }
        
        if ([setting.is_displayed_config intValue] == 1) {
            if ([setting.op_value_level_code intValue] == 20 || 
                [setting.op_value_level_code intValue] == 30) {
                [model.op_settings addObject:[setting copy]];
            }
            if ([setting.op_value_level_code intValue] == kSettingAddBpLevel || 
                [setting.op_value_level_code intValue] == kSettingAddXpLevel) {
                [model.op_settings addObject:[setting copy]];
            }//自定义配件
        }
        
        if ([setting.op_value_level_code intValue] == 10 || 
            [setting.op_value_level_code intValue] == 100) {
            [model.bp_settings addObject:[setting copy]];
        }
    }
    NSLog(@"editions 1 End");
    
//    model.dp_settings = [[client_vehicle_edition_setting_his_dal getListForPriceTable:[NSString stringWithFormat:@"vehicle_edition_id = %d AND sale_group_code = '1001' AND is_selected = 1", [model.vehicle_edition_id intValue]]] mutableCopy];
//    model.cs_settings = [[client_vehicle_edition_setting_his_dal getListForPriceTable:[NSString stringWithFormat:@"vehicle_edition_id = %d AND sale_group_code = '1002' AND is_selected = 1", [model.vehicle_edition_id intValue]]] mutableCopy];
//    model.op_settings = [[client_vehicle_edition_setting_his_dal getListForPriceTable:[NSString stringWithFormat:@"vehicle_edition_id = %d AND is_displayed_config = 1", [model.vehicle_edition_id intValue]]] mutableCopy];
//    model.bp_settings = [[client_vehicle_edition_setting_his_dal getListForPriceTable:[NSString stringWithFormat:@"vehicle_edition_id = %d AND op_value_level_code = 10", [model.vehicle_edition_id intValue]]] mutableCopy];
    
    return model;
}

#pragma mark - ASIHTTPRequestDelegate

- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders
{
    if (_prgSumSize == 0) {
        _prgSumSize = request.contentLength / 1024.0 / 1024.0;
        [_indexViewModel setValue:[NSNumber numberWithFloat:_prgSumSize] forKey:@"prgSumSize"];
    }
}

- (void)setProgress:(float)newProgress
{
    _prgValue = newProgress;
    _prgDownloadSize = _prgSumSize * newProgress;
    [_indexViewModel setValue:[NSNumber numberWithFloat:_prgDownloadSize] forKey:@"prgDownloadSize"];
    [_indexViewModel setValue:[NSNumber numberWithFloat:_prgValue] forKey:@"prgValue"];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [_request clearDelegatesAndCancel];
    _request = nil;
    [_indexViewModel setValue:[NSNumber numberWithInt:IndexUpdateExpandZip] forKey:@"result"];
    [self performSelector:@selector(unZipUpdateData) withObject:nil afterDelay:0.1];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [_request clearDelegatesAndCancel];
    _request = nil;
    [_indexViewModel setValue:[NSNumber numberWithInt:IndexUpdateErrorNotNet] forKey:@"result"];
}

#pragma mark - private method

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

@end
