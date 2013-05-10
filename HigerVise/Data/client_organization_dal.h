#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "BaseInfo.h"
#import "client_organization.h"

@interface client_organization_dal: NSObject

+ (NSNumber *)getMaxId;
+ (BOOL)exists:(NSNumber *)organization_id;
+ (BOOL)add:(client_organization *)model;
+ (BOOL)update:(client_organization *)model;
+ (BOOL)delete:(NSNumber *)organization_id;
+ (BOOL)deleteList:(NSString *)where;
+ (client_organization *)get:(NSNumber *)organization_id;
+ (NSArray *)getList:(NSString *)where;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order top:(NSInteger)top;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order beginIndex:(NSInteger)beginIndex length:(NSInteger)length;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order page:(NSInteger)page pageSize:(NSInteger)pageSize;
+ (client_organization *)convertJsonToModel:(NSDictionary *)json;
+ (NSArray *)convertJsonToList:(NSArray *)jsons;

@end