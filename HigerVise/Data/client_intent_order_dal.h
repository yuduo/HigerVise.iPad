#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "BaseInfo.h"
#import "client_intent_order.h"

@interface client_intent_order_dal: NSObject

+ (BOOL)exists:(NSString *)intent_order_id;
+ (BOOL)add:(client_intent_order *)model;
+ (BOOL)update:(client_intent_order *)model;
+ (BOOL)delete:(NSString *)intent_order_id;
+ (BOOL)deleteList:(NSString *)where;
+ (client_intent_order *)get:(NSString *)intent_order_id;
+ (NSArray *)getList:(NSString *)where;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order top:(NSInteger)top;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order beginIndex:(NSInteger)beginIndex length:(NSInteger)length;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order page:(NSInteger)page pageSize:(NSInteger)pageSize;
+ (client_intent_order *)convertJsonToModel:(NSDictionary *)json;
+ (NSArray *)convertJsonToList:(NSArray *)jsons;

@end