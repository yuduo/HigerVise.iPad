#import "client_user_dal.h"

@implementation client_user_dal

+ (NSNumber *)getMaxId
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSNumber *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT MAX(user_id) FROM client_user"];
    if ([result next]) {
        int maxId = [result intForColumnIndex:0] + 1;
        rtn = [NSNumber numberWithInt:maxId];
    }
    [db close];
    return rtn;
}

+ (BOOL)exists:(NSNumber *)user_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    FMResultSet *result = [db executeQuery:@"SELECT COUNT(user_id) FROM client_user WHERE user_id = ?", user_id];
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

+ (BOOL)add:(client_user *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"INSERT INTO client_user (user_id, user_empid, user_name, user_real_name, user_level, user_area, user_area_type, user_type, user_email, user_phone, user_mobile, user_picture_url, data_version) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", model.user_id, model.user_empid, model.user_name, model.user_real_name, model.user_level, model.user_area, model.user_area_type, model.user_type, model.user_email, model.user_phone, model.user_mobile, model.user_picture_url, model.data_version];
    [db close];
    return rtn;
}

+ (BOOL)update:(client_user *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"UPDATE client_user SET user_empid = ?, user_name = ?, user_real_name = ?, user_level = ?, user_area = ?, user_area_type = ?, user_type = ?, user_email = ?, user_phone = ?, user_mobile = ?, user_picture_url = ?, data_version = ? WHERE user_id = ?", model.user_empid, model.user_name, model.user_real_name, model.user_level, model.user_area, model.user_area_type, model.user_type, model.user_email, model.user_phone, model.user_mobile, model.user_picture_url, model.data_version, model.user_id];
    [db close];
    return rtn;
}

+ (BOOL)delete:(NSNumber *)user_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"DELETE FROM client_user WHERE user_id = ?", user_id];
    [db close];
    return rtn;
}

+ (BOOL)deleteList:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    NSString *strSql = [NSString stringWithFormat:@"DELETE FROM client_user WHERE %@", where];
    rtn = [db executeUpdate:strSql];
    [db close];
    return rtn;
}

