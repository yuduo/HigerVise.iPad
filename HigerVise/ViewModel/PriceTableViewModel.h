//
//  PriceTableViewModel.h
//  HigerVise
//
//  Created by Kevin.Mao on 12-11-6.
//  Copyright (c) 2012年 JijeSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseInfo.h"

typedef enum
{
    SettingOperationTypeNormal          = 1001,     //查看状态
    SettingOperationTypeEdit            = 1002,     //编辑状态
    SettingOperationTypeAdd             = 1003,     //新增状态
} SettingOperationType;

typedef enum
{
    PriceTableSettingTypeDp             = 1001,     //底盘数据
    PriceTableSettingTypeCs             = 1002,     //车身数据
} PriceTableSettingType;

typedef enum
{
    PriceTableEditionTypeData           = 1001,     //数据版本
    PriceTableEditionTypeHistory        = 1002,     //历史版本
} PriceTableEditionType;

typedef enum
{
    PriceTableViewTypeNormal            = 1001,     //查看状态
    PriceTableViewTypeEdit              = 1002,     //编辑状态
} PriceTableViewType;

typedef enum
{
    PriceTableLoadSuccess               = 1000,     //初始化加载成功
    PriceTableLoadVehicleSuccess        = 1001,     //加载车辆信息成功
    PriceTableLoadResultSuccess         = 1002,     //搜索列表加载成功
    PriceTableLoadPromptSuccess         = 1003,     //搜索提示加载成功
    PriceTableLoadEditionSuccess        = 1004,     //加载车辆版本信息成功
} PriceTableResult;

static NSString *kSettingAddOpName          = @"HigerViseCustomSetting";    //增加配件名称
static NSString *kSettingAddOpSaleName      = @"其他";                       //增加配件销售名称

//通知名称
static NSString *kNCEditionUpdated          = @"EditionUpdated";            //版本内容更新通知
static NSString *kNCOptionalUpdated         = @"OptionalUpdated";           //选配内容更新通知
static NSString *kNCSettingUpdated          = @"SettingUpdated";            //标配内容更新通知
static NSString *kNCSettingOptionalUpdated  = @"SettingOptionalUpdated";    //置换配件内容更新通知
static NSString *kNCHistoryUpdated          = @"HistoryUpdated";            //我的报价单更新通知
static NSString *kNCSettingImageViewed      = @"SettingImageViewed";        //查看配件图片通知

//通知参数键
static NSString *kNCIdentity                = @"Identity";                  //版本标示
static NSString *kNCKey                     = @"Key";                       //参数键
static NSString *kNCValue1                  = @"Value1";                    //参数值1
static NSString *kNCValue2                  = @"Value2";                    //参数值1

//kNCOptionalUpdated
static NSString *kNCKeyOp                   = @"op";                        //参数键：op 全部更新价格
static NSString *kNCKeyOpCode               = @"op_code";                   //参数键：op_code 批量更新价格
static NSString *kNCKeyOpCodeValue          = @"op_code_value";             //参数键：op_code_value 单独更新价格
static NSString *kNCKeyOpAdd                = @"op_add";                    //参数键：op_add 新增可选配件

//kNCSettingUpdated
static NSString *kNCKeyDp                   = @"dp";                        //参数键：底盘
static NSString *kNCKeyCs                   = @"cs";                        //参数键：车身
static NSString *kNCKeyAll                  = @"all";                       //参数键：底盘 AND 车身
static NSString *kNCIndexKey                = @"IndexKey";                  //参数键：约束更新索引键
static NSString *kNCIndexValue              = @"IndexValue";                //参数键：约束更新索引值

//版本宽度
#define kEditionViewWidth 974

//增加标准配件级别
#define kSettingAddBpLevel 1010

//增加置换配件级别
#define kSettingAddXpLevel 1020

//数据版本信息 tag
#define kEditionData 1000

//历史版本信息 tag
#define kEditionHistory 10000

//历史版本列表 tag
#define kEditionHistoryList 9999

@interface PriceTableViewModel : NSObject

+ (PriceTableViewModel *)sharedViewModel;
- (void)releaseViewModel;

@property (strong, nonatomic) NSNumber *result;                         //加载结果

//需要重置的属性
@property (assign, nonatomic) PriceTableEditionType editionType;        //数据状态
@property (assign, nonatomic) PriceTableViewType viewType;              //页面状态
@property (assign, nonatomic) NSInteger editionIndex;                   //当前页面版本信息索引（数据）
@property (assign, nonatomic) NSInteger his_editionIndex;               //当前页面版本信息索引（历史）
@property (assign, nonatomic) NSInteger settingIndex;                   //当前页面配件信息索引
//需要重置的属性

@property (strong, nonatomic) NSMutableArray *searchResults;            //搜索结果信息
@property (strong, nonatomic) NSMutableArray *searchPrompts;            //搜索提示信息

@property (strong, nonatomic) client_vehicle_configurator *vehicle;     //车辆信息
@property (strong, nonatomic) NSMutableArray *settingsRelation;         //配件约束信息

@property (strong, nonatomic) NSMutableArray *editions;                 //数据版本信息（数据）
@property (strong, nonatomic) NSMutableArray *his_editions;             //历史版本信息（历史）
@property (strong, nonatomic) client_vehicle_edition_his *edit_edition; //编辑状态版本信息

@end

@interface ModelInfo : NSObject

+ (PriceTableViewModel *)getModel;//获取视图模型
+ (client_vehicle_edition_his *)getEdition;//获取版本数据
+ (client_vehicle_edition_his *)getHistoryEdition:(NSNumber *)hisEditionIndex;//获取历史版本数据，用于在历史版本列表处理打印、发送或传真
+ (NSMutableArray *)getSettings:(PriceTableSettingType)settingType;//获取配置数据
+ (NSMutableArray *)getXpSettings;//获取可选配件列表数据
+ (NSMutableArray *)getBpSettings;//获取标准配件列表数据

+ (NSString *)getDelPriceString:(NSString *)op_code op_name:(NSString *)op_name op_value_std_price:(NSNumber *)op_value_std_price;//获取相对于标准配件的价格（字符串格式：列表）
+ (NSString *)getDelPriceEditString:(NSString *)op_code op_name:(NSString *)op_name op_value_std_price:(NSNumber *)op_value_std_price;//获取相对于标准配件的价格（字符串格式：编辑）
+ (NSNumber *)getDelPrice:(NSString *)op_code op_name:(NSString *)op_name op_value_std_price:(NSNumber *)op_value_std_price;//获取相对于标准配件的价格（数字格式）
+ (NSNumber *)getStdPrice:(NSString *)op_code op_name:(NSString *)op_name op_value_del_price:(NSNumber *)op_value_del_price;//根据相对于标准配件的差价获取其基本价格

@end
