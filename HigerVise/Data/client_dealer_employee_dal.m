#import "client_dealer_employee_dal.h"

@implementation client_dealer_employee_dal

+ (BOOL)exists:(NSString *)dealer_employee_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    FMResultSet *result = [db executeQuery:@"SELECT COUNT(dealer_employee_id) FROM client_dealer_employee WHERE dealer_employee_id = ?", dealer_employee_id];
    if ([result next]) {
        int count = [result intForColumnIndex:0];
        if (count == 0) {
            rtn = NO;
        }
        else {
            rtn = YES;
        }
    }
    [db close];
    return rtn;
}

+ (BOOL)add:(client_dealer_employee *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"INSERT INTO client_dealer_employee (dealer_employee_id, dealer_id, dealer_code, dealer_employee_code, dealer_user_id, dealer_user_name, dealer_user_level, dealer_employee_status, data_version) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)", model.dealer_employee_id, model.dealer_id, model.dealer_code, model.dealer_employee_code, model.dealer_user_id, model.dealer_user_name, model.dealer_user_level, model.dealer_employee_status, model.data_version];
    [db close];
    return rtn;
}

+ (BOOL)update:(client_dealer_employee *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"UPDATE client_dealer_employee SET dealer_id = ?, dealer_code = ?, dealer_employee_code = ?, dealer_user_id = ?, dealer_user_name = ?, dealer_user_level = ?, dealer_employee_status = ?, data_version = ? WHERE dealer_employee_id = ?", model.dealer_id, model.dealer_code, model.dealer_employee_code, model.dealer_user_id, model.dealer_user_name, model.dealer_user_level, model.dealer_employee_status, model.data_version, model.dealer_employee_id];
    [db close];
    return rtn;
}

+ (BOOL)delete:(NSString *)dealer_employee_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"DELETE FROM client_dealer_employee WHERE dealer_employee_id = ?", dealer_employee_id];
    [db close];
    return rtn;
}

+ (BOOL)deleteList:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    NSString *strSql = [NSString stringWithFormat:@"DELETE FROM client_dealer_employee WHERE %@", where];
    rtn = [db executeUpdate:strSql];
    [db close];
    return rtn;
}

+ (client_dealer_employee *)get:(NSString *)dealer_employee_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    client_dealer_employee *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT * FROM client_dealer_employee WHERE dealer_employee_id = ?", dealer_employee_id];
    while ([result next]) {
        rtn = [[client_dealer_employee alloc] init];
        rtn.dealer_employee_id = [result stringForColumn:@"dealer_employee_id"];
        rtn.dealer_id = [result stringForColumn:@"dealer_id"];
        rtn.dealer_code = [result stringForColumn:@"dealer_code"];
        rtn.dealer_employee_code = [result stringForColumn:@"dealer_employee_code"];
        rtn.dealer_user_id = [result stringForColumn:@"dealer_user_id"];
        rtn.dealer_user_name = [result stringForColumn:@"dealer_user_name"];
        rtn.dealer_user_level = [result stringForColumn:@"dealer_user_level"];
        rtn.dealer_employee_status = [result stringForColumn:@"dealer_employee_status"];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        break;
    }
    [db close];
    return rtn;
}

