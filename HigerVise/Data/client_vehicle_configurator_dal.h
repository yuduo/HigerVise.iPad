#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "BaseInfo.h"
#import "client_vehicle_configurator.h"

@interface client_vehicle_configurator_dal: NSObject

+ (NSNumber *)getMaxId;
+ (BOOL)exists:(NSNumber *)vehicle_configurator_id;
+ (BOOL)add:(client_vehicle_configurator *)model;
+ (BOOL)update:(client_vehicle_configurator *)model;
+ (BOOL)delete:(NSNumber *)vehicle_configurator_id;
+ (BOOL)deleteList:(NSString *)where;
+ (client_vehicle_configurator *)get:(NSNumber *)vehicle_configurator_id;
+ (NSArray *)getList:(NSString *)where;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order top:(NSInteger)top;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order beginIndex:(NSInteger)beginIndex length:(NSInteger)length;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order page:(NSInteger)page pageSize:(NSInteger)pageSize;
+ (client_vehicle_configurator *)convertJsonToModel:(NSDictionary *)json;
+ (NSArray *)convertJsonToList:(NSArray *)jsons;

+ (NSArray *)getListForPrompt:(NSString *)where;
+ (NSArray *)getListForResult:(NSString *)where;
+ (NSArray *)getListForIndex:(NSString *)where;
+ (NSArray *)getListForResult:(NSString *)where order:(NSString *)order page:(NSInteger)page pageSize:(NSInteger)pageSize;
+ (NSArray *)getListForPriceTableSearchResult:(NSString *)where;
+ (NSArray *)getListForPriceTableSearchPrompt:(NSString *)where;
+ (client_vehicle_configurator *)getForPirceTable:(NSNumber *)vehicle_configurator_id;

@end