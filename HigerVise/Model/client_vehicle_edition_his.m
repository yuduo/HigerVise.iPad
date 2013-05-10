#import "client_vehicle_edition_his.h"

@implementation client_vehicle_edition_his

@synthesize vehicle_edition_id;
@synthesize vehicle_configurator_id;
@synthesize vehicle_code;
@synthesize edition_id;
@synthesize edition_type;
@synthesize display_name;
@synthesize edition_title;
@synthesize std_price;
@synthesize sale_price;
@synthesize del_price;
@synthesize customer_price;
@synthesize base_price;
@synthesize edition_desc;
@synthesize edition_remark;
@synthesize edition_tech_desc;
@synthesize edition_cancel;
@synthesize create_userid;
@synthesize create_time;
@synthesize update_userid;
@synthesize update_time;
@synthesize data_version;

@synthesize all_settings;
@synthesize dp_settings;
@synthesize cs_settings;
@synthesize op_settings;
@synthesize bp_settings;
@synthesize pc_settings;
@synthesize sql_list;

- (id)init
{
    self = [super init];
    if (self) {
        self.all_settings = [[NSMutableArray alloc] init];
        self.dp_settings = [[NSMutableArray alloc] init];
        self.cs_settings = [[NSMutableArray alloc] init];
        self.op_settings = [[NSMutableArray alloc] init];
        self.bp_settings = [[NSMutableArray alloc] init];
        self.pc_settings = [[NSMutableArray alloc] init];
        self.sql_list = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    client_vehicle_edition_his *copy = [[[self class] allocWithZone:zone] init];
    copy->vehicle_edition_id = [vehicle_edition_id copy];
    copy->vehicle_configurator_id = [vehicle_configurator_id copy];
    copy->vehicle_code = [vehicle_code copy];
    copy->edition_id = [edition_id copy];
    copy->edition_type = [edition_type copy];
    copy->display_name = [display_name copy];
    copy->edition_title = [edition_title copy];
    copy->std_price = [std_price copy];
    copy->sale_price = [sale_price copy];
    copy->del_price = [del_price copy];
    copy->customer_price = [customer_price copy];
    copy->base_price = [base_price copy];
    copy->edition_desc = [edition_desc copy];
    copy->edition_remark = [edition_remark copy];
    copy->edition_tech_desc = [edition_tech_desc copy];
    copy->edition_cancel = [edition_cancel copy];
    copy->create_userid = [create_userid copy];
    copy->create_time = [create_time copy];
    copy->update_userid = [update_userid copy];
    copy->update_time = [update_time copy];
    copy->data_version = [data_version copy];
    copy->all_settings = [[NSMutableArray alloc] initWithArray:all_settings copyItems:YES];
    copy->dp_settings = [[NSMutableArray alloc] initWithArray:dp_settings copyItems:YES];
    copy->cs_settings = [[NSMutableArray alloc] initWithArray:cs_settings copyItems:YES];
    copy->op_settings = [[NSMutableArray alloc] initWithArray:op_settings copyItems:YES];
    copy->bp_settings = [[NSMutableArray alloc] initWithArray:bp_settings copyItems:YES];
    copy->pc_settings = [[NSMutableArray alloc] initWithArray:pc_settings copyItems:YES];
    copy->sql_list = [[NSMutableArray alloc] initWithArray:sql_list copyItems:YES];
    return copy;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    client_vehicle_edition_his *copy = [[[self class] allocWithZone:zone] init];
    copy->vehicle_edition_id = [vehicle_edition_id mutableCopy];
    copy->vehicle_configurator_id = [vehicle_configurator_id mutableCopy];
    copy->vehicle_code = [vehicle_code mutableCopy];
    copy->edition_id = [edition_id mutableCopy];
    copy->edition_type = [edition_type mutableCopy];
    copy->display_name = [display_name mutableCopy];
    copy->edition_title = [edition_title mutableCopy];
    copy->std_price = [std_price mutableCopy];
    copy->sale_price = [sale_price mutableCopy];
    copy->del_price = [del_price mutableCopy];
    copy->customer_price = [customer_price mutableCopy];
    copy->base_price = [base_price mutableCopy];
    copy->edition_desc = [edition_desc mutableCopy];
    copy->edition_remark = [edition_remark mutableCopy];
    copy->edition_tech_desc = [edition_tech_desc mutableCopy];
    copy->edition_cancel = [edition_cancel mutableCopy];
    copy->create_userid = [create_userid mutableCopy];
    copy->create_time = [create_time mutableCopy];
    copy->update_userid = [update_userid mutableCopy];
    copy->update_time = [update_time mutableCopy];
    copy->data_version = [data_version mutableCopy];
    copy->all_settings = [[NSMutableArray alloc] initWithArray:all_settings copyItems:YES];
    copy->dp_settings = [[NSMutableArray alloc] initWithArray:dp_settings copyItems:YES];
    copy->cs_settings = [[NSMutableArray alloc] initWithArray:cs_settings copyItems:YES];
    copy->op_settings = [[NSMutableArray alloc] initWithArray:op_settings copyItems:YES];
    copy->bp_settings = [[NSMutableArray alloc] initWithArray:bp_settings copyItems:YES];
    copy->pc_settings = [[NSMutableArray alloc] initWithArray:pc_settings copyItems:YES];
    copy->sql_list = [[NSMutableArray alloc] initWithArray:sql_list copyItems:YES];
    return copy;
}

@end