+ (NSArray *)getList:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_dealer_employee WHERE %@", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_dealer_employee *rtn = [[client_dealer_employee alloc] init];
        rtn.dealer_employee_id = [result stringForColumn:@"dealer_employee_id"];
        rtn.dealer_id = [result stringForColumn:@"dealer_id"];
        rtn.dealer_code = [result stringForColumn:@"dealer_code"];
        rtn.dealer_employee_code = [result stringForColumn:@"dealer_employee_code"];
        rtn.dealer_user_id = [result stringForColumn:@"dealer_user_id"];
        rtn.dealer_user_name = [result stringForColumn:@"dealer_user_name"];
        rtn.dealer_user_level = [result stringForColumn:@"dealer_user_level"];
        rtn.dealer_employee_status = [result stringForColumn:@"dealer_employee_status"];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (NSArray *)getList:(NSString *)where order:(NSString *)order
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_dealer_employee WHERE %@ ORDER BY %@", where, order];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_dealer_employee *rtn = [[client_dealer_employee alloc] init];
        rtn.dealer_employee_id = [result stringForColumn:@"dealer_employee_id"];
        rtn.dealer_id = [result stringForColumn:@"dealer_id"];
        rtn.dealer_code = [result stringForColumn:@"dealer_code"];
        rtn.dealer_employee_code = [result stringForColumn:@"dealer_employee_code"];
        rtn.dealer_user_id = [result stringForColumn:@"dealer_user_id"];
        rtn.dealer_user_name = [result stringForColumn:@"dealer_user_name"];
        rtn.dealer_user_level = [result stringForColumn:@"dealer_user_level"];
        rtn.dealer_employee_status = [result stringForColumn:@"dealer_employee_status"];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (NSArray *)getList:(NSString *)where order:(NSString *)order top:(NSInteger)top
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_dealer_employee WHERE %@ ORDER BY %@ LIMIT 0,%d", where, order, top];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_dealer_employee *rtn = [[client_dealer_employee alloc] init];
        rtn.dealer_employee_id = [result stringForColumn:@"dealer_employee_id"];
        rtn.dealer_id = [result stringForColumn:@"dealer_id"];
        rtn.dealer_code = [result stringForColumn:@"dealer_code"];
        rtn.dealer_employee_code = [result stringForColumn:@"dealer_employee_code"];
        rtn.dealer_user_id = [result stringForColumn:@"dealer_user_id"];
        rtn.dealer_user_name = [result stringForColumn:@"dealer_user_name"];
        rtn.dealer_user_level = [result stringForColumn:@"dealer_user_level"];
        rtn.dealer_employee_status = [result stringForColumn:@"dealer_employee_status"];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (NSArray *)getList:(NSString *)where order:(NSString *)order beginIndex:(NSInteger)beginIndex length:(NSInteger)length
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_dealer_employee WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_dealer_employee *rtn = [[client_dealer_employee alloc] init];
        rtn.dealer_employee_id = [result stringForColumn:@"dealer_employee_id"];
        rtn.dealer_id = [result stringForColumn:@"dealer_id"];
        rtn.dealer_code = [result stringForColumn:@"dealer_code"];
        rtn.dealer_employee_code = [result stringForColumn:@"dealer_employee_code"];
        rtn.dealer_user_id = [result stringForColumn:@"dealer_user_id"];
        rtn.dealer_user_name = [result stringForColumn:@"dealer_user_name"];
        rtn.dealer_user_level = [result stringForColumn:@"dealer_user_level"];
        rtn.dealer_employee_status = [result stringForColumn:@"dealer_employee_status"];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (NSArray *)getList:(NSString *)where order:(NSString *)order page:(NSInteger)page pageSize:(NSInteger)pageSize
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSInteger beginIndex = (page - 1) * pageSize;
    NSInteger length = pageSize;
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_dealer_employee WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_dealer_employee *rtn = [[client_dealer_employee alloc] init];
        rtn.dealer_employee_id = [result stringForColumn:@"dealer_employee_id"];
        rtn.dealer_id = [result stringForColumn:@"dealer_id"];
        rtn.dealer_code = [result stringForColumn:@"dealer_code"];
        rtn.dealer_employee_code = [result stringForColumn:@"dealer_employee_code"];
        rtn.dealer_user_id = [result stringForColumn:@"dealer_user_id"];
        rtn.dealer_user_name = [result stringForColumn:@"dealer_user_name"];
        rtn.dealer_user_level = [result stringForColumn:@"dealer_user_level"];
        rtn.dealer_employee_status = [result stringForColumn:@"dealer_employee_status"];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (client_dealer_employee *)convertJsonToModel:(NSDictionary *)json
{
    client_dealer_employee *model = [[client_dealer_employee alloc] init];
    model.dealer_employee_id = [json objectForKey:@"dealer_employee_id"];
    model.dealer_id = [json objectForKey:@"dealer_id"];
    model.dealer_code = [json objectForKey:@"dealer_code"];
    model.dealer_employee_code = [json objectForKey:@"dealer_employee_code"];
    model.dealer_user_id = [json objectForKey:@"dealer_user_id"];
    model.dealer_user_name = [json objectForKey:@"dealer_user_name"];
    model.dealer_user_level = [json objectForKey:@"dealer_user_level"];
    model.dealer_employee_status = [json objectForKey:@"dealer_employee_status"];
    model.data_version = [json objectForKey:@"data_version"];
    return model;
}

+ (NSArray *)convertJsonToList:(NSArray *)jsons
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *json in jsons) {
        client_dealer_employee *model = [[client_dealer_employee alloc] init];
        model.dealer_employee_id = [json objectForKey:@"dealer_employee_id"];
        model.dealer_id = [json objectForKey:@"dealer_id"];
        model.dealer_code = [json objectForKey:@"dealer_code"];
        model.dealer_employee_code = [json objectForKey:@"dealer_employee_code"];
        model.dealer_user_id = [json objectForKey:@"dealer_user_id"];
        model.dealer_user_name = [json objectForKey:@"dealer_user_name"];
        model.dealer_user_level = [json objectForKey:@"dealer_user_level"];
        model.dealer_employee_status = [json objectForKey:@"dealer_employee_status"];
        model.data_version = [json objectForKey:@"data_version"];
        [array addObject:model];
    }
    return array;
}

@end