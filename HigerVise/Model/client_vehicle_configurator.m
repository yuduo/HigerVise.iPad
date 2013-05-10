#import "client_vehicle_configurator.h"

@implementation client_vehicle_configurator

@synthesize vehicle_configurator_id;
@synthesize vehicle_class_id;
@synthesize vehicle_code;
@synthesize item_code;
@synthesize item_model;
@synthesize vehicle_pca_version;
@synthesize display_name;
@synthesize engine_model;
@synthesize vehicle_series;
@synthesize vehicle_asses_type_rank;
@synthesize is_air_suspension;
@synthesize vehicle_suspension_type;
@synthesize rank_seat;
@synthesize vehicle_fuel;
@synthesize vehicle_passenger_door;
@synthesize vehicle_body_struct;
@synthesize vehicle_desc;
@synthesize vehicle_remark;
@synthesize vehicle_tech_desc;
@synthesize search_text;
@synthesize click_count;
@synthesize data_version;

@synthesize image_url;
@synthesize image_data_version;

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    client_vehicle_configurator *copy = [[[self class] allocWithZone:zone] init];

    copy->vehicle_configurator_id = [vehicle_configurator_id copy];
    copy->vehicle_class_id = [vehicle_class_id copy];
    copy->vehicle_code = [vehicle_code copy];
    copy->item_code = [item_code copy];
    copy->item_model = [item_model copy];
    copy->vehicle_pca_version = [vehicle_pca_version copy];
    copy->display_name = [display_name copy];
    copy->engine_model = [engine_model copy];
    copy->vehicle_series = [vehicle_series copy];
    copy->vehicle_asses_type_rank = [vehicle_asses_type_rank copy];
    copy->is_air_suspension = [is_air_suspension copy];
    copy->vehicle_suspension_type = [vehicle_suspension_type copy];
    copy->rank_seat = [rank_seat copy];
    copy->vehicle_fuel = [vehicle_fuel copy];
    copy->vehicle_passenger_door = [vehicle_passenger_door copy];
    copy->vehicle_body_struct = [vehicle_body_struct copy];
    copy->vehicle_desc = [vehicle_desc copy];
    copy->vehicle_remark = [vehicle_remark copy];
    copy->vehicle_tech_desc = [vehicle_tech_desc copy];
    copy->search_text = [search_text copy];
    copy->click_count = [click_count copy];
    copy->data_version = [data_version copy];
    copy->image_url = [image_url copy];
    copy->image_data_version = [image_data_version copy];
    
    return copy;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    client_vehicle_configurator *copy = [[[self class] allocWithZone:zone] init];
    
    copy->vehicle_configurator_id = [vehicle_configurator_id mutableCopy];
    copy->vehicle_class_id = [vehicle_class_id mutableCopy];
    copy->vehicle_code = [vehicle_code mutableCopy];
    copy->item_code = [item_code mutableCopy];
    copy->item_model = [item_model mutableCopy];
    copy->vehicle_pca_version = [vehicle_pca_version mutableCopy];
    copy->display_name = [display_name mutableCopy];
    copy->engine_model = [engine_model mutableCopy];
    copy->vehicle_series = [vehicle_series mutableCopy];
    copy->vehicle_asses_type_rank = [vehicle_asses_type_rank mutableCopy];
    copy->is_air_suspension = [is_air_suspension mutableCopy];
    copy->vehicle_suspension_type = [vehicle_suspension_type mutableCopy];
    copy->rank_seat = [rank_seat mutableCopy];
    copy->vehicle_fuel = [vehicle_fuel mutableCopy];
    copy->vehicle_passenger_door = [vehicle_passenger_door mutableCopy];
    copy->vehicle_body_struct = [vehicle_body_struct mutableCopy];
    copy->vehicle_desc = [vehicle_desc mutableCopy];
    copy->vehicle_remark = [vehicle_remark mutableCopy];
    copy->vehicle_tech_desc = [vehicle_tech_desc mutableCopy];
    copy->search_text = [search_text mutableCopy];
    copy->click_count = [click_count mutableCopy];
    copy->data_version = [data_version mutableCopy];
    copy->image_url = [image_url mutableCopy];
    copy->image_data_version = [image_data_version mutableCopy];
    
    return copy;
}

@end