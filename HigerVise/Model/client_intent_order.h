#import <Foundation/Foundation.h>

@interface client_intent_order : NSObject

@property (nonatomic, strong) NSString * intent_order_id;
@property (nonatomic, strong) NSString * customer_id;
@property (nonatomic, strong) NSString * dealer_id;
@property (nonatomic, strong) NSString * intent_order_code;
@property (nonatomic, strong) NSString * customer_code;
@property (nonatomic, strong) NSString * dealer_code;
@property (nonatomic, strong) NSNumber * vehicle_configurator_id;
@property (nonatomic, strong) NSString * vehicle_code;
@property (nonatomic, strong) NSString * vehicle_item_code;
@property (nonatomic, strong) NSString * vehicle_item_model;
@property (nonatomic, strong) NSString * vehicle_series;
@property (nonatomic, strong) NSNumber * vehicle_pca_version;
@property (nonatomic, strong) NSNumber * vehicle_edition_id;
@property (nonatomic, strong) NSNumber * vehicle_edition_editionid;
@property (nonatomic, strong) NSNumber * vehicle_edition_type;
@property (nonatomic, strong) NSString * big_region_code;
@property (nonatomic, strong) NSString * market_code;
@property (nonatomic, strong) NSString * area_region_code;
@property (nonatomic, strong) NSString * city_region_code;
@property (nonatomic, strong) NSString * city_region_name;
@property (nonatomic, strong) NSString * sale_empid;
@property (nonatomic, strong) NSString * sale_empname;
@property (nonatomic, strong) NSString * region_sale_empid;
@property (nonatomic, strong) NSString * region_sale_empname;
@property (nonatomic, strong) NSString * intent_from;
@property (nonatomic, strong) NSString * intent_use;
@property (nonatomic, strong) NSNumber * intent_qty;
@property (nonatomic, strong) NSString * intent_mode;
@property (nonatomic, strong) NSString * intent_delivery_date;
@property (nonatomic, strong) NSString * intent_last_date;
@property (nonatomic, strong) NSString * intent_publish_date;
@property (nonatomic, strong) NSString * intent_buy_channel;
@property (nonatomic, strong) NSString * intent_class;
@property (nonatomic, strong) NSNumber * intent_is_sign;
@property (nonatomic, strong) NSString * intent_remark;
@property (nonatomic, strong) NSString * intent_status;
@property (nonatomic, strong) NSNumber * is_send;
@property (nonatomic, strong) NSNumber * is_used;
@property (nonatomic, strong) NSDate * create_time;
@property (nonatomic, strong) NSString * create_userid;
@property (nonatomic, strong) NSDate * update_time;
@property (nonatomic, strong) NSString * update_userid;
@property (nonatomic, strong) NSNumber * data_version;
@property (nonatomic, strong) NSNumber * data_status;

@end