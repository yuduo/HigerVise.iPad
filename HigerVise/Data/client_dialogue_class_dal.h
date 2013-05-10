#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "BaseInfo.h"
#import "client_dialogue_class.h"

@interface client_dialogue_class_dal: NSObject

+ (NSNumber *)getMaxId;
+ (BOOL)exists:(NSNumber *)dialogue_class_id;
+ (BOOL)add:(client_dialogue_class *)model;
+ (BOOL)update:(client_dialogue_class *)model;
+ (BOOL)delete:(NSNumber *)dialogue_class_id;
+ (BOOL)deleteList:(NSString *)where;
+ (client_dialogue_class *)get:(NSNumber *)dialogue_class_id;
+ (NSArray *)getList:(NSString *)where;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order top:(NSInteger)top;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order beginIndex:(NSInteger)beginIndex length:(NSInteger)length;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order page:(NSInteger)page pageSize:(NSInteger)pageSize;
+ (client_dialogue_class *)convertJsonToModel:(NSDictionary *)json;
+ (NSArray *)convertJsonToList:(NSArray *)jsons;

@end