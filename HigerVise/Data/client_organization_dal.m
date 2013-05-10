#import "client_organization_dal.h"

@implementation client_organization_dal

+ (NSNumber *)getMaxId
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSNumber *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT MAX(organization_id) FROM client_organization"];
    if ([result next]) {
        int maxId = [result intForColumnIndex:0] + 1;
        rtn = [NSNumber numberWithInt:maxId];
    }
    [db close];
    return rtn;
}

+ (BOOL)exists:(NSNumber *)organization_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    FMResultSet *result = [db executeQuery:@"SELECT COUNT(organization_id) FROM client_organization WHERE organization_id = ?", organization_id];
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

+ (BOOL)add:(client_organization *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"INSERT INTO client_organization (organization_id, organization_code, organization_name, organization_type, organization_parent_id, organization_parent_code, organization_parent_type, data_version) VALUES (?, ?, ?, ?, ?, ?, ?, ?)", model.organization_id, model.organization_code, model.organization_name, model.organization_type, model.organization_parent_id, model.organization_parent_code, model.organization_parent_type, model.data_version];
    [db close];
    return rtn;
}

+ (BOOL)update:(client_organization *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"UPDATE client_organization SET organization_code = ?, organization_name = ?, organization_type = ?, organization_parent_id = ?, organization_parent_code = ?, organization_parent_type = ?, data_version = ? WHERE organization_id = ?", model.organization_code, model.organization_name, model.organization_type, model.organization_parent_id, model.organization_parent_code, model.organization_parent_type, model.data_version, model.organization_id];
    [db close];
    return rtn;
}

+ (BOOL)delete:(NSNumber *)organization_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"DELETE FROM client_organization WHERE organization_id = ?", organization_id];
    [db close];
    return rtn;
}

+ (BOOL)deleteList:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    NSString *strSql = [NSString stringWithFormat:@"DELETE FROM client_organization WHERE %@", where];
    rtn = [db executeUpdate:strSql];
    [db close];
    return rtn;
}

