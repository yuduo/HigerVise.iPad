#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "BaseInfo.h"
#import "client_vehicle_edition.h"

@interface client_vehicle_edition_dal: NSObject

+ (NSNumber *)getMaxId;
+ (BOOL)exists:(NSNumber *)vehicle_edition_id;
+ (BOOL)add:(client_vehicle_edition *)model;
+ (BOOL)update:(client_vehicle_edition *)model;
+ (BOOL)delete:(NSNumber *)vehicle_edition_id;
+ (BOOL)deleteList:(NSString *)where;
+ (client_vehicle_edition *)get:(NSNumber *)vehicle_edition_id;
+ (NSArray *)getList:(NSString *)where;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order top:(NSInteger)top;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order beginIndex:(NSInteger)beginIndex length:(NSInteger)length;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order page:(NSInteger)page pageSize:(NSInteger)pageSize;
+ (client_vehicle_edition *)convertJsonToModel:(NSDictionary *)json;
+ (NSArray *)convertJsonToList:(NSArray *)jsons;

+ (NSArray *)getListForPriceTable:(NSString *)where order:(NSString *)order;

@end