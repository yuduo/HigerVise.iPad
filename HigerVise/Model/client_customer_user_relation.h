#import <Foundation/Foundation.h>

@interface client_customer_user_relation : NSObject

@property (nonatomic, strong) NSNumber * customer_user_relation_id;
@property (nonatomic, strong) NSString * customer_id;
@property (nonatomic, strong) NSString * customer_code;
@property (nonatomic, strong) NSNumber * user_id;
@property (nonatomic, strong) NSString * user_name;
@property (nonatomic, strong) NSDate * create_time;
@property (nonatomic, strong) NSString * create_userid;
@property (nonatomic, strong) NSNumber * data_version;

@end