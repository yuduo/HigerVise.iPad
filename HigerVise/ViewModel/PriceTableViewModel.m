//
//  PriceTableViewModel.m
//  HigerVise
//
//  Created by Kevin.Mao on 12-11-6.
//  Copyright (c) 2012年 JijeSoft. All rights reserved.
//

#import "PriceTableViewModel.h"

static PriceTableViewModel *_sharedViewModel = nil;

@implementation PriceTableViewModel
@synthesize result, searchPrompts, searchResults, editionIndex, settingIndex, his_editionIndex;
@synthesize vehicle, settingsRelation;
@synthesize editionType, viewType;
@synthesize editions, his_editions, edit_edition;

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (PriceTableViewModel *)sharedViewModel
{
    @synchronized(self) {
        if (_sharedViewModel == nil) {
            _sharedViewModel = [[self alloc] init];
        }
    }
    return _sharedViewModel;
}

- (void)releaseViewModel
{
    if (_sharedViewModel) {
        _sharedViewModel = nil;
    }
}

- (void)dealloc
{
    [self setResult:nil];
    [self setSearchPrompts:nil];
    [self setSearchResults:nil];
    
    [self setVehicle:nil];
    [self setSettingsRelation:nil];
    
    [self setEditions:nil];
    [self setHis_editions:nil];
    [self setEdit_edition:nil];
}

@end

@implementation ModelInfo

#pragma mark - PriceTableViewModel

//获取视图模型
+ (PriceTableViewModel *)getModel
{
    return [PriceTableViewModel sharedViewModel];
}

//获取当前页面版本信息
+ (client_vehicle_edition_his *)getEdition
{
    client_vehicle_edition_his *edition = nil;
    if ([self getModel].viewType == PriceTableViewTypeNormal) {
        if ([self getModel].editionType == PriceTableEditionTypeData) {
            edition = [[self getModel].editions objectAtIndex:[self getModel].editionIndex];
        }
        else {
            edition = [[self getModel].his_editions objectAtIndex:[self getModel].his_editionIndex];
        }
    }
    else if ([self getModel].viewType == PriceTableViewTypeEdit) {
        edition = [self getModel].edit_edition;
    }
    return edition;
}

//获取车身列表
+ (client_vehicle_edition_his *)getHistoryEdition:(NSNumber *)hisEditionIndex
{
    client_vehicle_edition_his *edition = [[self getModel].his_editions objectAtIndex:[self getModel].his_editionIndex];
    return edition;
}

//获取显示配件：底盘或者车身
+ (NSMutableArray *)getSettings:(PriceTableSettingType)settingType
{
    client_vehicle_edition_his *edition = [self getEdition];
    NSMutableArray *settings = nil;
    if (settingType == PriceTableSettingTypeDp) {
        settings = edition.dp_settings;
    }
    else if (settingType == PriceTableSettingTypeCs) {
        settings = edition.cs_settings;
    }
    return settings;
}

//获取可选配置
+ (NSMutableArray *)getXpSettings
{
    client_vehicle_edition_his *edition = [self getEdition];
    return edition.op_settings;
}

//获取标配配置
+ (NSMutableArray *)getBpSettings
{
    client_vehicle_edition_his *edition = [self getEdition];
    return edition.bp_settings;
}

