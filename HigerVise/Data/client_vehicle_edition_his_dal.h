#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "BaseInfo.h"
#import "client_vehicle_edition_his.h"

@interface client_vehicle_edition_his_dal: NSObject

+ (NSNumber *)getMaxId;
+ (BOOL)exists:(NSNumber *)vehicle_edition_id;
+ (BOOL)add:(client_vehicle_edition_his *)model;
+ (BOOL)update:(client_vehicle_edition_his *)model;
+ (BOOL)delete:(NSNumber *)vehicle_edition_id;
+ (BOOL)deleteList:(NSString *)where;
+ (client_vehicle_edition_his *)get:(NSNumber *)vehicle_edition_id;
+ (NSArray *)getList:(NSString *)where;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order top:(NSInteger)top;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order beginIndex:(NSInteger)beginIndex length:(NSInteger)length;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order page:(NSInteger)page pageSize:(NSInteger)pageSize;
+ (client_vehicle_edition_his *)convertJsonToModel:(NSDictionary *)json;
+ (NSArray *)convertJsonToList:(NSArray *)jsons;

+ (NSArray *)getListForIndex:(NSString *)where order:(NSString *)order top:(NSInteger)top;
+ (NSArray *)getListForPriceTable:(NSString *)where order:(NSString *)order;
+ (NSNumber *)getMaxId:(FMDatabase *)db;

@end