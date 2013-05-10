#import <Foundation/Foundation.h>

@interface client_customer_contacter : NSObject

@property (nonatomic, strong) NSString * contacter_id;
@property (nonatomic, strong) NSString * customer_id;
@property (nonatomic, strong) NSString * customer_code;
@property (nonatomic, strong) NSString * contacter_code;
@property (nonatomic, strong) NSString * contacter_name;
@property (nonatomic, strong) NSString * contacter_sex;
@property (nonatomic, strong) NSString * contacter_role;
@property (nonatomic, strong) NSString * contacter_position;
@property (nonatomic, strong) NSString * contacter_office_phone;
@property (nonatomic, strong) NSString * contacter_mobile;
@property (nonatomic, strong) NSNumber * is_used;
@property (nonatomic, strong) NSString * create_userid;
@property (nonatomic, strong) NSDate * create_time;
@property (nonatomic, strong) NSString * update_userid;
@property (nonatomic, strong) NSDate * update_time;
@property (nonatomic, strong) NSNumber * data_version;

@end