#import "client_search.h"

@implementation client_search

@synthesize search_id;
@synthesize display_name;
@synthesize field_name;
@synthesize field_type;
@synthesize search_type;
@synthesize search_index;
@synthesize data_version;

@synthesize search_options;

- (id)copyWithZone:(NSZone *)zone
{
    client_search *copy = [[[self class] allocWithZone:zone] init];
    copy->search_id = [search_id copy];
    copy->display_name = [display_name copy];
    copy->field_name = [field_name copy];
    copy->field_type = [field_type copy];
    copy->search_type = [search_type copy];
    copy->search_index = [search_index copy];
    copy->data_version = [data_version copy];
    copy->search_options = [[NSArray alloc] initWithArray:search_options copyItems:YES];
    return copy;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    client_search *copy = [[[self class] allocWithZone:zone] init];
    copy->search_id = [search_id mutableCopy];
    copy->display_name = [display_name mutableCopy];
    copy->field_name = [field_name mutableCopy];
    copy->field_type = [field_type mutableCopy];
    copy->search_type = [search_type mutableCopy];
    copy->search_index = [search_index mutableCopy];
    copy->data_version = [data_version mutableCopy];
    copy->search_options = [[NSArray alloc] initWithArray:search_options copyItems:YES];
    return copy;
}

@end