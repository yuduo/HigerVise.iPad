#import "client_image_dal.h"

@implementation client_image_dal

+ (NSNumber *)getMaxId
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSNumber *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT MAX(image_id) FROM client_image"];
    if ([result next]) {
        int maxId = [result intForColumnIndex:0] + 1;
        rtn = [NSNumber numberWithInt:maxId];
    }
    [db close];
    return rtn;
}

+ (BOOL)exists:(NSNumber *)image_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    FMResultSet *result = [db executeQuery:@"SELECT COUNT(image_id) FROM client_image WHERE image_id = ?", image_id];
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

+ (BOOL)add:(client_image *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"INSERT INTO client_image (image_id, reference_id, image_type, image_type_name, image_url, image_thum_url, image_title, image_desc, image_parent_id, data_version) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", model.image_id, model.reference_id, model.image_type, model.image_type_name, model.image_url, model.image_thum_url, model.image_title, model.image_desc, model.image_parent_id, model.data_version];
    [db close];
    return rtn;
}

+ (BOOL)update:(client_image *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"UPDATE client_image SET reference_id = ?, image_type = ?, image_type_name = ?, image_url = ?, image_thum_url = ?, image_title = ?, image_desc = ?, image_parent_id = ?, data_version = ? WHERE image_id = ?", model.reference_id, model.image_type, model.image_type_name, model.image_url, model.image_thum_url, model.image_title, model.image_desc, model.image_parent_id, model.data_version, model.image_id];
    [db close];
    return rtn;
}

+ (BOOL)delete:(NSNumber *)image_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"DELETE FROM client_image WHERE image_id = ?", image_id];
    [db close];
    return rtn;
}

+ (BOOL)deleteList:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    NSString *strSql = [NSString stringWithFormat:@"DELETE FROM client_image WHERE %@", where];
    rtn = [db executeUpdate:strSql];
    [db close];
    return rtn;
}

