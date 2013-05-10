#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "BaseInfo.h"
#import "client_ipad_skin.h"

@interface client_ipad_skin_dal: NSObject

+ (NSNumber *)getMaxId;
+ (BOOL)exists:(NSNumber *)ipad_skin_id;
+ (BOOL)add:(client_ipad_skin *)model;
+ (BOOL)update:(client_ipad_skin *)model;
+ (BOOL)delete:(NSNumber *)ipad_skin_id;
+ (BOOL)deleteList:(NSString *)where;
+ (client_ipad_skin *)get:(NSNumber *)ipad_skin_id;
+ (NSArray *)getList:(NSString *)where;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order top:(NSInteger)top;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order beginIndex:(NSInteger)beginIndex length:(NSInteger)length;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order page:(NSInteger)page pageSize:(NSInteger)pageSize;
+ (client_ipad_skin *)convertJsonToModel:(NSDictionary *)json;
+ (NSArray *)convertJsonToList:(NSArray *)jsons;

@end