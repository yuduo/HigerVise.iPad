#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "BaseInfo.h"
#import "client_system_version.h"

@interface client_system_version_dal: NSObject

+ (NSNumber *)getMaxId;
+ (BOOL)exists:(NSNumber *)system_version_id;
+ (BOOL)add:(client_system_version *)model;
+ (BOOL)update:(client_system_version *)model;
+ (BOOL)delete:(NSNumber *)system_version_id;
+ (BOOL)deleteList:(NSString *)where;
+ (client_system_version *)get:(NSNumber *)system_version_id;
+ (NSArray *)getList:(NSString *)where;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order top:(NSInteger)top;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order beginIndex:(NSInteger)beginIndex length:(NSInteger)length;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order page:(NSInteger)page pageSize:(NSInteger)pageSize;
+ (client_system_version *)convertJsonToModel:(NSDictionary *)json;
+ (NSArray *)convertJsonToList:(NSArray *)jsons;

+ (NSArray *)getListForIndex:(NSString *)where;

@end