+ (client_image *)get:(NSNumber *)image_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    client_image *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT * FROM client_image WHERE image_id = ?", image_id];
    while ([result next]) {
        rtn = [[client_image alloc] init];
        rtn.image_id = [NSNumber numberWithInt:[result intForColumn:@"image_id"]];
        rtn.reference_id = [result stringForColumn:@"reference_id"];
        rtn.image_type = [NSNumber numberWithInt:[result intForColumn:@"image_type"]];
        rtn.image_type_name = [result stringForColumn:@"image_type_name"];
        rtn.image_url = [result stringForColumn:@"image_url"];
        rtn.image_thum_url = [result stringForColumn:@"image_thum_url"];
        rtn.image_title = [result stringForColumn:@"image_title"];
        rtn.image_desc = [result stringForColumn:@"image_desc"];
        rtn.image_parent_id = [NSNumber numberWithInt:[result intForColumn:@"image_parent_id"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_image WHERE %@", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_image *rtn = [[client_image alloc] init];
        rtn.image_id = [NSNumber numberWithInt:[result intForColumn:@"image_id"]];
        rtn.reference_id = [result stringForColumn:@"reference_id"];
        rtn.image_type = [NSNumber numberWithInt:[result intForColumn:@"image_type"]];
        rtn.image_type_name = [result stringForColumn:@"image_type_name"];
        rtn.image_url = [result stringForColumn:@"image_url"];
        rtn.image_thum_url = [result stringForColumn:@"image_thum_url"];
        rtn.image_title = [result stringForColumn:@"image_title"];
        rtn.image_desc = [result stringForColumn:@"image_desc"];
        rtn.image_parent_id = [NSNumber numberWithInt:[result intForColumn:@"image_parent_id"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_image WHERE %@ ORDER BY %@", where, order];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_image *rtn = [[client_image alloc] init];
        rtn.image_id = [NSNumber numberWithInt:[result intForColumn:@"image_id"]];
        rtn.reference_id = [result stringForColumn:@"reference_id"];
        rtn.image_type = [NSNumber numberWithInt:[result intForColumn:@"image_type"]];
        rtn.image_type_name = [result stringForColumn:@"image_type_name"];
        rtn.image_url = [result stringForColumn:@"image_url"];
        rtn.image_thum_url = [result stringForColumn:@"image_thum_url"];
        rtn.image_title = [result stringForColumn:@"image_title"];
        rtn.image_desc = [result stringForColumn:@"image_desc"];
        rtn.image_parent_id = [NSNumber numberWithInt:[result intForColumn:@"image_parent_id"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_image WHERE %@ ORDER BY %@ LIMIT 0,%d", where, order, top];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_image *rtn = [[client_image alloc] init];
        rtn.image_id = [NSNumber numberWithInt:[result intForColumn:@"image_id"]];
        rtn.reference_id = [result stringForColumn:@"reference_id"];
        rtn.image_type = [NSNumber numberWithInt:[result intForColumn:@"image_type"]];
        rtn.image_type_name = [result stringForColumn:@"image_type_name"];
        rtn.image_url = [result stringForColumn:@"image_url"];
        rtn.image_thum_url = [result stringForColumn:@"image_thum_url"];
        rtn.image_title = [result stringForColumn:@"image_title"];
        rtn.image_desc = [result stringForColumn:@"image_desc"];
        rtn.image_parent_id = [NSNumber numberWithInt:[result intForColumn:@"image_parent_id"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_image WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_image *rtn = [[client_image alloc] init];
        rtn.image_id = [NSNumber numberWithInt:[result intForColumn:@"image_id"]];
        rtn.reference_id = [result stringForColumn:@"reference_id"];
        rtn.image_type = [NSNumber numberWithInt:[result intForColumn:@"image_type"]];
        rtn.image_type_name = [result stringForColumn:@"image_type_name"];
        rtn.image_url = [result stringForColumn:@"image_url"];
        rtn.image_thum_url = [result stringForColumn:@"image_thum_url"];
        rtn.image_title = [result stringForColumn:@"image_title"];
        rtn.image_desc = [result stringForColumn:@"image_desc"];
        rtn.image_parent_id = [NSNumber numberWithInt:[result intForColumn:@"image_parent_id"]];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_image WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_image *rtn = [[client_image alloc] init];
        rtn.image_id = [NSNumber numberWithInt:[result intForColumn:@"image_id"]];
        rtn.reference_id = [result stringForColumn:@"reference_id"];
        rtn.image_type = [NSNumber numberWithInt:[result intForColumn:@"image_type"]];
        rtn.image_type_name = [result stringForColumn:@"image_type_name"];
        rtn.image_url = [result stringForColumn:@"image_url"];
        rtn.image_thum_url = [result stringForColumn:@"image_thum_url"];
        rtn.image_title = [result stringForColumn:@"image_title"];
        rtn.image_desc = [result stringForColumn:@"image_desc"];
        rtn.image_parent_id = [NSNumber numberWithInt:[result intForColumn:@"image_parent_id"]];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (client_image *)convertJsonToModel:(NSDictionary *)json
{
    client_image *model = [[client_image alloc] init];
    model.image_id = [json objectForKey:@"image_id"];
    model.reference_id = [json objectForKey:@"reference_id"];
    model.image_type = [json objectForKey:@"image_type"];
    model.image_type_name = [json objectForKey:@"image_type_name"];
    model.image_url = [json objectForKey:@"image_url"];
    model.image_thum_url = [json objectForKey:@"image_thum_url"];
    model.image_title = [json objectForKey:@"image_title"];
    model.image_desc = [json objectForKey:@"image_desc"];
    model.image_parent_id = [json objectForKey:@"image_parent_id"];
    model.data_version = [json objectForKey:@"data_version"];
    return model;
}

+ (NSArray *)convertJsonToList:(NSArray *)jsons
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *json in jsons) {
        client_image *model = [[client_image alloc] init];
        model.image_id = [json objectForKey:@"image_id"];
        model.reference_id = [json objectForKey:@"reference_id"];
        model.image_type = [json objectForKey:@"image_type"];
        model.image_type_name = [json objectForKey:@"image_type_name"];
        model.image_url = [json objectForKey:@"image_url"];
        model.image_thum_url = [json objectForKey:@"image_thum_url"];
        model.image_title = [json objectForKey:@"image_title"];
        model.image_desc = [json objectForKey:@"image_desc"];
        model.image_parent_id = [json objectForKey:@"image_parent_id"];
        model.data_version = [json objectForKey:@"data_version"];
        [array addObject:model];
    }
    return array;
}

+ (NSArray *)getGroupForCarColor:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *strSql = [NSString stringWithFormat:@"SELECT DISTINCT image_type, image_type_name FROM client_image WHERE %@ ORDER BY image_type ASC", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_image_group *rtn = [[client_image_group alloc] init];
        rtn.image_type = [NSNumber numberWithInt:[result intForColumn:@"image_type"]];
        rtn.image_type_name = [result stringForColumn:@"image_type_name"];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (NSArray *)getListForCarColor:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_image WHERE %@ ORDER BY image_id ASC", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_image *rtn = [[client_image alloc] init];
        rtn.image_id = [NSNumber numberWithInt:[result intForColumn:@"image_id"]];
        rtn.reference_id = [result stringForColumn:@"reference_id"];
        rtn.image_type = [NSNumber numberWithInt:[result intForColumn:@"image_type"]];
        rtn.image_type_name = [result stringForColumn:@"image_type_name"];
        rtn.image_url = [result stringForColumn:@"image_url"];
        rtn.image_thum_url = [result stringForColumn:@"image_thum_url"];
        rtn.image_title = [result stringForColumn:@"image_title"];
        rtn.image_desc = [result stringForColumn:@"image_desc"];
        rtn.image_parent_id = [NSNumber numberWithInt:[result intForColumn:@"image_parent_id"]];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

@end