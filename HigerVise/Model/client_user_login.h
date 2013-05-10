#import <Foundation/Foundation.h>

@interface client_user_login : NSObject

@property (nonatomic, strong) NSNumber * user_login_id;
@property (nonatomic, strong) NSString * user_name;
@property (nonatomic, strong) NSString * user_real_name;
@property (nonatomic, strong) NSString * user_level;
@property (nonatomic, strong) NSString * user_area;
@property (nonatomic, strong) NSString * user_password;
@property (nonatomic, strong) NSString * ipad_mac_address;
@property (nonatomic, strong) NSString * user_ipad_key;
@property (nonatomic, strong) NSDate * login_time;
@property (nonatomic, strong) NSNumber * login_result;

@end