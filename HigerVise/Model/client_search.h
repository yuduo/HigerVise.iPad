#import <Foundation/Foundation.h>

@interface client_search : NSObject<NSCopying, NSMutableCopying>

@property (nonatomic, strong) NSNumber * search_id;
@property (nonatomic, strong) NSString * display_name;
@property (nonatomic, strong) NSString * field_name;
@property (nonatomic, strong) NSNumber * field_type;
@property (nonatomic, strong) NSNumber * search_type;
@property (nonatomic, strong) NSNumber * search_index;
@property (nonatomic, strong) NSNumber * data_version;

@property (nonatomic, strong) NSArray * search_options;

@end