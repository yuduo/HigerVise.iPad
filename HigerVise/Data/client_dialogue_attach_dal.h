#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "BaseInfo.h"
#import "client_dialogue_attach.h"

@interface client_dialogue_attach_dal: NSObject

+ (BOOL)exists:(NSString *)dialogue_attach_id;
+ (BOOL)add:(client_dialogue_attach *)model;
+ (BOOL)update:(client_dialogue_attach *)model;
+ (BOOL)delete:(NSString *)dialogue_attach_id;
+ (BOOL)deleteList:(NSString *)where;
+ (client_dialogue_attach *)get:(NSString *)dialogue_attach_id;
+ (NSArray *)getList:(NSString *)where;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order top:(NSInteger)top;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order beginIndex:(NSInteger)beginIndex length:(NSInteger)length;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order page:(NSInteger)page pageSize:(NSInteger)pageSize;
+ (client_dialogue_attach *)convertJsonToModel:(NSDictionary *)json;
+ (NSArray *)convertJsonToList:(NSArray *)jsons;

@end