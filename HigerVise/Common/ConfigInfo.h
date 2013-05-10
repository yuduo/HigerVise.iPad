//
//  ConfigInfo.h
//  HigerVise
//
//  Created by Kevin.Mao on 12-10-12.
//  Copyright (c) 2012年 JijeSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sys/socket.h>
#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>
#import "BaseInfo.h"

static NSString *kAppConfigPlist        = @"app.config.plist";
static NSString *kAppStatus             = @"AppStatus";
static NSString *kAppTimeOut            = @"AppTimeOut";            //应用程序切换至后台时间点
static NSString *kAppVersion            = @"AppVersion";            //数据版本号
static NSString *kAppVersionInit        = @"1";
static NSString *kAppLastUpdate         = @"AppLastUpdate";         //应用程序最后更新时间
static NSString *kAppLastUpdateInit     = @"2012-01-01";
static NSString *kAppUserData           = @"AppUserData";           //是否需要重新加载用户数据
static NSString *kAppUserDataInit       = @"0";                     //是否需要重新加载用户数据，默认否
static NSString *kAppLastLoginUserName  = @"AppLastLoginUserName";  //最后一次登录用户帐号
enum AppStatus
{
    kAppStatusNormal                    = 1001,     //正常状态
    kAppStatusInit                      = 1002      //初始化状态
};


static NSString *kiPadStatus            = @"iPadStatus";
static NSString *kiPadName              = @"iPadName";
static NSString *kiPadMacAddress        = @"iPadMacAddress";
static NSString *kiPadUUID              = @"iPadUUID";
static NSString *kiPadDeviceToken       = @"iPadDeviceToken";
static NSString *kiPadUserName          = @"iPadUserName";      //请求下载资源的帐号
static NSString *kiPadPassword          = @"iPadPassword";      //请求下载资源的密码
static NSString *kiPadDefaultUserName   = @"ehiger\\viseshare"; //请求下载资源的帐号（默认）
static NSString *kiPadDefaultPassword   = @"Vise@123";          //请求下载资源的密码（默认）
enum iPadStatus 
{
    kiPadStatusNormal                   = 1001,     //正常状态
    kiPadStatusLock                     = 1002      //锁定状态
};


static NSString *kServerErrorNumber     = @"ServerErrorNumber";
static NSString *kServerFailureMinutes  = @"ServerFailureMinutes";
static NSString *kServerLockMinutes     = @"ServerLockMinutes";
static NSString *kServerLoginKey        = @"ServerLoginKey";
static NSString *kServerDefaultLoginKey = @"D2CC93BDB554F70F";
static NSString *kServerVersion         = @"ServerVersion";
enum ServerDefault
{
    kServerDefaultErrorNumber           = 5,        //密码错误锁定次数    默认
    kServerDefaultFailureMinutes        = 2880,     //密码失效时长  分钟  默认
    kServerDefaultLockMinutes           = 15,       //系统锁定时长  分钟  默认
    kServerDefaultVersion               = 1         //服务器端最新数据版本 默认
};

static NSString *kShowPriceEditBtn          = @"ShowPriceEditBtn";          //显示编辑按钮

static NSString *kShowIndexEdition          = @"ShowIndexEdition";          //显示报价单价格(首页)
static NSString *kShowPriceEdition          = @"ShowPriceEdition";          //显示报价单价格(价格表) --新增

static NSString *kShowEditionOriginal       = @"ShowEditionOriginal";       //显示版本原有售价(查看) --取消
static NSString *kShowEditionOriginalEdit   = @"ShowEditionOriginalEdit";   //显示版本原有售价(编辑) --取消

static NSString *kShowEditionSale           = @"ShowEditionSale";           //显示版本统一售价(查看) --新增
static NSString *kShowEditionSaleEdit       = @"ShowEditionSaleEdit";       //显示版本统一售价(编辑) --新增

static NSString *kShowEditionDel            = @"ShowEditionDel";            //显示版本选装合计(查看) --新增
static NSString *kShowEditionDelEdit        = @"ShowEditionDelEdit";        //显示版本选装合计(编辑) --新增

static NSString *kShowEditionCustomer       = @"ShowEditionCustomer";       //显示版本优惠价(查看) --新增
static NSString *kShowEditionCustomerEdit   = @"ShowEditionCustomerEdit";   //显示版本优惠价(编辑) --新增

static NSString *kShowSettingStandard       = @"ShowSettingStandard";       //显示标准配置价格(查看)
static NSString *kShowSettingStandardEdit   = @"ShowSettingStandardEdit";   //显示标准配置价格(编辑)

static NSString *kShowSettingOptional       = @"ShowSettingOptional";       //显示置换配置价格(查看)
static NSString *kShowSettingOptionalEdit   = @"ShowSettingOptionalEdit";   //显示置换配置价格(编辑)

static NSString *kShowOptional              = @"ShowOptional";              //显示选装配置价格(查看)
static NSString *kShowOptionalEdit          = @"ShowOptionalEdit";          //显示选装配置价格(编辑)

static NSString *kHelpIndex                 = @"HelpIndex";                 //是否显示首页帮助
static NSString *kHelpSearch                = @"HelpSearch";                //是否显示搜索帮助
static NSString *kHelpPriceTable            = @"HelpPriceTable";            //是否显示价格表帮助
static NSString *kHelpCarColor              = @"HelpCarColor";              //是否显示车型图表浏览帮助

@interface ConfigInfo : NSObject

+ (NSInteger)AppStatus;
+ (NSDate *)AppTimeOut;
+ (NSString *)AppVersion;
+ (BOOL)AppHasLastUpdate;
+ (BOOL)AppHasUserData;
+ (NSString *)AppLastLoginUserName;


+ (NSInteger)iPadStatus;
+ (NSString *)iPadName;
+ (NSString *)iPadMacAddress;
+ (NSString *)iPadUUID;
+ (NSString *)iPadDeviceToken;
+ (NSString *)iPadUserName;
+ (NSString *)iPadPassword;


+ (NSInteger)ServerErrorNumber;
+ (NSInteger)ServerFailureMinutes;
+ (NSInteger)ServerLockMinutes;
+ (NSString *)ServerLoginKey;
+ (NSInteger)ServerVersion;

+ (BOOL)ShowPriceEditBtn;

+ (BOOL)ShowIndexEdition;
+ (BOOL)ShowPriceEdition;

+ (BOOL)ShowEditionOriginal;
+ (BOOL)ShowEditionOriginalEdit;

+ (BOOL)ShowEditionSale;
+ (BOOL)ShowEditionSaleEdit;

+ (BOOL)ShowEditionDel;
+ (BOOL)ShowEditionDelEdit;

+ (BOOL)ShowEditionCustomer;
+ (BOOL)ShowEditionCustomerEdit;

+ (BOOL)ShowSettingStandard;
+ (BOOL)ShowSettingStandardEdit;

+ (BOOL)ShowSettingOptional;
+ (BOOL)ShowSettingOptionalEdit;

+ (BOOL)ShowOptional;
+ (BOOL)ShowOptionalEdit;

+ (BOOL)HelpIndex;
+ (BOOL)HelpSearch;
+ (BOOL)HelpPriceTable;
+ (BOOL)HelpCarColor;

+ (NSString *)getConfigValue:(NSString *)key;
+ (BOOL)setConfigValue:(NSString *)value key:(NSString *)key;

@end
