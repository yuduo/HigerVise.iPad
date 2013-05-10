#import "client_dialogue_detail_dal.h"

@implementation client_dialogue_detail_dal

+ (BOOL)exists:(NSString *)dialogue_detail_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    FMResultSet *result = [db executeQuery:@"SELECT COUNT(dialogue_detail_id) FROM client_dialogue_detail WHERE dialogue_detail_id = ?", dialogue_detail_id];
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

+ (BOOL)add:(client_dialogue_detail *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"INSERT INTO client_dialogue_detail (dialogue_detail_id, dialogue_master_id, dialogue_detail_type, dialogue_detail_message, is_send, is_used, create_userid, create_time, update_userid, update_time, data_version) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", model.dialogue_detail_id, model.dialogue_master_id, model.dialogue_detail_type, model.dialogue_detail_message, model.is_send, model.is_used, model.create_userid, model.create_time, model.update_userid, model.update_time, model.data_version];
    [db close];
    return rtn;
}

+ (BOOL)update:(client_dialogue_detail *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"UPDATE client_dialogue_detail SET dialogue_master_id = ?, dialogue_detail_type = ?, dialogue_detail_message = ?, is_send = ?, is_used = ?, create_userid = ?, create_time = ?, update_userid = ?, update_time = ?, data_version = ? WHERE dialogue_detail_id = ?", model.dialogue_master_id, model.dialogue_detail_type, model.dialogue_detail_message, model.is_send, model.is_used, model.create_userid, model.create_time, model.update_userid, model.update_time, model.data_version, model.dialogue_detail_id];
    [db close];
    return rtn;
}

+ (BOOL)delete:(NSString *)dialogue_detail_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"DELETE FROM client_dialogue_detail WHERE dialogue_detail_id = ?", dialogue_detail_id];
    [db close];
    return rtn;
}

+ (BOOL)deleteList:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    NSString *strSql = [NSString stringWithFormat:@"DELETE FROM client_dialogue_detail WHERE %@", where];
    rtn = [db executeUpdate:strSql];
    [db close];
    return rtn;
}

