//
//  DataService.h
//  HigerVise
//
//  Created by Kevin.Mao on 12-10-12.
//  Copyright (c) 2012年 JijeSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "ASIHTTPRequest.h"
#import "BaseInfo.h"
#import "ConfigInfo.h"
#import "UserInfo.h"

@interface DataService : NSObject

- (NSDictionary *)requestLogin:(NSString *)userName userPwd:(NSString *)userPwd;
- (NSDictionary *)requestInitData:(NSString *)userName useriPadKey:(NSString *)useriPadKey;
- (NSDictionary *)requestSystemInfo:(NSString *)userName useriPadKey:(NSString *)useriPadKey;
- (NSDictionary *)requestUpdateData:(NSString *)appVersion 
                           userName:(NSString *)userName 
                     iPadMacAddress:(NSString *)iPadMacAddress 
                        useriPadKey:(NSString *)useriPadKey;
- (NSDictionary *)requestImageById:(NSString *)referenceId;
- (NSDictionary *)requestUserData;
- (NSDictionary *)requestCertificate:(BOOL)isRequest;
- (NSDictionary *)requestDialogueClass;
- (NSDictionary *)requestUser;
- (NSDictionary *)requestOrganization;
- (NSDictionary *)requestGetDialogue:(int)row;
- (NSDictionary *)requestGetDialogueDetail:(NSString *)client_dialogue_master_id;
- (NSDictionary *)requestDeleteDialogueMaster:(NSString *)web_dialogue_master_ids;
- (NSDictionary *)requestDeleteDialogueDetail:(NSString *)web_dialogue_master_ids;
- (NSDictionary *)requestCloseDialogue:(NSString *)web_dialogue_master_id and:(NSString *)web_dialogue_result;

- (BOOL)uploadSystemLog:(client_system_log *)model;
- (BOOL)uploadVehicleLog:(client_user_vehicle_log *)model;

@end
