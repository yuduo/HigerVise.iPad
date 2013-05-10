#import "client_dialogue_master_dal.h"

@implementation client_dialogue_master_dal

+ (BOOL)exists:(NSString *)dialogue_master_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    FMResultSet *result = [db executeQuery:@"SELECT COUNT(dialogue_master_id) FROM client_dialogue_master WHERE dialogue_master_id = ?", dialogue_master_id];
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

+ (BOOL)add:(client_dialogue_master *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"INSERT INTO client_dialogue_master (dialogue_master_id, dialogue_class_id, dialogue_master_type, dialogue_master_limit_time, dialogue_master_title, dialogue_master_desc, dialogue_master_remark, dialogue_master_status, dialogue_master_result, dialogue_master_index, is_read, is_attention, is_share, is_used, create_userid, create_time, update_userid, update_time, data_version) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", model.dialogue_master_id, model.dialogue_class_id, model.dialogue_master_type, model.dialogue_master_limit_time, model.dialogue_master_title, model.dialogue_master_desc, model.dialogue_master_remark, model.dialogue_master_status, model.dialogue_master_result, model.dialogue_master_index, model.is_read, model.is_attention, model.is_share, model.is_used, model.create_userid, model.create_time, model.update_userid, model.update_time, model.data_version];
    [db close];
    return rtn;
}

+ (BOOL)update:(client_dialogue_master *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"UPDATE client_dialogue_master SET dialogue_class_id = ?, dialogue_master_type = ?, dialogue_master_limit_time = ?, dialogue_master_title = ?, dialogue_master_desc = ?, dialogue_master_remark = ?, dialogue_master_status = ?, dialogue_master_result = ?, dialogue_master_index = ?, is_read = ?, is_attention = ?, is_share = ?, is_used = ?, create_userid = ?, create_time = ?, update_userid = ?, update_time = ?, data_version = ? WHERE dialogue_master_id = ?", model.dialogue_class_id, model.dialogue_master_type, model.dialogue_master_limit_time, model.dialogue_master_title, model.dialogue_master_desc, model.dialogue_master_remark, model.dialogue_master_status, model.dialogue_master_result, model.dialogue_master_index, model.is_read, model.is_attention, model.is_share, model.is_used, model.create_userid, model.create_time, model.update_userid, model.update_time, model.data_version, model.dialogue_master_id];
    [db close];
    return rtn;
}

+ (BOOL)delete:(NSString *)dialogue_master_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"DELETE FROM client_dialogue_master WHERE dialogue_master_id = ?", dialogue_master_id];
    [db close];
    return rtn;
}

+ (BOOL)deleteList:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    NSString *strSql = [NSString stringWithFormat:@"DELETE FROM client_dialogue_master WHERE %@", where];
    rtn = [db executeUpdate:strSql];
    [db close];
    return rtn;
}

