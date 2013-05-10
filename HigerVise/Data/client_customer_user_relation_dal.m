#import "client_customer_user_relation_dal.h"

@implementation client_customer_user_relation_dal

+ (NSNumber *)getMaxId
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSNumber *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT MAX(customer_user_relation_id) FROM client_customer_user_relation"];
    if ([result next]) {
        int maxId = [result intForColumnIndex:0] + 1;
        rtn = [NSNumber numberWithInt:maxId];
    }
    [db close];
    return rtn;
}

+ (BOOL)exists:(NSNumber *)customer_user_relation_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    FMResultSet *result = [db executeQuery:@"SELECT COUNT(customer_user_relation_id) FROM client_customer_user_relation WHERE customer_user_relation_id = ?", customer_user_relation_id];
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

+ (BOOL)add:(client_customer_user_relation *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"INSERT INTO client_customer_user_relation (customer_user_relation_id, customer_id, customer_code, user_id, user_name, create_time, create_userid, data_version) VALUES (?, ?, ?, ?, ?, ?, ?, ?)", model.customer_user_relation_id, model.customer_id, model.customer_code, model.user_id, model.user_name, model.create_time, model.create_userid, model.data_version];
    [db close];
    return rtn;
}

+ (BOOL)update:(client_customer_user_relation *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"UPDATE client_customer_user_relation SET customer_id = ?, customer_code = ?, user_id = ?, user_name = ?, create_time = ?, create_userid = ?, data_version = ? WHERE customer_user_relation_id = ?", model.customer_id, model.customer_code, model.user_id, model.user_name, model.create_time, model.create_userid, model.data_version, model.customer_user_relation_id];
    [db close];
    return rtn;
}

+ (BOOL)delete:(NSNumber *)customer_user_relation_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"DELETE FROM client_customer_user_relation WHERE customer_user_relation_id = ?", customer_user_relation_id];
    [db close];
    return rtn;
}

+ (BOOL)deleteList:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    NSString *strSql = [NSString stringWithFormat:@"DELETE FROM client_customer_user_relation WHERE %@", where];
    rtn = [db executeUpdate:strSql];
    [db close];
    return rtn;
}

+ (client_customer_user_relation *)get:(NSNumber *)customer_user_relation_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    client_customer_user_relation *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT * FROM client_customer_user_relation WHERE customer_user_relation_id = ?", customer_user_relation_id];
    while ([result next]) {
        rtn = [[client_customer_user_relation alloc] init];
        rtn.customer_user_relation_id = [NSNumber numberWithInt:[result intForColumn:@"customer_user_relation_id"]];
        rtn.customer_id = [result stringForColumn:@"customer_id"];
        rtn.customer_code = [result stringForColumn:@"customer_code"];
        rtn.user_id = [NSNumber numberWithInt:[result intForColumn:@"user_id"]];
        rtn.user_name = [result stringForColumn:@"user_name"];
        rtn.create_time = [result dateForColumn:@"create_time"];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_customer_user_relation WHERE %@", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_customer_user_relation *rtn = [[client_customer_user_relation alloc] init];
        rtn.customer_user_relation_id = [NSNumber numberWithInt:[result intForColumn:@"customer_user_relation_id"]];
        rtn.customer_id = [result stringForColumn:@"customer_id"];
        rtn.customer_code = [result stringForColumn:@"customer_code"];
        rtn.user_id = [NSNumber numberWithInt:[result intForColumn:@"user_id"]];
        rtn.user_name = [result stringForColumn:@"user_name"];
        rtn.create_time = [result dateForColumn:@"create_time"];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_customer_user_relation WHERE %@ ORDER BY %@", where, order];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_customer_user_relation *rtn = [[client_customer_user_relation alloc] init];
        rtn.customer_user_relation_id = [NSNumber numberWithInt:[result intForColumn:@"customer_user_relation_id"]];
        rtn.customer_id = [result stringForColumn:@"customer_id"];
        rtn.customer_code = [result stringForColumn:@"customer_code"];
        rtn.user_id = [NSNumber numberWithInt:[result intForColumn:@"user_id"]];
        rtn.user_name = [result stringForColumn:@"user_name"];
        rtn.create_time = [result dateForColumn:@"create_time"];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_customer_user_relation WHERE %@ ORDER BY %@ LIMIT 0,%d", where, order, top];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_customer_user_relation *rtn = [[client_customer_user_relation alloc] init];
        rtn.customer_user_relation_id = [NSNumber numberWithInt:[result intForColumn:@"customer_user_relation_id"]];
        rtn.customer_id = [result stringForColumn:@"customer_id"];
        rtn.customer_code = [result stringForColumn:@"customer_code"];
        rtn.user_id = [NSNumber numberWithInt:[result intForColumn:@"user_id"]];
        rtn.user_name = [result stringForColumn:@"user_name"];
        rtn.create_time = [result dateForColumn:@"create_time"];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_customer_user_relation WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_customer_user_relation *rtn = [[client_customer_user_relation alloc] init];
        rtn.customer_user_relation_id = [NSNumber numberWithInt:[result intForColumn:@"customer_user_relation_id"]];
        rtn.customer_id = [result stringForColumn:@"customer_id"];
        rtn.customer_code = [result stringForColumn:@"customer_code"];
        rtn.user_id = [NSNumber numberWithInt:[result intForColumn:@"user_id"]];
        rtn.user_name = [result stringForColumn:@"user_name"];
        rtn.create_time = [result dateForColumn:@"create_time"];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_customer_user_relation WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_customer_user_relation *rtn = [[client_customer_user_relation alloc] init];
        rtn.customer_user_relation_id = [NSNumber numberWithInt:[result intForColumn:@"customer_user_relation_id"]];
        rtn.customer_id = [result stringForColumn:@"customer_id"];
        rtn.customer_code = [result stringForColumn:@"customer_code"];
        rtn.user_id = [NSNumber numberWithInt:[result intForColumn:@"user_id"]];
        rtn.user_name = [result stringForColumn:@"user_name"];
        rtn.create_time = [result dateForColumn:@"create_time"];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (client_customer_user_relation *)convertJsonToModel:(NSDictionary *)json
{
    client_customer_user_relation *model = [[client_customer_user_relation alloc] init];
    model.customer_user_relation_id = [json objectForKey:@"customer_user_relation_id"];
    model.customer_id = [json objectForKey:@"customer_id"];
    model.customer_code = [json objectForKey:@"customer_code"];
    model.user_id = [json objectForKey:@"user_id"];
    model.user_name = [json objectForKey:@"user_name"];
    model.create_time =[BaseInfo getDateFromMSDateString:[json objectForKey:@"create_time"]];
    model.create_userid = [json objectForKey:@"create_userid"];
    model.data_version = [json objectForKey:@"data_version"];
    return model;
}

+ (NSArray *)convertJsonToList:(NSArray *)jsons
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *json in jsons) {
        client_customer_user_relation *model = [[client_customer_user_relation alloc] init];
        model.customer_user_relation_id = [json objectForKey:@"customer_user_relation_id"];
        model.customer_id = [json objectForKey:@"customer_id"];
        model.customer_code = [json objectForKey:@"customer_code"];
        model.user_id = [json objectForKey:@"user_id"];
        model.user_name = [json objectForKey:@"user_name"];
        model.create_time =[BaseInfo getDateFromMSDateString:[json objectForKey:@"create_time"]];
        model.create_userid = [json objectForKey:@"create_userid"];
        model.data_version = [json objectForKey:@"data_version"];
        [array addObject:model];
    }
    return array;
}

@end