//获取相对于标准配件的价格
//op_code:当前配件编码
//op_name:当前配件名称
//op_value_std_price:当前配件价格
+ (NSString *)getDelPriceString:(NSString *)op_code op_name:(NSString *)op_name op_value_std_price:(NSNumber *)op_value_std_price
{
    //自定义配件处理原则
    int std_price = [op_value_std_price intValue];//当前配件价格
    if ([op_name isEqualToString:kSettingAddOpName]) {
        if (std_price != 0) {
            if (std_price > 0) {
                return [NSString stringWithFormat:@"+ %d", std_price];
            }
            else {
                return [NSString stringWithFormat:@"- %d", (0 - std_price)];
            }
        }
        else {
            return @"";
        }
    }

    //非自定义配件处理原则
    int del_price = 0;
    NSMutableArray *settings = [self getBpSettings];
    for (int i = 0; i < settings.count; i++) {
        client_vehicle_edition_setting_his *setting = [settings objectAtIndex:i];
        if ([setting.op_code isEqualToString:op_code]) {
            int bp_std_price = [setting.op_value_std_price intValue];//标准配件价格
            del_price = std_price - bp_std_price;//差价=当前配件价格-标准配件价格
            break;
        }
    }
    if (del_price != 0) {
        if (del_price > 0) {
            return [NSString stringWithFormat:@"+ %d", del_price];
        }
        else {
            return [NSString stringWithFormat:@"- %d", 0 - del_price];
        }
    }
    else {
        return @"";
    }
}

+ (NSString *)getDelPriceEditString:(NSString *)op_code op_name:(NSString *)op_name op_value_std_price:(NSNumber *)op_value_std_price
{
    //自定义配件处理原则
    int std_price = [op_value_std_price intValue];//当前配件价格
    if ([op_name isEqualToString:kSettingAddOpName]) {
        if (std_price != 0) {
            if (std_price > 0) {
                return [NSString stringWithFormat:@"+%d", std_price];
            }
            else {
                return [NSString stringWithFormat:@"-%d", (0 - std_price)];
            }
        }
        else {
            return @"";
        }
    }
    
    //非自定义配件处理原则
    int del_price = 0;
    NSMutableArray *settings = [self getBpSettings];
    for (int i = 0; i < settings.count; i++) {
        client_vehicle_edition_setting_his *setting = [settings objectAtIndex:i];
        if ([setting.op_code isEqualToString:op_code]) {
            int bp_std_price = [setting.op_value_std_price intValue];//标准配件价格
            del_price = std_price - bp_std_price;//差价=当前配件价格-标准配件价格
            break;
        }
    }
    if (del_price != 0) {
        if (del_price > 0) {
            return [NSString stringWithFormat:@"+%d", del_price];
        }
        else {
            return [NSString stringWithFormat:@"-%d", 0 - del_price];
        }
    }
    else {
        return @"";
    }
}

+ (NSNumber *)getDelPrice:(NSString *)op_code op_name:(NSString *)op_name op_value_std_price:(NSNumber *)op_value_std_price
{
    //自定义配件处理原则
    int std_price = [op_value_std_price intValue];//当前配件价格
    if ([op_name isEqualToString:kSettingAddOpName]) {
        return op_value_std_price;
    }
    
    //非自定义配件处理原则
    int del_price = 0;
    NSMutableArray *settings = [self getBpSettings];
    for (int i = 0; i < settings.count; i++) {
        client_vehicle_edition_setting_his *setting = [settings objectAtIndex:i];
        if ([setting.op_code isEqualToString:op_code]) {
            int bp_std_price = [setting.op_value_std_price intValue];//标准配件价格
            del_price = std_price - bp_std_price;//差价=当前配件价格-标准配件价格
            break;
        }
    }
    return [NSNumber numberWithInt:del_price];
}

+ (NSNumber *)getStdPrice:(NSString *)op_code op_name:(NSString *)op_name op_value_del_price:(NSNumber *)op_value_del_price
{
    //自定义配件处理原则
    int del_price = [op_value_del_price intValue];//当前配件差价
    if ([op_name isEqualToString:kSettingAddOpName]) {
        return op_value_del_price;
    }
    
    //非自定义配件处理原则
    int std_price = 0;
    NSMutableArray *settings = [self getBpSettings];
    for (int i = 0; i < settings.count; i++) {
        client_vehicle_edition_setting_his *setting = [settings objectAtIndex:i];
        if ([setting.op_code isEqualToString:op_code]) {
            int bp_std_price = [setting.op_value_std_price intValue];//标准配件价格
            std_price = bp_std_price + del_price;//当前配件价格=标准配件价格+差价
            break;
        }
    }
    return [NSNumber numberWithInt:std_price];
}

@end
