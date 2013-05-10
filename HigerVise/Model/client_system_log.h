#import <Foundation/Foundation.h>

@interface client_system_log : NSObject

@property (nonatomic, strong) NSNumber * system_log_id;
@property (nonatomic, strong) NSString * log_level;
@property (nonatomic, strong) NSString * log_user_name;
@property (nonatomic, strong) NSString * log_module;
@property (nonatomic, strong) NSString * log_operation;
@property (nonatomic, strong) NSDate * log_time;
@property (nonatomic, strong) NSString * log_message;
@property (nonatomic, strong) NSString * log_error;
@property (nonatomic, strong) NSNumber * log_upload;

@end