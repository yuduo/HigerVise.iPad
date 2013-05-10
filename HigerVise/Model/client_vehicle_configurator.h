#import <Foundation/Foundation.h>

@interface client_vehicle_configurator : NSObject<NSCopying, NSMutableCopying>

@property (nonatomic, strong) NSNumber * vehicle_configurator_id;
@property (nonatomic, strong) NSNumber * vehicle_class_id;
@property (nonatomic, strong) NSString * vehicle_code;
@property (nonatomic, strong) NSString * item_code;
@property (nonatomic, strong) NSString * item_model;
@property (nonatomic, strong) NSNumber * vehicle_pca_version;
@property (nonatomic, strong) NSString * display_name;
@property (nonatomic, strong) NSString * engine_model;
@property (nonatomic, strong) NSString * vehicle_series;
@property (nonatomic, strong) NSString * vehicle_asses_type_rank;
@property (nonatomic, strong) NSString * is_air_suspension;
@property (nonatomic, strong) NSString * vehicle_suspension_type;
@property (nonatomic, strong) NSString * rank_seat;
@property (nonatomic, strong) NSString * vehicle_fuel;
@property (nonatomic, strong) NSString * vehicle_passenger_door;
@property (nonatomic, strong) NSNumber * vehicle_body_struct;
@property (nonatomic, strong) NSString * vehicle_desc;
@property (nonatomic, strong) NSString * vehicle_remark;
@property (nonatomic, strong) NSString * vehicle_tech_desc;
@property (nonatomic, strong) NSString * search_text;
@property (nonatomic, strong) NSNumber * click_count;
@property (nonatomic, strong) NSNumber * data_version;

@property (nonatomic, strong) NSString * image_url;
@property (nonatomic, strong) NSNumber * image_data_version;

@end