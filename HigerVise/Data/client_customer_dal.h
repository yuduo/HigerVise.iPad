#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "BaseInfo.h"
#import "client_customer.h"

@interface client_customer_dal: NSObject

+ (BOOL)exists:(NSString *)customer_id;
+ (BOOL)add:(client_customer *)model;
+ (BOOL)update:(client_customer *)model;
+ (BOOL)delete:(NSString *)customer_id;
+ (BOOL)deleteList:(NSString *)where;
+ (client_customer *)get:(NSString *)customer_id;
+ (NSArray *)getList:(NSString *)where;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order top:(NSInteger)top;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order beginIndex:(NSInteger)beginIndex length:(NSInteger)length;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order page:(NSInteger)page pageSize:(NSInteger)pageSize;
+ (client_customer *)convertJsonToModel:(NSDictionary *)json;
+ (NSArray *)convertJsonToList:(NSArray *)jsons;

@end