#import "client_vehicle_setting_relation.h"

@implementation client_vehicle_setting_relation

@synthesize vehicle_setting_relation_id;
@synthesize vehicle_configurator_id;
@synthesize master_op_code;
@synthesize master_op_value_code;
@synthesize slave_op_code;
@synthesize slave_op_value_code;
@synthesize relation_type;
@synthesize tech_sale_relation;
@synthesize data_version;

- (id)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    client_vehicle_setting_relation *copy = [[[self class] allocWithZone:zone] init];
    copy->vehicle_setting_relation_id = [vehicle_setting_relation_id copy];
    copy->vehicle_configurator_id = [vehicle_configurator_id copy];
    copy->master_op_code = [master_op_code copy];
    copy->master_op_value_code = [master_op_value_code copy];
    copy->slave_op_code = [slave_op_code copy];
    copy->slave_op_value_code = [slave_op_value_code copy];
    copy->relation_type = [relation_type copy];
    copy->tech_sale_relation = [tech_sale_relation copy];
    copy->data_version = [data_version copy];
    return copy;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    client_vehicle_setting_relation *copy = [[[self class] allocWithZone:zone] init];
    copy->vehicle_setting_relation_id = [vehicle_setting_relation_id mutableCopy];
    copy->vehicle_configurator_id = [vehicle_configurator_id mutableCopy];
    copy->master_op_code = [master_op_code mutableCopy];
    copy->master_op_value_code = [master_op_value_code mutableCopy];
    copy->slave_op_code = [slave_op_code mutableCopy];
    copy->slave_op_value_code = [slave_op_value_code mutableCopy];
    copy->relation_type = [relation_type mutableCopy];
    copy->tech_sale_relation = [tech_sale_relation mutableCopy];
    copy->data_version = [data_version mutableCopy];
    return copy;
}

@end