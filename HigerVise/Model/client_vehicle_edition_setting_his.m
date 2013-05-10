#import "client_vehicle_edition_setting_his.h"

@implementation client_vehicle_edition_setting_his

@synthesize vehicle_edition_setting_id;
@synthesize vehicle_configurator_id;
@synthesize vehicle_edition_id;
@synthesize group_code;
@synthesize sale_group_code;
@synthesize op_code;
@synthesize op_name;
@synthesize sale_op_name;
@synthesize op_seq;
@synthesize op_value_code;
@synthesize op_value_name;
@synthesize sale_op_value_name;
@synthesize op_value_level_code;
@synthesize op_value_std_price;
@synthesize op_value_del_price;
@synthesize op_show_grade_disid;
@synthesize view_desc;
@synthesize is_displayed;
@synthesize is_displayed_config;
@synthesize is_allow_edited;
@synthesize is_has_image;
@synthesize is_selected;
@synthesize is_canceled;
@synthesize create_userid;
@synthesize create_time;
@synthesize update_userid;
@synthesize update_time;
@synthesize data_version;

@synthesize optional_settings;
@synthesize is_deleted;
@synthesize is_changed;
@synthesize is_tech_relation;

- (id)init
{
    self = [super init];
    if (self) {
        self.is_deleted = [NSNumber numberWithBool:NO];
        self.is_changed = [NSNumber numberWithBool:NO];
        self.is_tech_relation = [NSNumber numberWithBool:NO];
        self.optional_settings = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    client_vehicle_edition_setting_his *copy = [[[self class] allocWithZone:zone] init];
    copy->vehicle_edition_setting_id = [vehicle_edition_setting_id copy];
    copy->vehicle_configurator_id = [vehicle_configurator_id copy];
    copy->vehicle_edition_id = [vehicle_edition_id copy];
    copy->group_code = [group_code copy];
    copy->sale_group_code = [sale_group_code copy];
    copy->op_code = [op_code copy];
    copy->op_name = [op_name copy];
    copy->sale_op_name = [sale_op_name copy];
    copy->op_seq = [op_seq copy];
    copy->op_value_code = [op_value_code copy];
    copy->op_value_name = [op_value_name copy];
    copy->sale_op_value_name = [sale_op_value_name copy];
    copy->op_value_level_code = [op_value_level_code copy];
    copy->op_value_std_price = [op_value_std_price copy];
    copy->op_value_del_price = [op_value_del_price copy];
    copy->op_show_grade_disid = [op_show_grade_disid copy];
    copy->view_desc = [view_desc copy];
    copy->is_displayed = [is_displayed copy];
    copy->is_displayed_config = [is_displayed_config copy];
    copy->is_allow_edited = [is_allow_edited copy];
    copy->is_has_image = [is_has_image copy];
    copy->is_selected = [is_selected copy];
    copy->is_canceled = [is_canceled copy];
    copy->create_userid = [create_userid copy];
    copy->create_time = [create_time copy];
    copy->update_userid = [update_userid copy];
    copy->update_time = [update_time copy];
    copy->data_version = [data_version copy];
    copy->is_deleted = [is_deleted copy];
    copy->is_changed = [is_changed copy];
    copy->is_tech_relation = [is_tech_relation copy];
    copy->optional_settings = [[NSMutableArray alloc] initWithArray:optional_settings copyItems:YES];
    return copy;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    client_vehicle_edition_setting_his *copy = [[[self class] allocWithZone:zone] init];
    copy->vehicle_edition_setting_id = [vehicle_edition_setting_id mutableCopy];
    copy->vehicle_configurator_id = [vehicle_configurator_id mutableCopy];
    copy->vehicle_edition_id = [vehicle_edition_id mutableCopy];
    copy->group_code = [group_code mutableCopy];
    copy->sale_group_code = [sale_group_code mutableCopy];
    copy->op_code = [op_code mutableCopy];
    copy->op_name = [op_name mutableCopy];
    copy->sale_op_name = [sale_op_name mutableCopy];
    copy->op_seq = [op_seq mutableCopy];
    copy->op_value_code = [op_value_code mutableCopy];
    copy->op_value_name = [op_value_name mutableCopy];
    copy->sale_op_value_name = [sale_op_value_name mutableCopy];
    copy->op_value_level_code = [op_value_level_code mutableCopy];
    copy->op_value_std_price = [op_value_std_price mutableCopy];
    copy->op_value_del_price = [op_value_del_price mutableCopy];
    copy->op_show_grade_disid = [op_show_grade_disid mutableCopy];
    copy->view_desc = [view_desc mutableCopy];
    copy->is_displayed = [is_displayed mutableCopy];
    copy->is_displayed_config = [is_displayed_config mutableCopy];
    copy->is_allow_edited = [is_allow_edited mutableCopy];
    copy->is_has_image = [is_has_image mutableCopy];
    copy->is_selected = [is_selected mutableCopy];
    copy->is_canceled = [is_canceled mutableCopy];
    copy->create_userid = [create_userid mutableCopy];
    copy->create_time = [create_time mutableCopy];
    copy->update_userid = [update_userid mutableCopy];
    copy->update_time = [update_time mutableCopy];
    copy->data_version = [data_version mutableCopy];
    copy->is_deleted = [is_deleted mutableCopy];
    copy->is_changed = [is_changed mutableCopy];
    copy->is_tech_relation = [is_tech_relation mutableCopy];
    copy->optional_settings = [[NSMutableArray alloc] initWithArray:optional_settings copyItems:YES];
    return copy;
}

@end