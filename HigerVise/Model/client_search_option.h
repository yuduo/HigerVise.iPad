#import <Foundation/Foundation.h>

@interface client_search_option : NSObject<NSCopying, NSMutableCopying>

@property (nonatomic, strong) NSNumber * search_option_id;
@property (nonatomic, strong) NSNumber * search_id;
@property (nonatomic, strong) NSNumber * vehicle_class_id;
@property (nonatomic, strong) NSString * display_name;
@property (nonatomic, strong) NSString * field_value;
@property (nonatomic, strong) NSNumber * data_version;

@property (nonatomic, strong) NSDictionary * search_option_relations;
@property (nonatomic, strong) NSArray * search_option_setting_relations;
@property (nonatomic, strong) NSNumber * is_selected;

@end