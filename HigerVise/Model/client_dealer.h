#import <Foundation/Foundation.h>

@interface client_dealer : NSObject

@property (nonatomic, strong) NSString * dealer_id;
@property (nonatomic, strong) NSString * dealer_code;
@property (nonatomic, strong) NSString * dealer_name;
@property (nonatomic, strong) NSString * dealer_name_brief;
@property (nonatomic, strong) NSString * declare_class_id;
@property (nonatomic, strong) NSString * dealer_address;
@property (nonatomic, strong) NSString * global_region_code;
@property (nonatomic, strong) NSString * nation_region_code;
@property (nonatomic, strong) NSString * city_region_code;
@property (nonatomic, strong) NSString * dealer_trade_code;
@property (nonatomic, strong) NSString * dealer_status;
@property (nonatomic, strong) NSNumber * data_version;

@end