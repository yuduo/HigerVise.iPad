#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "BaseInfo.h"
#import "client_vehicle_hot.h"

@interface client_vehicle_hot_dal: NSObject

+ (NSNumber *)getMaxId;
+ (BOOL)exists:(NSNumber *)vehicle_hot_id;
+ (BOOL)add:(client_vehicle_hot *)model;
+ (BOOL)update:(client_vehicle_hot *)model;
+ (BOOL)delete:(NSNumber *)vehicle_hot_id;
+ (BOOL)deleteList:(NSString *)where;
+ (client_vehicle_hot *)get:(NSNumber *)vehicle_hot_id;
+ (NSArray *)getList:(NSString *)where;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order top:(NSInteger)top;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order beginIndex:(NSInteger)beginIndex length:(NSInteger)length;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order page:(NSInteger)page pageSize:(NSInteger)pageSize;
+ (client_vehicle_hot *)convertJsonToModel:(NSDictionary *)json;
+ (NSArray *)convertJsonToList:(NSArray *)jsons;

@end