#import <Foundation/Foundation.h>

@interface client_search_option_relation : NSObject<NSCopying, NSMutableCopying>

@property (nonatomic, strong) NSNumber * search_option_relation_id;
@property (nonatomic, strong) NSNumber * master_search_id;
@property (nonatomic, strong) NSNumber * master_search_option_id;
@property (nonatomic, strong) NSNumber * slave_search_id;
@property (nonatomic, strong) NSNumber * slave_search_option_id;
@property (nonatomic, strong) NSNumber * data_version;

@end