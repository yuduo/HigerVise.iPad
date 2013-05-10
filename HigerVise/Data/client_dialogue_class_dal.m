#import "client_dialogue_class_dal.h"

@implementation client_dialogue_class_dal

+ (NSNumber *)getMaxId
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSNumber *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT MAX(dialogue_class_id) FROM client_dialogue_class"];
    if ([result next]) {
        int maxId = [result intForColumnIndex:0] + 1;
        rtn = [NSNumber numberWithInt:maxId];
    }
    [db close];
    return rtn;
}

+ (BOOL)exists:(NSNumber *)dialogue_class_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    FMResultSet *result = [db executeQuery:@"SELECT COUNT(dialogue_class_id) FROM client_dialogue_class WHERE dialogue_class_id = ?", dialogue_class_id];
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

+ (BOOL)add:(client_dialogue_class *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"INSERT INTO client_dialogue_class (dialogue_class_id, dialogue_class_type, dialogue_class_name, dialogue_class_desc, dialogue_class_group, data_version) VALUES (?, ?, ?, ?, ?, ?)", model.dialogue_class_id, model.dialogue_class_type, model.dialogue_class_name, model.dialogue_class_desc, model.dialogue_class_group, model.data_version];
    [db close];
    return rtn;
}

+ (BOOL)update:(client_dialogue_class *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"UPDATE client_dialogue_class SET dialogue_class_type = ?, dialogue_class_name = ?, dialogue_class_desc = ?, dialogue_class_group = ?, data_version = ? WHERE dialogue_class_id = ?", model.dialogue_class_type, model.dialogue_class_name, model.dialogue_class_desc, model.dialogue_class_group, model.data_version, model.dialogue_class_id];
    [db close];
    return rtn;
}

+ (BOOL)delete:(NSNumber *)dialogue_class_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"DELETE FROM client_dialogue_class WHERE dialogue_class_id = ?", dialogue_class_id];
    [db close];
    return rtn;
}

+ (BOOL)deleteList:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    NSString *strSql = [NSString stringWithFormat:@"DELETE FROM client_dialogue_class WHERE %@", where];
    rtn = [db executeUpdate:strSql];
    [db close];
    return rtn;
}

+ (client_dialogue_class *)get:(NSNumber *)dialogue_class_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    client_dialogue_class *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT * FROM client_dialogue_class WHERE dialogue_class_id = ?", dialogue_class_id];
    while ([result next]) {
        rtn = [[client_dialogue_class alloc] init];
        rtn.dialogue_class_id = [NSNumber numberWithInt:[result intForColumn:@"dialogue_class_id"]];
        rtn.dialogue_class_type = [NSNumber numberWithInt:[result intForColumn:@"dialogue_class_type"]];
        rtn.dialogue_class_name = [result stringForColumn:@"dialogue_class_name"];
        rtn.dialogue_class_desc = [result stringForColumn:@"dialogue_class_desc"];
        rtn.dialogue_class_group = [result stringForColumn:@"dialogue_class_group"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_dialogue_class WHERE %@", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_dialogue_class *rtn = [[client_dialogue_class alloc] init];
        rtn.dialogue_class_id = [NSNumber numberWithInt:[result intForColumn:@"dialogue_class_id"]];
        rtn.dialogue_class_type = [NSNumber numberWithInt:[result intForColumn:@"dialogue_class_type"]];
        rtn.dialogue_class_name = [result stringForColumn:@"dialogue_class_name"];
        rtn.dialogue_class_desc = [result stringForColumn:@"dialogue_class_desc"];
        rtn.dialogue_class_group = [result stringForColumn:@"dialogue_class_group"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_dialogue_class WHERE %@ ORDER BY %@", where, order];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_dialogue_class *rtn = [[client_dialogue_class alloc] init];
        rtn.dialogue_class_id = [NSNumber numberWithInt:[result intForColumn:@"dialogue_class_id"]];
        rtn.dialogue_class_type = [NSNumber numberWithInt:[result intForColumn:@"dialogue_class_type"]];
        rtn.dialogue_class_name = [result stringForColumn:@"dialogue_class_name"];
        rtn.dialogue_class_desc = [result stringForColumn:@"dialogue_class_desc"];
        rtn.dialogue_class_group = [result stringForColumn:@"dialogue_class_group"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_dialogue_class WHERE %@ ORDER BY %@ LIMIT 0,%d", where, order, top];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_dialogue_class *rtn = [[client_dialogue_class alloc] init];
        rtn.dialogue_class_id = [NSNumber numberWithInt:[result intForColumn:@"dialogue_class_id"]];
        rtn.dialogue_class_type = [NSNumber numberWithInt:[result intForColumn:@"dialogue_class_type"]];
        rtn.dialogue_class_name = [result stringForColumn:@"dialogue_class_name"];
        rtn.dialogue_class_desc = [result stringForColumn:@"dialogue_class_desc"];
        rtn.dialogue_class_group = [result stringForColumn:@"dialogue_class_group"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_dialogue_class WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_dialogue_class *rtn = [[client_dialogue_class alloc] init];
        rtn.dialogue_class_id = [NSNumber numberWithInt:[result intForColumn:@"dialogue_class_id"]];
        rtn.dialogue_class_type = [NSNumber numberWithInt:[result intForColumn:@"dialogue_class_type"]];
        rtn.dialogue_class_name = [result stringForColumn:@"dialogue_class_name"];
        rtn.dialogue_class_desc = [result stringForColumn:@"dialogue_class_desc"];
        rtn.dialogue_class_group = [result stringForColumn:@"dialogue_class_group"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_dialogue_class WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_dialogue_class *rtn = [[client_dialogue_class alloc] init];
        rtn.dialogue_class_id = [NSNumber numberWithInt:[result intForColumn:@"dialogue_class_id"]];
        rtn.dialogue_class_type = [NSNumber numberWithInt:[result intForColumn:@"dialogue_class_type"]];
        rtn.dialogue_class_name = [result stringForColumn:@"dialogue_class_name"];
        rtn.dialogue_class_desc = [result stringForColumn:@"dialogue_class_desc"];
        rtn.dialogue_class_group = [result stringForColumn:@"dialogue_class_group"];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (client_dialogue_class *)convertJsonToModel:(NSDictionary *)json
{
    client_dialogue_class *model = [[client_dialogue_class alloc] init];
    model.dialogue_class_id = [json objectForKey:@"dialogue_class_id"];
    model.dialogue_class_type = [json objectForKey:@"dialogue_class_type"];
    model.dialogue_class_name = [json objectForKey:@"dialogue_class_name"];
    model.dialogue_class_desc = [json objectForKey:@"dialogue_class_desc"];
    model.dialogue_class_group = [json objectForKey:@"dialogue_class_group"];
    model.data_version = [json objectForKey:@"data_version"];
    return model;
}

+ (NSArray *)convertJsonToList:(NSArray *)jsons
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *json in jsons) {
        client_dialogue_class *model = [[client_dialogue_class alloc] init];
        model.dialogue_class_id = [json objectForKey:@"dialogue_class_id"];
        model.dialogue_class_type = [json objectForKey:@"dialogue_class_type"];
        model.dialogue_class_name = [json objectForKey:@"dialogue_class_name"];
        model.dialogue_class_desc = [json objectForKey:@"dialogue_class_desc"];
        model.dialogue_class_group = [json objectForKey:@"dialogue_class_group"];
        model.data_version = [json objectForKey:@"data_version"];
        [array addObject:model];
    }
    return array;
}

@end