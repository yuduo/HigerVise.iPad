#import <Foundation/Foundation.h>

@interface client_intent_order_setting : NSObject

@property (nonatomic, strong) NSString * intent_order_setting_id;
@property (nonatomic, strong) NSString * intent_order_id;
@property (nonatomic, strong) NSString * intent_order_code;
@property (nonatomic, strong) NSNumber * vehicle_edition_setting_id;
@property (nonatomic, strong) NSString * op_code;
@property (nonatomic, strong) NSString * op_group_code;
@property (nonatomic, strong) NSString * op_value_code;
@property (nonatomic, strong) NSNumber * op_value_qty;
@property (nonatomic, strong) NSNumber * op_value_price_diff;
@property (nonatomic, strong) NSNumber * op_value_original_price_diff;
@property (nonatomic, strong) NSNumber * data_version;

@end