+ (client_dialogue_master *)get:(NSString *)dialogue_master_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    client_dialogue_master *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT * FROM client_dialogue_master WHERE dialogue_master_id = ?", dialogue_master_id];
    while ([result next]) {
        rtn = [[client_dialogue_master alloc] init];
        rtn.dialogue_master_id = [result stringForColumn:@"dialogue_master_id"];
        rtn.dialogue_class_id = [NSNumber numberWithInt:[result intForColumn:@"dialogue_class_id"]];
        rtn.dialogue_master_type = [NSNumber numberWithInt:[result intForColumn:@"dialogue_master_type"]];
        rtn.dialogue_master_limit_time = [NSNumber numberWithInt:[result intForColumn:@"dialogue_master_limit_time"]];
        rtn.dialogue_master_title = [result stringForColumn:@"dialogue_master_title"];
        rtn.dialogue_master_desc = [result stringForColumn:@"dialogue_master_desc"];
        rtn.dialogue_master_remark = [result stringForColumn:@"dialogue_master_remark"];
        rtn.dialogue_master_status = [NSNumber numberWithInt:[result intForColumn:@"dialogue_master_status"]];
        rtn.dialogue_master_result = [NSNumber numberWithInt:[result intForColumn:@"dialogue_master_result"]];
        rtn.dialogue_master_index = [NSNumber numberWithInt:[result intForColumn:@"dialogue_master_index"]];
        rtn.is_read = [NSNumber numberWithInt:[result intForColumn:@"is_read"]];
        rtn.is_attention = [NSNumber numberWithInt:[result intForColumn:@"is_attention"]];
        rtn.is_share = [NSNumber numberWithInt:[result intForColumn:@"is_share"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_dialogue_master WHERE %@", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_dialogue_master *rtn = [[client_dialogue_master alloc] init];
        rtn.dialogue_master_id = [result stringForColumn:@"dialogue_master_id"];
        rtn.dialogue_class_id = [NSNumber numberWithInt:[result intForColumn:@"dialogue_class_id"]];
        rtn.dialogue_master_type = [NSNumber numberWithInt:[result intForColumn:@"dialogue_master_type"]];
        rtn.dialogue_master_limit_time = [NSNumber numberWithInt:[result intForColumn:@"dialogue_master_limit_time"]];
        rtn.dialogue_master_title = [result stringForColumn:@"dialogue_master_title"];
        rtn.dialogue_master_desc = [result stringForColumn:@"dialogue_master_desc"];
        rtn.dialogue_master_remark = [result stringForColumn:@"dialogue_master_remark"];
        rtn.dialogue_master_status = [NSNumber numberWithInt:[result intForColumn:@"dialogue_master_status"]];
        rtn.dialogue_master_result = [NSNumber numberWithInt:[result intForColumn:@"dialogue_master_result"]];
        rtn.dialogue_master_index = [NSNumber numberWithInt:[result intForColumn:@"dialogue_master_index"]];
        rtn.is_read = [NSNumber numberWithInt:[result intForColumn:@"is_read"]];
        rtn.is_attention = [NSNumber numberWithInt:[result intForColumn:@"is_attention"]];
        rtn.is_share = [NSNumber numberWithInt:[result intForColumn:@"is_share"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_dialogue_master WHERE %@ ORDER BY %@", where, order];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_dialogue_master *rtn = [[client_dialogue_master alloc] init];
        rtn.dialogue_master_id = [result stringForColumn:@"dialogue_master_id"];
        rtn.dialogue_class_id = [NSNumber numberWithInt:[result intForColumn:@"dialogue_class_id"]];
        rtn.dialogue_master_type = [NSNumber numberWithInt:[result intForColumn:@"dialogue_master_type"]];
        rtn.dialogue_master_limit_time = [NSNumber numberWithInt:[result intForColumn:@"dialogue_master_limit_time"]];
        rtn.dialogue_master_title = [result stringForColumn:@"dialogue_master_title"];
        rtn.dialogue_master_desc = [result stringForColumn:@"dialogue_master_desc"];
        rtn.dialogue_master_remark = [result stringForColumn:@"dialogue_master_remark"];
        rtn.dialogue_master_status = [NSNumber numberWithInt:[result intForColumn:@"dialogue_master_status"]];
        rtn.dialogue_master_result = [NSNumber numberWithInt:[result intForColumn:@"dialogue_master_result"]];
        rtn.dialogue_master_index = [NSNumber numberWithInt:[result intForColumn:@"dialogue_master_index"]];
        rtn.is_read = [NSNumber numberWithInt:[result intForColumn:@"is_read"]];
        rtn.is_attention = [NSNumber numberWithInt:[result intForColumn:@"is_attention"]];
        rtn.is_share = [NSNumber numberWithInt:[result intForColumn:@"is_share"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_dialogue_master WHERE %@ ORDER BY %@ LIMIT 0,%d", where, order, top];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_dialogue_master *rtn = [[client_dialogue_master alloc] init];
        rtn.dialogue_master_id = [result stringForColumn:@"dialogue_master_id"];
        rtn.dialogue_class_id = [NSNumber numberWithInt:[result intForColumn:@"dialogue_class_id"]];
        rtn.dialogue_master_type = [NSNumber numberWithInt:[result intForColumn:@"dialogue_master_type"]];
        rtn.dialogue_master_limit_time = [NSNumber numberWithInt:[result intForColumn:@"dialogue_master_limit_time"]];
        rtn.dialogue_master_title = [result stringForColumn:@"dialogue_master_title"];
        rtn.dialogue_master_desc = [result stringForColumn:@"dialogue_master_desc"];
        rtn.dialogue_master_remark = [result stringForColumn:@"dialogue_master_remark"];
        rtn.dialogue_master_status = [NSNumber numberWithInt:[result intForColumn:@"dialogue_master_status"]];
        rtn.dialogue_master_result = [NSNumber numberWithInt:[result intForColumn:@"dialogue_master_result"]];
        rtn.dialogue_master_index = [NSNumber numberWithInt:[result intForColumn:@"dialogue_master_index"]];
        rtn.is_read = [NSNumber numberWithInt:[result intForColumn:@"is_read"]];
        rtn.is_attention = [NSNumber numberWithInt:[result intForColumn:@"is_attention"]];
        rtn.is_share = [NSNumber numberWithInt:[result intForColumn:@"is_share"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_dialogue_master WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_dialogue_master *rtn = [[client_dialogue_master alloc] init];
        rtn.dialogue_master_id = [result stringForColumn:@"dialogue_master_id"];
        rtn.dialogue_class_id = [NSNumber numberWithInt:[result intForColumn:@"dialogue_class_id"]];
        rtn.dialogue_master_type = [NSNumber numberWithInt:[result intForColumn:@"dialogue_master_type"]];
        rtn.dialogue_master_limit_time = [NSNumber numberWithInt:[result intForColumn:@"dialogue_master_limit_time"]];
        rtn.dialogue_master_title = [result stringForColumn:@"dialogue_master_title"];
        rtn.dialogue_master_desc = [result stringForColumn:@"dialogue_master_desc"];
        rtn.dialogue_master_remark = [result stringForColumn:@"dialogue_master_remark"];
        rtn.dialogue_master_status = [NSNumber numberWithInt:[result intForColumn:@"dialogue_master_status"]];
        rtn.dialogue_master_result = [NSNumber numberWithInt:[result intForColumn:@"dialogue_master_result"]];
        rtn.dialogue_master_index = [NSNumber numberWithInt:[result intForColumn:@"dialogue_master_index"]];
        rtn.is_read = [NSNumber numberWithInt:[result intForColumn:@"is_read"]];
        rtn.is_attention = [NSNumber numberWithInt:[result intForColumn:@"is_attention"]];
        rtn.is_share = [NSNumber numberWithInt:[result intForColumn:@"is_share"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_dialogue_master WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_dialogue_master *rtn = [[client_dialogue_master alloc] init];
        rtn.dialogue_master_id = [result stringForColumn:@"dialogue_master_id"];
        rtn.dialogue_class_id = [NSNumber numberWithInt:[result intForColumn:@"dialogue_class_id"]];
        rtn.dialogue_master_type = [NSNumber numberWithInt:[result intForColumn:@"dialogue_master_type"]];
        rtn.dialogue_master_limit_time = [NSNumber numberWithInt:[result intForColumn:@"dialogue_master_limit_time"]];
        rtn.dialogue_master_title = [result stringForColumn:@"dialogue_master_title"];
        rtn.dialogue_master_desc = [result stringForColumn:@"dialogue_master_desc"];
        rtn.dialogue_master_remark = [result stringForColumn:@"dialogue_master_remark"];
        rtn.dialogue_master_status = [NSNumber numberWithInt:[result intForColumn:@"dialogue_master_status"]];
        rtn.dialogue_master_result = [NSNumber numberWithInt:[result intForColumn:@"dialogue_master_result"]];
        rtn.dialogue_master_index = [NSNumber numberWithInt:[result intForColumn:@"dialogue_master_index"]];
        rtn.is_read = [NSNumber numberWithInt:[result intForColumn:@"is_read"]];
        rtn.is_attention = [NSNumber numberWithInt:[result intForColumn:@"is_attention"]];
        rtn.is_share = [NSNumber numberWithInt:[result intForColumn:@"is_share"]];
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

+ (client_dialogue_master *)convertJsonToModel:(NSDictionary *)json
{
    client_dialogue_master *model = [[client_dialogue_master alloc] init];
    model.dialogue_master_id = [json objectForKey:@"dialogue_master_id"];
    model.dialogue_class_id = [json objectForKey:@"dialogue_class_id"];
    model.dialogue_master_type = [json objectForKey:@"dialogue_master_type"];
    model.dialogue_master_limit_time = [json objectForKey:@"dialogue_master_limit_time"];
    model.dialogue_master_title = [json objectForKey:@"dialogue_master_title"];
    model.dialogue_master_desc = [json objectForKey:@"dialogue_master_desc"];
    model.dialogue_master_remark = [json objectForKey:@"dialogue_master_remark"];
    model.dialogue_master_status = [json objectForKey:@"dialogue_master_status"];
    model.dialogue_master_result = [json objectForKey:@"dialogue_master_result"];
    model.dialogue_master_index = [json objectForKey:@"dialogue_master_index"];
    model.is_read = [json objectForKey:@"is_read"];
    model.is_attention = [json objectForKey:@"is_attention"];
    model.is_share = [json objectForKey:@"is_share"];
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
        client_dialogue_master *model = [[client_dialogue_master alloc] init];
        model.dialogue_master_id = [json objectForKey:@"dialogue_master_id"];
        model.dialogue_class_id = [json objectForKey:@"dialogue_class_id"];
        model.dialogue_master_type = [json objectForKey:@"dialogue_master_type"];
        model.dialogue_master_limit_time = [json objectForKey:@"dialogue_master_limit_time"];
        model.dialogue_master_title = [json objectForKey:@"dialogue_master_title"];
        model.dialogue_master_desc = [json objectForKey:@"dialogue_master_desc"];
        model.dialogue_master_remark = [json objectForKey:@"dialogue_master_remark"];
        model.dialogue_master_status = [json objectForKey:@"dialogue_master_status"];
        model.dialogue_master_result = [json objectForKey:@"dialogue_master_result"];
        model.dialogue_master_index = [json objectForKey:@"dialogue_master_index"];
        model.is_read = [json objectForKey:@"is_read"];
        model.is_attention = [json objectForKey:@"is_attention"];
        model.is_share = [json objectForKey:@"is_share"];
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