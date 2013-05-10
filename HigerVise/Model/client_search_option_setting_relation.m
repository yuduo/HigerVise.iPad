#import "client_search_option_setting_relation.h"

@implementation client_search_option_setting_relation

@synthesize search_option_setting_relation_id;
@synthesize search_option_id;
@synthesize op_code;
@synthesize op_value_code;
@synthesize item_code;
@synthesize item_model;
@synthesize data_version;

- (id)copyWithZone:(NSZone *)zone
{
    client_search_option_setting_relation *copy = [[[self class] allocWithZone:zone] init];
    copy->search_option_setting_relation_id = [search_option_setting_relation_id copy];
    copy->search_option_id = [search_option_id copy];
    copy->op_code = [op_code copy];
    copy->op_value_code = [op_value_code copy];
    copy->item_code = [item_code copy];
    copy->item_model = [item_model copy];
    copy->data_version = [data_version copy];
    return copy;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    client_search_option_setting_relation *copy = [[[self class] allocWithZone:zone] init];
    copy->search_option_setting_relation_id = [search_option_setting_relation_id mutableCopy];
    copy->search_option_id = [search_option_id mutableCopy];
    copy->op_code = [op_code mutableCopy];
    copy->op_value_code = [op_value_code mutableCopy];
    copy->item_code = [item_code mutableCopy];
    copy->item_model = [item_model mutableCopy];
    copy->data_version = [data_version mutableCopy];
    return copy;
}

@end