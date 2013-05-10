#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "BaseInfo.h"
#import "client_search_option.h"

@interface client_search_option_dal: NSObject

+ (NSNumber *)getMaxId;
+ (BOOL)exists:(NSNumber *)search_option_id;
+ (BOOL)add:(client_search_option *)model;
+ (BOOL)update:(client_search_option *)model;
+ (BOOL)delete:(NSNumber *)search_option_id;
+ (BOOL)deleteList:(NSString *)where;
+ (client_search_option *)get:(NSNumber *)search_option_id;
+ (NSArray *)getList:(NSString *)where;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order top:(NSInteger)top;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order beginIndex:(NSInteger)beginIndex length:(NSInteger)length;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order page:(NSInteger)page pageSize:(NSInteger)pageSize;
+ (client_search_option *)convertJsonToModel:(NSDictionary *)json;
+ (NSArray *)convertJsonToList:(NSArray *)jsons;

+ (NSArray *)getListByVehcileClass:(NSInteger)vehicle_class_id 
                        field_name:(NSString *)field_name 
                   slave_search_id:(NSInteger)slave_search_id;
+ (NSArray *)getListByMasterSearchOption:(NSInteger)master_search_option_id 
                         slave_search_id:(NSInteger)slave_search_id;
+ (NSArray *)getListForSearch:(NSString *)where;

@end