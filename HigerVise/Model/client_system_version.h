#import <Foundation/Foundation.h>

@interface client_system_version : NSObject

@property (nonatomic, strong) NSNumber * system_version_id;
@property (nonatomic, strong) NSNumber * vehicle_configurator_id;
@property (nonatomic, strong) NSString * vehicle_code;
@property (nonatomic, strong) NSNumber * system_version;
@property (nonatomic, strong) NSString * version_desc;
@property (nonatomic, strong) NSString * create_userid;
@property (nonatomic, strong) NSDate * create_time;
@property (nonatomic, strong) NSString * update_userid;
@property (nonatomic, strong) NSDate * update_time;
@property (nonatomic, strong) NSNumber * data_version;

@end