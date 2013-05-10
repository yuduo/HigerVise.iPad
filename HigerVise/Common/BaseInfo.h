#import <Foundation/Foundation.h>
#import "client_search_option_dal.h"
#import "client_search_option_relation_dal.h"
#import "client_search_option_setting_relation_dal.h"
#import "client_system_log_dal.h"
#import "client_user_vehicle_relation_dal.h"
#import "client_user_edition_relation_dal.h"
#import "client_user_login_dal.h"
#import "client_user_vehicle_log_dal.h"
#import "client_vehicle_class_dal.h"
#import "client_vehicle_configurator_dal.h"
#import "client_vehicle_edition_dal.h"
#import "client_vehicle_edition_his_dal.h"
#import "client_vehicle_hot_dal.h"
#import "client_vehicle_edition_setting_dal.h"
#import "client_vehicle_edition_setting_his_dal.h"
#import "client_vehicle_setting_relation_dal.h"
#import "client_system_version_dal.h"
#import "client_image_dal.h"
#import "client_search_dal.h"
#import "Reachability.h"
#import "StringEncryption.h"
#import <QuartzCore/QuartzCore.h>
#import <sys/xattr.h>
#import "UserInfo.h"
#import "ConfigInfo.h"

#define kSearchResultPageSize   20
#define kNumbers                @"0123456789\n"
#define kNumbersFlags           @"+-0123456789\n"

static NSString *kHigerViseClientOffLine = @"jijesoft";
static NSString *kHigerDatabaseOffLine   = @"HigerViseClientOffLine.db";    //数据库文件名称

static NSString *kVehiclePromptCodes    = @"KLQ";   //汽车编码搜索范围

static NSString *kHigerEncryptKey       = @"7CFC139FE446FDF5";      //加密解密密钥
static NSString *kHigerDatabase         = @"HigerViseClient.db";    //数据库文件名称

static NSString *kHigerNetworkTest      = @"http://mobileservice.ehiger.com:81/HigerViseWebServices/HigerViseWebService.asmx";
static NSString *kHigerUrlBase          = @"http://mobileservice.ehiger.com:81/HigerViseWebServices/HigerViseWebService.asmx/";

//static NSString *kHigerNetworkTest      = @"http://hjjt.jijesoft.com:2881/HigerViseWebService.asmx";
//static NSString *kHigerUrlBase          = @"http://hjjt.jijesoft.com:2881/HigerViseWebService.asmx/";
//static NSString *kHigerUrlBaseTwo       = @"http://172.27.58.142:8081/HigerViseWebService.asmx/";
//static NSString *kHigerUrlBaseThree       = @"http://172.27.58.142:8081/HigerViseWebService.asmx";
static NSString *kHigerUrlBaseTwo       = @"http://mobileservice.ehiger.com:81/HigerViseWebServices/HigerViseWebService.asmx/";
static NSString *kHigerUrlBaseThree       = @"http://mobileservice.ehiger.com:81/HigerViseWebServices/HigerViseWebService.asmx/";

//static NSString *kHigerNetworkTest      = @"http://172.27.56.103:8080/HigerViseWebService.asmx";
//static NSString *kHigerUrlBase          = @"http://172.27.56.103:8080/HigerViseWebService.asmx/";

typedef enum
{
    SqlTypeSettingChanged               = 1000,
} SqlType;

@interface BaseInfo : NSObject

//数据库版本更新
+ (BOOL)updateSqliteDatabase;

//日志相关
+ (BOOL)addSystemLog:(NSString *)log_module
       log_operation:(NSString *)log_operation 
         log_message:(NSString *)log_message 
           log_error:(NSString *)log_error;
+ (BOOL)addVehicleLog:(NSNumber *)vehicle_configurator_id 
         vehicle_code:(NSString *)vehicle_code;


//数据库相关
+ (NSString *)getDataBasePath;
+ (BOOL)isExistenceDatabase;
+ (BOOL)isDebug;
+ (void)clearDataByUserName:(NSString *)userName userLevel:(NSString *)userLevel userArea:(NSString *)userArea;//删除所有非该用户的数据


//时间格式相关
+ (NSDate *)getDateFromMSDateString:(NSString*)msDateString;
+ (NSString *)getDateFromMSDateString:(NSString*)msDateString format:(NSString *)formatString;
+ (NSString *)getStringFromDate:(NSDate *)date format:(NSString *)format;


//消息相关
+ (UIImageView *)getMsgPrompt;
+ (UIImageView *)getMsgSuccess;


//网络相关
+ (NSTimeInterval)getTimeOutSeconds;
+ (NSTimeInterval)getTimeOutLoginSeconds;
+ (BOOL)isExistenceNetwork;
+ (BOOL)isExistenceNetwork:(NSString *)url;
+ (NetworkStatus)getNetworkType;


//加密解密
+ (NSString *)encrypt:(NSString *)value;
+ (NSString *)decrypt:(NSString *)value;


//文件相关
+ (NSString *)getImageFullPath:(NSString *)imageName;
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;//给文件加上"do not back up"属性=不同步iCloud 


//地址相关
+ (NSString *)UrlLogin;
+ (NSString *)UrlInit;
+ (NSString *)UrlSystemInfo;
+ (NSString *)UrlUpdate;
+ (NSString *)UrlUserData;
+ (NSString *)UrlImageById;
+ (NSString *)UrlUploadSystemLog;
+ (NSString *)UrlUploadUserVehicleLog;
+ (NSString *)UrlCertificate;
+ (NSString *)UrlAddDialogue;
+ (NSString *)UrlGetDialogueClass;
+ (NSString *)UrlGetUser;
+ (NSString *)UrlGetOrganization;
+ (NSString *)UrlGetDialogue;
+ (NSString *)UrlGetDialogueDetail;
+ (NSString *)UrlGetImageDownloadBasePath;
+ (NSString *)UrlDeleteDialogueMaster;
+ (NSString *)UrlDeleteDialogueDetail;
+ (NSString *)UrlCloseDialogue;
+ (NSString *)UrlAddDialogueDetail;

//字符串相关
+ (BOOL)isExistenceString:(NSString *)searchString string:(NSString *)string;//将字符串以^分隔查询是否存在某字符串
+ (UIView *)addLabelToImage:(NSString *)text font:(UIFont *)font color:(UIColor *)color width:(float)width height:(float)height;
+ (UILabel *)addLabelToImage:(float)width height:(float)height;
+ (NSString *)getValueWithKey:(NSString *)key inString:(NSString *)string;
+ (NSArray *)getLabelsWithString:(NSString *)string point:(CGPoint)point size:(CGSize)size font:(UIFont *)font color:(UIColor *)color;
+ (NSString *)getReplaceWithString:(NSString *)string;

//缓存图片相关
+ (NSString *)createCacheImage:(NSString *)imagePath size:(CGSize)size version:(int)version;
+ (NSString *)createCacheImage:(NSString *)imagePath size:(CGSize)size version:(int)version fill:(BOOL)fill center:(BOOL)center;

//获取对应操作的SQL语句更新操作
//+ (NSString *)getVehicleEditionSettingHisSql:(SqlType)sqlType;

@end