#import "client_search_option.h"

@implementation client_search_option

@synthesize search_option_id;
@synthesize search_id;
@synthesize vehicle_class_id;
@synthesize display_name;
@synthesize field_value;
@synthesize data_version;

@synthesize search_option_relations;
@synthesize search_option_setting_relations;
@synthesize is_selected;

- (id)init
{
    self = [super init];
    if (self) {
        self.is_selected = [NSNumber numberWithBool:NO];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    client_search_option *copy = [[[self class] allocWithZone:zone] init];
    copy->search_option_id = [search_option_id copy];
    copy->search_id = [search_id copy];
    copy->vehicle_class_id = [vehicle_class_id copy];
    copy->display_name = [display_name copy];
    copy->field_value = [field_value copy];
    copy->data_version = [data_version copy];
    copy->search_option_relations = [[NSDictionary alloc] initWithDictionary:search_option_relations copyItems:YES];
    copy->search_option_setting_relations = [[NSArray alloc] initWithArray:search_option_setting_relations copyItems:YES];
    copy->is_selected = [is_selected copy];
    return copy;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    client_search_option *copy = [[[self class] allocWithZone:zone] init];
    copy->search_option_id = [search_option_id mutableCopy];
    copy->search_id = [search_id mutableCopy];
    copy->vehicle_class_id = [vehicle_class_id mutableCopy];
    copy->display_name = [display_name mutableCopy];
    copy->field_value = [field_value mutableCopy];
    copy->data_version = [data_version mutableCopy];
    copy->search_option_relations = [[NSDictionary alloc] initWithDictionary:search_option_relations copyItems:YES];
    copy->search_option_setting_relations = [[NSArray alloc] initWithArray:search_option_setting_relations copyItems:YES];
    copy->is_selected = [is_selected mutableCopy];
    return copy;
}

@end