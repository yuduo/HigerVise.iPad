#import <Foundation/Foundation.h>

@interface client_vehicle_setting_relation : NSObject<NSCopying, NSMutableCopying>

@property (nonatomic, strong) NSNumber * vehicle_setting_relation_id;
@property (nonatomic, strong) NSNumber * vehicle_configurator_id;
@property (nonatomic, strong) NSString * master_op_code;
@property (nonatomic, strong) NSString * master_op_value_code;
@property (nonatomic, strong) NSString * slave_op_code;
@property (nonatomic, strong) NSString * slave_op_value_code;
@property (nonatomic, strong) NSNumber * relation_type;//1001:必须,1002:排斥
@property (nonatomic, strong) NSNumber * tech_sale_relation;//1001:技术,1002:销售
@property (nonatomic, strong) NSNumber * data_version;

@end