//
//  IndexViewModel.h
//  HigerVise
//
//  Created by Kevin.Mao on 12-10-12.
//  Copyright (c) 2012年 JijeSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    IndexLoadSuccess                = 1001,     //数据加载成功
    IndexUpdateSuccess              = 1002,     //数据更新成功
    IndexUpdateNewest               = 1003,     //暂无更新数据
    IndexUpdateDownload             = 1004,     //正在下载数据
    IndexUpdateExpandZip            = 1005,     //正在解压数据
    IndexUpdateModifyData           = 1006,     //正在更新数据
    
    IndexLoadClassSuccess           = 1007,     //数据加载成功 车型分类
    IndexLoadUserSuccess            = 1008,     //数据加载成功 用户收藏
    IndexLoadHisSuccess             = 1009,     //数据加载成功 历史版本（我的报价单）
    IndexLoadHotSuccess             = 1010,     //数据加载成功 热点推荐
    
    IndexUpdateErrorNotNet          = 1101,     //系统网络异常
    IndexUpdateErrorUserKey         = 1102,     //帐号交互密钥错误
    IndexUpdateErrorExpandZip       = 1103,     //数据解压失败
    IndexUpdateErrorModifyData      = 1104,     //数据更新失败
    
} IndexResult;

@interface IndexViewModel : NSObject

@property (strong, nonatomic) NSNumber *result;
@property (strong, nonatomic) NSArray *vehicleClasses;
@property (strong, nonatomic) NSArray *vehicleUsers;
@property (strong, nonatomic) NSArray *vehicleHots;
@property (strong, nonatomic) NSArray *vehicleHises;

@property (strong, nonatomic) NSNumber *prgSumSize;
@property (strong, nonatomic) NSNumber *prgDownloadSize;
@property (strong, nonatomic) NSNumber *prgValue;

@property (strong, nonatomic) NSString *updateDesc;//更新描述

@end
