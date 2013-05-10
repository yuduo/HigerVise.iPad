#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "BaseInfo.h"
#import "client_dialogue_detail.h"

@interface client_dialogue_detail_dal: NSObject

+ (BOOL)exists:(NSString *)dialogue_detail_id;
+ (BOOL)add:(client_dialogue_detail *)model;
+ (BOOL)update:(client_dialogue_detail *)model;
+ (BOOL)delete:(NSString *)dialogue_detail_id;
+ (BOOL)deleteList:(NSString *)where;
+ (client_dialogue_detail *)get:(NSString *)dialogue_detail_id;
+ (NSArray *)getList:(NSString *)where;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order top:(NSInteger)top;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order beginIndex:(NSInteger)beginIndex length:(NSInteger)length;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order page:(NSInteger)page pageSize:(NSInteger)pageSize;
+ (client_dialogue_detail *)convertJsonToModel:(NSDictionary *)json;
+ (NSArray *)convertJsonToList:(NSArray *)jsons;

@end