#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "BaseInfo.h"
#import "client_dealer.h"

@interface client_dealer_dal: NSObject

+ (BOOL)exists:(NSString *)dealer_id;
+ (BOOL)add:(client_dealer *)model;
+ (BOOL)update:(client_dealer *)model;
+ (BOOL)delete:(NSString *)dealer_id;
+ (BOOL)deleteList:(NSString *)where;
+ (client_dealer *)get:(NSString *)dealer_id;
+ (NSArray *)getList:(NSString *)where;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order top:(NSInteger)top;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order beginIndex:(NSInteger)beginIndex length:(NSInteger)length;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order page:(NSInteger)page pageSize:(NSInteger)pageSize;
+ (client_dealer *)convertJsonToModel:(NSDictionary *)json;
+ (NSArray *)convertJsonToList:(NSArray *)jsons;

@end