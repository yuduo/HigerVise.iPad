#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "BaseInfo.h"
#import "client_vehicle_edition_setting.h"

@interface client_vehicle_edition_setting_dal: NSObject

+ (NSNumber *)getMaxId;
+ (BOOL)exists:(NSNumber *)vehicle_edition_setting_id;
+ (BOOL)add:(client_vehicle_edition_setting *)model;
+ (BOOL)update:(client_vehicle_edition_setting *)model;
+ (BOOL)delete:(NSNumber *)vehicle_edition_setting_id;
+ (BOOL)deleteList:(NSString *)where;
+ (client_vehicle_edition_setting *)get:(NSNumber *)vehicle_edition_setting_id;
+ (NSArray *)getList:(NSString *)where;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order top:(NSInteger)top;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order beginIndex:(NSInteger)beginIndex length:(NSInteger)length;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order page:(NSInteger)page pageSize:(NSInteger)pageSize;
+ (client_vehicle_edition_setting *)convertJsonToModel:(NSDictionary *)json;
+ (NSArray *)convertJsonToList:(NSArray *)jsons;

+ (NSArray *)getListForPriceTable:(NSString *)where;
+ (NSArray *)getListForPriceTable:(NSString *)where db:(FMDatabase *)db;

@end