+ (client_dialogue_detail *)get:(NSString *)dialogue_detail_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    client_dialogue_detail *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT * FROM client_dialogue_detail WHERE dialogue_detail_id = ?", dialogue_detail_id];
    while ([result next]) {
        rtn = [[client_dialogue_detail alloc] init];
        rtn.dialogue_detail_id = [result stringForColumn:@"dialogue_detail_id"];
        rtn.dialogue_master_id = [result stringForColumn:@"dialogue_master_id"];
        rtn.dialogue_detail_type = [NSNumber numberWithInt:[result intForColumn:@"dialogue_detail_type"]];
        rtn.dialogue_detail_message = [result stringForColumn:@"dialogue_detail_message"];
        rtn.is_send = [NSNumber numberWithInt:[result intForColumn:@"is_send"]];
        rtn.is_used = [NSNumber numberWithInt:[result intForColumn:@"is_used"]];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
        rtn.create_time = [result stringForColumn:@"create_time"];
        rtn.update_userid = [result stringForColumn:@"update_userid"];
        rtn.update_time = [result stringForColumn:@"update_time"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_dialogue_detail WHERE %@", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_dialogue_detail *rtn = [[client_dialogue_detail alloc] init];
        rtn.dialogue_detail_id = [result stringForColumn:@"dialogue_detail_id"];
        rtn.dialogue_master_id = [result stringForColumn:@"dialogue_master_id"];
        rtn.dialogue_detail_type = [NSNumber numberWithInt:[result intForColumn:@"dialogue_detail_type"]];
        rtn.dialogue_detail_message = [result stringForColumn:@"dialogue_detail_message"];
        rtn.is_send = [NSNumber numberWithInt:[result intForColumn:@"is_send"]];
        rtn.is_used = [NSNumber numberWithInt:[result intForColumn:@"is_used"]];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
        rtn.create_time = [result stringForColumn:@"create_time"];
        rtn.update_userid = [result stringForColumn:@"update_userid"];
        rtn.update_time = [result stringForColumn:@"update_time"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_dialogue_detail WHERE %@ ORDER BY %@", where, order];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_dialogue_detail *rtn = [[client_dialogue_detail alloc] init];
        rtn.dialogue_detail_id = [result stringForColumn:@"dialogue_detail_id"];
        rtn.dialogue_master_id = [result stringForColumn:@"dialogue_master_id"];
        rtn.dialogue_detail_type = [NSNumber numberWithInt:[result intForColumn:@"dialogue_detail_type"]];
        rtn.dialogue_detail_message = [result stringForColumn:@"dialogue_detail_message"];
        rtn.is_send = [NSNumber numberWithInt:[result intForColumn:@"is_send"]];
        rtn.is_used = [NSNumber numberWithInt:[result intForColumn:@"is_used"]];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
        rtn.create_time = [result stringForColumn:@"create_time"];
        rtn.update_userid = [result stringForColumn:@"update_userid"];
        rtn.update_time = [result stringForColumn:@"update_time"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_dialogue_detail WHERE %@ ORDER BY %@ LIMIT 0,%d", where, order, top];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_dialogue_detail *rtn = [[client_dialogue_detail alloc] init];
        rtn.dialogue_detail_id = [result stringForColumn:@"dialogue_detail_id"];
        rtn.dialogue_master_id = [result stringForColumn:@"dialogue_master_id"];
        rtn.dialogue_detail_type = [NSNumber numberWithInt:[result intForColumn:@"dialogue_detail_type"]];
        rtn.dialogue_detail_message = [result stringForColumn:@"dialogue_detail_message"];
        rtn.is_send = [NSNumber numberWithInt:[result intForColumn:@"is_send"]];
        rtn.is_used = [NSNumber numberWithInt:[result intForColumn:@"is_used"]];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
        rtn.create_time = [result stringForColumn:@"create_time"];
        rtn.update_userid = [result stringForColumn:@"update_userid"];
        rtn.update_time = [result stringForColumn:@"update_time"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_dialogue_detail WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_dialogue_detail *rtn = [[client_dialogue_detail alloc] init];
        rtn.dialogue_detail_id = [result stringForColumn:@"dialogue_detail_id"];
        rtn.dialogue_master_id = [result stringForColumn:@"dialogue_master_id"];
        rtn.dialogue_detail_type = [NSNumber numberWithInt:[result intForColumn:@"dialogue_detail_type"]];
        rtn.dialogue_detail_message = [result stringForColumn:@"dialogue_detail_message"];
        rtn.is_send = [NSNumber numberWithInt:[result intForColumn:@"is_send"]];
        rtn.is_used = [NSNumber numberWithInt:[result intForColumn:@"is_used"]];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
        rtn.create_time = [result stringForColumn:@"create_time"];
        rtn.update_userid = [result stringForColumn:@"update_userid"];
        rtn.update_time = [result stringForColumn:@"update_time"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_dialogue_detail WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_dialogue_detail *rtn = [[client_dialogue_detail alloc] init];
        rtn.dialogue_detail_id = [result stringForColumn:@"dialogue_detail_id"];
        rtn.dialogue_master_id = [result stringForColumn:@"dialogue_master_id"];
        rtn.dialogue_detail_type = [NSNumber numberWithInt:[result intForColumn:@"dialogue_detail_type"]];
        rtn.dialogue_detail_message = [result stringForColumn:@"dialogue_detail_message"];
        rtn.is_send = [NSNumber numberWithInt:[result intForColumn:@"is_send"]];
        rtn.is_used = [NSNumber numberWithInt:[result intForColumn:@"is_used"]];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
        rtn.create_time = [result stringForColumn:@"create_time"];
        rtn.update_userid = [result stringForColumn:@"update_userid"];
        rtn.update_time = [result stringForColumn:@"update_time"];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (client_dialogue_detail *)convertJsonToModel:(NSDictionary *)json
{
    client_dialogue_detail *model = [[client_dialogue_detail alloc] init];
    model.dialogue_detail_id = [json objectForKey:@"dialogue_detail_id"];
    model.dialogue_master_id = [json objectForKey:@"dialogue_master_id"];
    model.dialogue_detail_type = [json objectForKey:@"dialogue_detail_type"];
    model.dialogue_detail_message = [json objectForKey:@"dialogue_detail_message"];
    model.is_send = [json objectForKey:@"is_send"];
    model.is_used = [json objectForKey:@"is_used"];
    model.create_userid = [json objectForKey:@"create_userid"];
    model.create_time = [json objectForKey:@"create_time"];
    model.update_userid = [json objectForKey:@"update_userid"];
    model.update_time = [json objectForKey:@"update_time"];
    model.data_version = [json objectForKey:@"data_version"];
    return model;
}

+ (NSArray *)convertJsonToList:(NSArray *)jsons
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *json in jsons) {
        client_dialogue_detail *model = [[client_dialogue_detail alloc] init];
        model.dialogue_detail_id = [json objectForKey:@"dialogue_detail_id"];
        model.dialogue_master_id = [json objectForKey:@"dialogue_master_id"];
        model.dialogue_detail_type = [json objectForKey:@"dialogue_detail_type"];
        model.dialogue_detail_message = [json objectForKey:@"dialogue_detail_message"];
        model.is_send = [json objectForKey:@"is_send"];
        model.is_used = [json objectForKey:@"is_used"];
        model.create_userid = [json objectForKey:@"create_userid"];
        model.create_time = [json objectForKey:@"create_time"];
        model.update_userid = [json objectForKey:@"update_userid"];
        model.update_time = [json objectForKey:@"update_time"];
        model.data_version = [json objectForKey:@"data_version"];
        [array addObject:model];
    }
    return array;
}

@end