+ (client_organization *)get:(NSNumber *)organization_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    client_organization *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT * FROM client_organization WHERE organization_id = ?", organization_id];
    while ([result next]) {
        rtn = [[client_organization alloc] init];
        rtn.organization_id = [NSNumber numberWithInt:[result intForColumn:@"organization_id"]];
        rtn.organization_code = [result stringForColumn:@"organization_code"];
        rtn.organization_name = [result stringForColumn:@"organization_name"];
        rtn.organization_type = [NSNumber numberWithInt:[result intForColumn:@"organization_type"]];
        rtn.organization_parent_id = [NSNumber numberWithInt:[result intForColumn:@"organization_parent_id"]];
        rtn.organization_parent_code = [result stringForColumn:@"organization_parent_code"];
        rtn.organization_parent_type = [NSNumber numberWithInt:[result intForColumn:@"organization_parent_type"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_organization WHERE %@", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_organization *rtn = [[client_organization alloc] init];
        rtn.organization_id = [NSNumber numberWithInt:[result intForColumn:@"organization_id"]];
        rtn.organization_code = [result stringForColumn:@"organization_code"];
        rtn.organization_name = [result stringForColumn:@"organization_name"];
        rtn.organization_type = [NSNumber numberWithInt:[result intForColumn:@"organization_type"]];
        rtn.organization_parent_id = [NSNumber numberWithInt:[result intForColumn:@"organization_parent_id"]];
        rtn.organization_parent_code = [result stringForColumn:@"organization_parent_code"];
        rtn.organization_parent_type = [NSNumber numberWithInt:[result intForColumn:@"organization_parent_type"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_organization WHERE %@ ORDER BY %@", where, order];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_organization *rtn = [[client_organization alloc] init];
        rtn.organization_id = [NSNumber numberWithInt:[result intForColumn:@"organization_id"]];
        rtn.organization_code = [result stringForColumn:@"organization_code"];
        rtn.organization_name = [result stringForColumn:@"organization_name"];
        rtn.organization_type = [NSNumber numberWithInt:[result intForColumn:@"organization_type"]];
        rtn.organization_parent_id = [NSNumber numberWithInt:[result intForColumn:@"organization_parent_id"]];
        rtn.organization_parent_code = [result stringForColumn:@"organization_parent_code"];
        rtn.organization_parent_type = [NSNumber numberWithInt:[result intForColumn:@"organization_parent_type"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_organization WHERE %@ ORDER BY %@ LIMIT 0,%d", where, order, top];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_organization *rtn = [[client_organization alloc] init];
        rtn.organization_id = [NSNumber numberWithInt:[result intForColumn:@"organization_id"]];
        rtn.organization_code = [result stringForColumn:@"organization_code"];
        rtn.organization_name = [result stringForColumn:@"organization_name"];
        rtn.organization_type = [NSNumber numberWithInt:[result intForColumn:@"organization_type"]];
        rtn.organization_parent_id = [NSNumber numberWithInt:[result intForColumn:@"organization_parent_id"]];
        rtn.organization_parent_code = [result stringForColumn:@"organization_parent_code"];
        rtn.organization_parent_type = [NSNumber numberWithInt:[result intForColumn:@"organization_parent_type"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_organization WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_organization *rtn = [[client_organization alloc] init];
        rtn.organization_id = [NSNumber numberWithInt:[result intForColumn:@"organization_id"]];
        rtn.organization_code = [result stringForColumn:@"organization_code"];
        rtn.organization_name = [result stringForColumn:@"organization_name"];
        rtn.organization_type = [NSNumber numberWithInt:[result intForColumn:@"organization_type"]];
        rtn.organization_parent_id = [NSNumber numberWithInt:[result intForColumn:@"organization_parent_id"]];
        rtn.organization_parent_code = [result stringForColumn:@"organization_parent_code"];
        rtn.organization_parent_type = [NSNumber numberWithInt:[result intForColumn:@"organization_parent_type"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_organization WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_organization *rtn = [[client_organization alloc] init];
        rtn.organization_id = [NSNumber numberWithInt:[result intForColumn:@"organization_id"]];
        rtn.organization_code = [result stringForColumn:@"organization_code"];
        rtn.organization_name = [result stringForColumn:@"organization_name"];
        rtn.organization_type = [NSNumber numberWithInt:[result intForColumn:@"organization_type"]];
        rtn.organization_parent_id = [NSNumber numberWithInt:[result intForColumn:@"organization_parent_id"]];
        rtn.organization_parent_code = [result stringForColumn:@"organization_parent_code"];
        rtn.organization_parent_type = [NSNumber numberWithInt:[result intForColumn:@"organization_parent_type"]];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (client_organization *)convertJsonToModel:(NSDictionary *)json
{
    client_organization *model = [[client_organization alloc] init];
    model.organization_id = [json objectForKey:@"organization_id"];
    model.organization_code = [json objectForKey:@"organization_code"];
    model.organization_name = [json objectForKey:@"organization_name"];
    model.organization_type = [json objectForKey:@"organization_type"];
    model.organization_parent_id = [json objectForKey:@"organization_parent_id"];
    model.organization_parent_code = [json objectForKey:@"organization_parent_code"];
    model.organization_parent_type = [json objectForKey:@"organization_parent_type"];
    model.data_version = [json objectForKey:@"data_version"];
    return model;
}

+ (NSArray *)convertJsonToList:(NSArray *)jsons
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *json in jsons) {
        client_organization *model = [[client_organization alloc] init];
        model.organization_id = [json objectForKey:@"organization_id"];
        model.organization_code = [json objectForKey:@"organization_code"];
        model.organization_name = [json objectForKey:@"organization_name"];
        model.organization_type = [json objectForKey:@"organization_type"];
        model.organization_parent_id = [json objectForKey:@"organization_parent_id"];
        model.organization_parent_code = [json objectForKey:@"organization_parent_code"];
        model.organization_parent_type = [json objectForKey:@"organization_parent_type"];
        model.data_version = [json objectForKey:@"data_version"];
        [array addObject:model];
    }
    return array;
}

@end