+ (client_user *)get:(NSNumber *)user_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    client_user *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT * FROM client_user WHERE user_id = ?", user_id];
    while ([result next]) {
        rtn = [[client_user alloc] init];
        rtn.user_id = [NSNumber numberWithInt:[result intForColumn:@"user_id"]];
        rtn.user_empid = [result stringForColumn:@"user_empid"];
        rtn.user_name = [result stringForColumn:@"user_name"];
        rtn.user_real_name = [result stringForColumn:@"user_real_name"];
        rtn.user_level = [result stringForColumn:@"user_level"];
        rtn.user_area = [result stringForColumn:@"user_area"];
        rtn.user_area_type = [NSNumber numberWithInt:[result intForColumn:@"user_area_type"]];
        rtn.user_type = [NSNumber numberWithInt:[result intForColumn:@"user_type"]];
        rtn.user_email = [result stringForColumn:@"user_email"];
        rtn.user_phone = [result stringForColumn:@"user_phone"];
        rtn.user_mobile = [result stringForColumn:@"user_mobile"];
        rtn.user_picture_url = [result stringForColumn:@"user_picture_url"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_user WHERE %@", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_user *rtn = [[client_user alloc] init];
        rtn.user_id = [NSNumber numberWithInt:[result intForColumn:@"user_id"]];
        rtn.user_empid = [result stringForColumn:@"user_empid"];
        rtn.user_name = [result stringForColumn:@"user_name"];
        rtn.user_real_name = [result stringForColumn:@"user_real_name"];
        rtn.user_level = [result stringForColumn:@"user_level"];
        rtn.user_area = [result stringForColumn:@"user_area"];
        rtn.user_area_type = [NSNumber numberWithInt:[result intForColumn:@"user_area_type"]];
        rtn.user_type = [NSNumber numberWithInt:[result intForColumn:@"user_type"]];
        rtn.user_email = [result stringForColumn:@"user_email"];
        rtn.user_phone = [result stringForColumn:@"user_phone"];
        rtn.user_mobile = [result stringForColumn:@"user_mobile"];
        rtn.user_picture_url = [result stringForColumn:@"user_picture_url"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_user WHERE %@ ORDER BY %@", where, order];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_user *rtn = [[client_user alloc] init];
        rtn.user_id = [NSNumber numberWithInt:[result intForColumn:@"user_id"]];
        rtn.user_empid = [result stringForColumn:@"user_empid"];
        rtn.user_name = [result stringForColumn:@"user_name"];
        rtn.user_real_name = [result stringForColumn:@"user_real_name"];
        rtn.user_level = [result stringForColumn:@"user_level"];
        rtn.user_area = [result stringForColumn:@"user_area"];
        rtn.user_area_type = [NSNumber numberWithInt:[result intForColumn:@"user_area_type"]];
        rtn.user_type = [NSNumber numberWithInt:[result intForColumn:@"user_type"]];
        rtn.user_email = [result stringForColumn:@"user_email"];
        rtn.user_phone = [result stringForColumn:@"user_phone"];
        rtn.user_mobile = [result stringForColumn:@"user_mobile"];
        rtn.user_picture_url = [result stringForColumn:@"user_picture_url"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_user WHERE %@ ORDER BY %@ LIMIT 0,%d", where, order, top];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_user *rtn = [[client_user alloc] init];
        rtn.user_id = [NSNumber numberWithInt:[result intForColumn:@"user_id"]];
        rtn.user_empid = [result stringForColumn:@"user_empid"];
        rtn.user_name = [result stringForColumn:@"user_name"];
        rtn.user_real_name = [result stringForColumn:@"user_real_name"];
        rtn.user_level = [result stringForColumn:@"user_level"];
        rtn.user_area = [result stringForColumn:@"user_area"];
        rtn.user_area_type = [NSNumber numberWithInt:[result intForColumn:@"user_area_type"]];
        rtn.user_type = [NSNumber numberWithInt:[result intForColumn:@"user_type"]];
        rtn.user_email = [result stringForColumn:@"user_email"];
        rtn.user_phone = [result stringForColumn:@"user_phone"];
        rtn.user_mobile = [result stringForColumn:@"user_mobile"];
        rtn.user_picture_url = [result stringForColumn:@"user_picture_url"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_user WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_user *rtn = [[client_user alloc] init];
        rtn.user_id = [NSNumber numberWithInt:[result intForColumn:@"user_id"]];
        rtn.user_empid = [result stringForColumn:@"user_empid"];
        rtn.user_name = [result stringForColumn:@"user_name"];
        rtn.user_real_name = [result stringForColumn:@"user_real_name"];
        rtn.user_level = [result stringForColumn:@"user_level"];
        rtn.user_area = [result stringForColumn:@"user_area"];
        rtn.user_area_type = [NSNumber numberWithInt:[result intForColumn:@"user_area_type"]];
        rtn.user_type = [NSNumber numberWithInt:[result intForColumn:@"user_type"]];
        rtn.user_email = [result stringForColumn:@"user_email"];
        rtn.user_phone = [result stringForColumn:@"user_phone"];
        rtn.user_mobile = [result stringForColumn:@"user_mobile"];
        rtn.user_picture_url = [result stringForColumn:@"user_picture_url"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_user WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_user *rtn = [[client_user alloc] init];
        rtn.user_id = [NSNumber numberWithInt:[result intForColumn:@"user_id"]];
        rtn.user_empid = [result stringForColumn:@"user_empid"];
        rtn.user_name = [result stringForColumn:@"user_name"];
        rtn.user_real_name = [result stringForColumn:@"user_real_name"];
        rtn.user_level = [result stringForColumn:@"user_level"];
        rtn.user_area = [result stringForColumn:@"user_area"];
        rtn.user_area_type = [NSNumber numberWithInt:[result intForColumn:@"user_area_type"]];
        rtn.user_type = [NSNumber numberWithInt:[result intForColumn:@"user_type"]];
        rtn.user_email = [result stringForColumn:@"user_email"];
        rtn.user_phone = [result stringForColumn:@"user_phone"];
        rtn.user_mobile = [result stringForColumn:@"user_mobile"];
        rtn.user_picture_url = [result stringForColumn:@"user_picture_url"];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (client_user *)convertJsonToModel:(NSDictionary *)json
{
    client_user *model = [[client_user alloc] init];
    model.user_id = [json objectForKey:@"user_id"];
    model.user_empid = [json objectForKey:@"user_empid"];
    model.user_name = [json objectForKey:@"user_name"];
    model.user_real_name = [json objectForKey:@"user_real_name"];
    model.user_level = [json objectForKey:@"user_level"];
    model.user_area = [json objectForKey:@"user_area"];
    model.user_area_type = [json objectForKey:@"user_area_type"];
    model.user_type = [json objectForKey:@"user_type"];
    model.user_email = [json objectForKey:@"user_email"];
    model.user_phone = [json objectForKey:@"user_phone"];
    model.user_mobile = [json objectForKey:@"user_mobile"];
    model.user_picture_url = [json objectForKey:@"user_picture_url"];
    model.data_version = [json objectForKey:@"data_version"];
    return model;
}

+ (NSArray *)convertJsonToList:(NSArray *)jsons
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *json in jsons) {
        client_user *model = [[client_user alloc] init];
        model.user_id = [json objectForKey:@"user_id"];
        model.user_empid = [json objectForKey:@"user_empid"];
        model.user_name = [json objectForKey:@"user_name"];
        model.user_real_name = [json objectForKey:@"user_real_name"];
        model.user_level = [json objectForKey:@"user_level"];
        model.user_area = [json objectForKey:@"user_area"];
        model.user_area_type = [json objectForKey:@"user_area_type"];
        model.user_type = [json objectForKey:@"user_type"];
        model.user_email = [json objectForKey:@"user_email"];
        model.user_phone = [json objectForKey:@"user_phone"];
        model.user_mobile = [json objectForKey:@"user_mobile"];
        model.user_picture_url = [json objectForKey:@"user_picture_url"];
        model.data_version = [json objectForKey:@"data_version"];
        [array addObject:model];
    }
    return array;
}

@end