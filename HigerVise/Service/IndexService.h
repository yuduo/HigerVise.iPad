//
//  IndexService.h
//  HigerVise
//
//  Created by Kevin.Mao on 12-10-12.
//  Copyright (c) 2012年 JijeSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ZipArchive.h"
#import "BaseInfo.h"
#import "ConfigInfo.h"
#import "UserInfo.h"
#import "IndexViewModel.h"
#import "DataService.h"
#import "PriceTableViewModel.h"
#import "MDBufferedInputStream.h"

static NSString *kUpdateTextName = @"sql.txt";

@interface IndexService : NSObject<ASIHTTPRequestDelegate>
{
    IndexViewModel *_indexViewModel;
    DataService *_dataService;
    NSString *_serverVersion;
    
    ASIHTTPRequest *_request;
    float _prgSumSize;
    float _prgDownloadSize;
    float _prgValue;
    NSString *_updateZipName;
    NSString *_updateZipTempName;
    BOOL _isDownloadInitZip;
}

- (id)initWithViewModel:(IndexViewModel *)indexViewModel;
- (void)requestUpdateData;
- (void)loadData;
- (void)loadClassData;
- (void)loadUserData;
- (void)loadHisData;
- (void)loadHotData;

- (client_vehicle_configurator *)loadHisVehicleData:(NSNumber *)vehicleConfiguratorId;
- (client_vehicle_edition_his *)loadHisEditionData:(NSNumber *)hisEditionIndex;

@end
