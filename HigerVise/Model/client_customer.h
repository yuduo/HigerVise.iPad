#import <Foundation/Foundation.h>

@interface client_customer : NSObject

@property (nonatomic, strong) NSString * customer_id;
@property (nonatomic, strong) NSString * customer_code;
@property (nonatomic, strong) NSString * customer_picture_url;
@property (nonatomic, strong) NSString * customer_name;
@property (nonatomic, strong) NSString * customer_name_brief;
@property (nonatomic, strong) NSString * global_region_code;
@property (nonatomic, strong) NSString * nation_region_code;
@property (nonatomic, strong) NSString * city_region_code;
@property (nonatomic, strong) NSString * county_region_code;
@property (nonatomic, strong) NSString * customer_address;
@property (nonatomic, strong) NSString * customer_phone;
@property (nonatomic, strong) NSString * customer_mobile;
@property (nonatomic, strong) NSString * customer_fax;
@property (nonatomic, strong) NSString * customer_zip_code;
@property (nonatomic, strong) NSString * customer_mail;
@property (nonatomic, strong) NSString * customer_trade_code;
@property (nonatomic, strong) NSString * customer_owner;
@property (nonatomic, strong) NSString * customer_kind_id;
@property (nonatomic, strong) NSString * customer_class_id;
@property (nonatomic, strong) NSString * customer_desc;
@property (nonatomic, strong) NSString * customer_remark;
@property (nonatomic, strong) NSString * customer_status;
@property (nonatomic, strong) NSNumber * is_send;
@property (nonatomic, strong) NSNumber * is_used;
@property (nonatomic, strong) NSString * create_userid;
@property (nonatomic, strong) NSDate * create_time;
@property (nonatomic, strong) NSString * update_userid;
@property (nonatomic, strong) NSDate * update_time;
@property (nonatomic, strong) NSNumber * data_version;
@property (nonatomic, strong) NSNumber * data_status;

@end