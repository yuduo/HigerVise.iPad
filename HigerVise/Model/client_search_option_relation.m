#import "client_search_option_relation.h"

@implementation client_search_option_relation

@synthesize search_option_relation_id;
@synthesize master_search_id;
@synthesize master_search_option_id;
@synthesize slave_search_id;
@synthesize slave_search_option_id;
@synthesize data_version;

- (id)copyWithZone:(NSZone *)zone
{
    client_search_option_relation *copy = [[[self class] allocWithZone:zone] init];
    copy->search_option_relation_id = [search_option_relation_id copy];
    copy->master_search_id = [master_search_id copy];
    copy->master_search_option_id = [master_search_option_id copy];
    copy->slave_search_id = [slave_search_id copy];
    copy->slave_search_option_id = [slave_search_option_id copy];
    copy->data_version = [data_version copy];
    return copy;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    client_search_option_relation *copy = [[[self class] allocWithZone:zone] init];
    copy->search_option_relation_id = [search_option_relation_id mutableCopy];
    copy->master_search_id = [master_search_id mutableCopy];
    copy->master_search_option_id = [master_search_option_id mutableCopy];
    copy->slave_search_id = [slave_search_id mutableCopy];
    copy->slave_search_option_id = [slave_search_option_id mutableCopy];
    copy->data_version = [data_version mutableCopy];
    return copy;
}

@end