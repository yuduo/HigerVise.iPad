#import <Foundation/Foundation.h>

@interface client_vehicle_edition : NSObject

@property (nonatomic, strong) NSNumber * vehicle_edition_id;
@property (nonatomic, strong) NSNumber * vehicle_configurator_id;
@property (nonatomic, strong) NSString * vehicle_code;
@property (nonatomic, strong) NSNumber * edition_id;
@property (nonatomic, strong) NSNumber * edition_type;
@property (nonatomic, strong) NSString * display_name;
@property (nonatomic, strong) NSString * edition_title;
@property (nonatomic, strong) NSNumber * std_price;
@property (nonatomic, strong) NSNumber * sale_price;
@property (nonatomic, strong) NSNumber * del_price;
@property (nonatomic, strong) NSNumber * customer_price;
@property (nonatomic, strong) NSNumber * base_price;
@property (nonatomic, strong) NSString * edition_desc;
@property (nonatomic, strong) NSString * edition_remark;
@property (nonatomic, strong) NSString * edition_tech_desc;
@property (nonatomic, strong) NSNumber * data_version;

@end