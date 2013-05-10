#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "BaseInfo.h"
#import "client_user_vehicle_relation.h"

@interface client_user_vehicle_relation_dal: NSObject

+ (NSNumber *)getMaxId;
+ (BOOL)exists:(NSNumber *)user_vehicle_relation_id;
+ (BOOL)add:(client_user_vehicle_relation *)model;
+ (BOOL)update:(client_user_vehicle_relation *)model;
+ (BOOL)delete:(NSNumber *)user_vehicle_relation_id;
+ (BOOL)deleteList:(NSString *)where;
+ (client_user_vehicle_relation *)get:(NSNumber *)user_vehicle_relation_id;
+ (NSArray *)getList:(NSString *)where;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order top:(NSInteger)top;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order beginIndex:(NSInteger)beginIndex length:(NSInteger)length;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order page:(NSInteger)page pageSize:(NSInteger)pageSize;
+ (client_user_vehicle_relation *)convertJsonToModel:(NSDictionary *)json;
+ (NSArray *)convertJsonToList:(NSArray *)jsons;

@end