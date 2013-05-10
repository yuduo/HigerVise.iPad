#import <Foundation/Foundation.h>

@interface client_vehicle_edition_his : NSObject<NSCopying, NSMutableCopying>

@property (nonatomic, strong) NSNumber * vehicle_edition_id;
@property (nonatomic, strong) NSNumber * vehicle_configurator_id;
@property (nonatomic, strong) NSString * vehicle_code;
@property (nonatomic, strong) NSNumber * edition_id;
@property (nonatomic, strong) NSNumber * edition_type;
@property (nonatomic, strong) NSString * display_name;
@property (nonatomic, strong) NSString * edition_title;
@property (nonatomic, strong) NSNumber * std_price;
@property (nonatomic, strong) NSNumber * sale_price;
@property (nonatomic, strong) NSNumber * del_price;
@property (nonatomic, strong) NSNumber * customer_price;
@property (nonatomic, strong) NSNumber * base_price;
@property (nonatomic, strong) NSString * edition_desc;
@property (nonatomic, strong) NSString * edition_remark;
@property (nonatomic, strong) NSString * edition_tech_desc;
@property (nonatomic, strong) NSNumber * edition_cancel;
@property (nonatomic, strong) NSString * create_userid;
@property (nonatomic, strong) NSDate * create_time;
@property (nonatomic, strong) NSString * update_userid;
@property (nonatomic, strong) NSDate * update_time;
@property (nonatomic, strong) NSNumber * data_version;

@property (nonatomic, strong) NSMutableArray *all_settings;//存储所有配件
@property (nonatomic, strong) NSMutableArray *dp_settings;//存储所有底盘配件
@property (nonatomic, strong) NSMutableArray *cs_settings;//存储所有身车配件
@property (nonatomic, strong) NSMutableArray *op_settings;//存储所有可选配件
@property (nonatomic, strong) NSMutableArray *bp_settings;//存储所有标准配件
@property (nonatomic, strong) NSMutableArray *pc_settings;//存储所有排斥配件
@property (nonatomic, strong) NSMutableArray *sql_list;//存储所有SQL操作语句

@end