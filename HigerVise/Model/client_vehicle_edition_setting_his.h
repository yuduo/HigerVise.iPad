#import <Foundation/Foundation.h>

@interface client_vehicle_edition_setting_his : NSObject<NSCopying, NSMutableCopying>

@property (nonatomic, strong) NSNumber * vehicle_edition_setting_id;
@property (nonatomic, strong) NSNumber * vehicle_configurator_id;
@property (nonatomic, strong) NSNumber * vehicle_edition_id;
@property (nonatomic, strong) NSString * group_code;
@property (nonatomic, strong) NSString * sale_group_code;
@property (nonatomic, strong) NSString * op_code;
@property (nonatomic, strong) NSString * op_name;
@property (nonatomic, strong) NSString * sale_op_name;
@property (nonatomic, strong) NSString * op_seq;
@property (nonatomic, strong) NSString * op_value_code;
@property (nonatomic, strong) NSString * op_value_name;
@property (nonatomic, strong) NSString * sale_op_value_name;
@property (nonatomic, strong) NSNumber * op_value_level_code;
@property (nonatomic, strong) NSNumber * op_value_std_price;
@property (nonatomic, strong) NSNumber * op_value_del_price;
@property (nonatomic, strong) NSNumber * op_show_grade_disid;
@property (nonatomic, strong) NSString * view_desc;
@property (nonatomic, strong) NSNumber * is_displayed;
@property (nonatomic, strong) NSNumber * is_displayed_config;
@property (nonatomic, strong) NSNumber * is_allow_edited;
@property (nonatomic, strong) NSNumber * is_has_image;
@property (nonatomic, strong) NSNumber * is_selected;
@property (nonatomic, strong) NSNumber * is_canceled;
@property (nonatomic, strong) NSString * create_userid;
@property (nonatomic, strong) NSDate * create_time;
@property (nonatomic, strong) NSString * update_userid;
@property (nonatomic, strong) NSDate * update_time;
@property (nonatomic, strong) NSNumber * data_version;

@property (nonatomic, strong) NSMutableArray * optional_settings;
@property (nonatomic, strong) NSNumber * is_deleted;
@property (nonatomic, strong) NSNumber * is_changed;
@property (nonatomic, strong) NSNumber * is_tech_relation;

@end