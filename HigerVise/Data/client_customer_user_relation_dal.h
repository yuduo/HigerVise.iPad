#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "BaseInfo.h"
#import "client_customer_user_relation.h"

@interface client_customer_user_relation_dal: NSObject

+ (NSNumber *)getMaxId;
+ (BOOL)exists:(NSNumber *)customer_user_relation_id;
+ (BOOL)add:(client_customer_user_relation *)model;
+ (BOOL)update:(client_customer_user_relation *)model;
+ (BOOL)delete:(NSNumber *)customer_user_relation_id;
+ (BOOL)deleteList:(NSString *)where;
+ (client_customer_user_relation *)get:(NSNumber *)customer_user_relation_id;
+ (NSArray *)getList:(NSString *)where;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order top:(NSInteger)top;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order beginIndex:(NSInteger)beginIndex length:(NSInteger)length;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order page:(NSInteger)page pageSize:(NSInteger)pageSize;
+ (client_customer_user_relation *)convertJsonToModel:(NSDictionary *)json;
+ (NSArray *)convertJsonToList:(NSArray *)jsons;

@end