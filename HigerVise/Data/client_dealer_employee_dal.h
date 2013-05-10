#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "BaseInfo.h"
#import "client_dealer_employee.h"

@interface client_dealer_employee_dal: NSObject

+ (BOOL)exists:(NSString *)dealer_employee_id;
+ (BOOL)add:(client_dealer_employee *)model;
+ (BOOL)update:(client_dealer_employee *)model;
+ (BOOL)delete:(NSString *)dealer_employee_id;
+ (BOOL)deleteList:(NSString *)where;
+ (client_dealer_employee *)get:(NSString *)dealer_employee_id;
+ (NSArray *)getList:(NSString *)where;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order top:(NSInteger)top;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order beginIndex:(NSInteger)beginIndex length:(NSInteger)length;
+ (NSArray *)getList:(NSString *)where order:(NSString *)order page:(NSInteger)page pageSize:(NSInteger)pageSize;
+ (client_dealer_employee *)convertJsonToModel:(NSDictionary *)json;
+ (NSArray *)convertJsonToList:(NSArray *)jsons;

@end