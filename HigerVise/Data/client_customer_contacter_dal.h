#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "BaseInfo.h"
#import "client_customer_contacter.h"

@interface client_customer_contacter_dal: NSObject

+ (BOOL)exists:(NSString *)contacter_id;
+ (BOOL)add:(client_customer_contacter *)model;
+ (BOOL)update:(client_customer_contacter *)model;
+ (BOOL)delete:(NSString *)contacter_id;
+ (BOOL)deleteList:(NSString *)where;
+ (client_customer_contacter *)get:(NSString *)contacter_id;
+ (NSArray *)getList:(NSString *)where;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order top:(NSInteger)top;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order beginIndex:(NSInteger)beginIndex length:(NSInteger)length;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order page:(NSInteger)page pageSize:(NSInteger)pageSize;
+ (client_customer_contacter *)convertJsonToModel:(NSDictionary *)json;
+ (NSArray *)convertJsonToList:(NSArray *)jsons;

@end