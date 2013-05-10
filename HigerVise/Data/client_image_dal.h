#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "BaseInfo.h"
#import "client_image.h"

@interface client_image_dal: NSObject

+ (NSNumber *)getMaxId;
+ (BOOL)exists:(NSNumber *)image_id;
+ (BOOL)add:(client_image *)model;
+ (BOOL)update:(client_image *)model;
+ (BOOL)delete:(NSNumber *)image_id;
+ (BOOL)deleteList:(NSString *)where;
+ (client_image *)get:(NSNumber *)image_id;
+ (NSArray *)getList:(NSString *)where;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order top:(NSInteger)top;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order beginIndex:(NSInteger)beginIndex length:(NSInteger)length;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order page:(NSInteger)page pageSize:(NSInteger)pageSize;
+ (client_image *)convertJsonToModel:(NSDictionary *)json;
+ (NSArray *)convertJsonToList:(NSArray *)jsons;

+ (NSArray *)getGroupForCarColor:(NSString *)where;
+ (NSArray *)getListForCarColor:(NSString *)where;

@end