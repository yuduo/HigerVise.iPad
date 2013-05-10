#import "client_vehicle_edition_setting_his_dal.h"

@implementation client_vehicle_edition_setting_his_dal

+ (NSNumber *)getMaxId
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSNumber *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT MAX(vehicle_edition_setting_id) FROM client_vehicle_edition_setting_his"];
    if ([result next]) {
        int maxId = [result intForColumnIndex:0] + 1;
        rtn = [NSNumber numberWithInt:maxId];
    }
    [db close];
    return rtn;
}

+ (BOOL)exists:(NSNumber *)vehicle_edition_setting_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    FMResultSet *result = [db executeQuery:@"SELECT COUNT(vehicle_edition_setting_id) FROM client_vehicle_edition_setting_his WHERE vehicle_edition_setting_id = ?", vehicle_edition_setting_id];
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

+ (BOOL)add:(client_vehicle_edition_setting_his *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"INSERT INTO client_vehicle_edition_setting_his (vehicle_edition_setting_id, vehicle_configurator_id, vehicle_edition_id, group_code, sale_group_code, op_code, op_name, sale_op_name, op_seq, op_value_code, op_value_name, sale_op_value_name, op_value_level_code, op_value_std_price, op_value_del_price, op_show_grade_disid, view_desc, is_displayed, is_displayed_config, is_allow_edited, is_has_image, is_selected, is_canceled, create_userid, create_time, update_userid, update_time, data_version) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", model.vehicle_edition_setting_id, model.vehicle_configurator_id, model.vehicle_edition_id, model.group_code, model.sale_group_code, model.op_code, model.op_name, model.sale_op_name, model.op_seq, model.op_value_code, model.op_value_name, model.sale_op_value_name, model.op_value_level_code, model.op_value_std_price, model.op_value_del_price, model.op_show_grade_disid, model.view_desc, model.is_displayed, model.is_displayed_config, model.is_allow_edited, model.is_has_image, model.is_selected, model.is_canceled, model.create_userid, model.create_time, model.update_userid, model.update_time, model.data_version];
    [db close];
    return rtn;
}

+ (BOOL)update:(client_vehicle_edition_setting_his *)model
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"UPDATE client_vehicle_edition_setting_his SET vehicle_configurator_id = ?, vehicle_edition_id = ?, group_code = ?, sale_group_code = ?, op_code = ?, op_name = ?, sale_op_name = ?, op_seq = ?, op_value_code = ?, op_value_name = ?, sale_op_value_name = ?, op_value_level_code = ?, op_value_std_price = ?, op_value_del_price = ?, op_show_grade_disid = ?, view_desc = ?, is_displayed = ?, is_displayed_config = ?, is_allow_edited = ?, is_has_image = ?, is_selected = ?, is_canceled = ?, create_userid = ?, create_time = ?, update_userid = ?, update_time = ?, data_version = ? WHERE vehicle_edition_setting_id = ?", model.vehicle_configurator_id, model.vehicle_edition_id, model.group_code, model.sale_group_code, model.op_code, model.op_name, model.sale_op_name, model.op_seq, model.op_value_code, model.op_value_name, model.sale_op_value_name, model.op_value_level_code, model.op_value_std_price, model.op_value_del_price, model.op_show_grade_disid, model.view_desc, model.is_displayed, model.is_displayed_config, model.is_allow_edited, model.is_has_image, model.is_selected, model.is_canceled, model.create_userid, model.create_time, model.update_userid, model.update_time, model.data_version, model.vehicle_edition_setting_id];
    [db close];
    return rtn;
}

+ (BOOL)delete:(NSNumber *)vehicle_edition_setting_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    rtn = [db executeUpdate:@"DELETE FROM client_vehicle_edition_setting_his WHERE vehicle_edition_setting_id = ?", vehicle_edition_setting_id];
    [db close];
    return rtn;
}

+ (BOOL)deleteList:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    BOOL rtn;
    NSString *strSql = [NSString stringWithFormat:@"DELETE FROM client_vehicle_edition_setting_his WHERE %@", where];
    rtn = [db executeUpdate:strSql];
    [db close];
    return rtn;
}

+ (client_vehicle_edition_setting_his *)get:(NSNumber *)vehicle_edition_setting_id
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    client_vehicle_edition_setting_his *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT * FROM client_vehicle_edition_setting_his WHERE vehicle_edition_setting_id = ?", vehicle_edition_setting_id];
    while ([result next]) {
        rtn = [[client_vehicle_edition_setting_his alloc] init];
        rtn.vehicle_edition_setting_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_setting_id"]];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_edition_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_id"]];
        rtn.group_code = [result stringForColumn:@"group_code"];
        rtn.sale_group_code = [result stringForColumn:@"sale_group_code"];
        rtn.op_code = [result stringForColumn:@"op_code"];
        rtn.op_name = [result stringForColumn:@"op_name"];
        rtn.sale_op_name = [result stringForColumn:@"sale_op_name"];
        rtn.op_seq = [result stringForColumn:@"op_seq"];
        rtn.op_value_code = [result stringForColumn:@"op_value_code"];
        rtn.op_value_name = [result stringForColumn:@"op_value_name"];
        rtn.sale_op_value_name = [result stringForColumn:@"sale_op_value_name"];
        rtn.op_value_level_code = [NSNumber numberWithInt:[result intForColumn:@"op_value_level_code"]];
        rtn.op_value_std_price = [NSNumber numberWithDouble:[result doubleForColumn:@"op_value_std_price"]];
        rtn.op_value_del_price = [NSNumber numberWithDouble:[result doubleForColumn:@"op_value_del_price"]];
        rtn.op_show_grade_disid = [NSNumber numberWithInt:[result intForColumn:@"op_show_grade_disid"]];
        rtn.view_desc = [result stringForColumn:@"view_desc"];
        rtn.is_displayed = [NSNumber numberWithInt:[result intForColumn:@"is_displayed"]];
        rtn.is_displayed_config = [NSNumber numberWithInt:[result intForColumn:@"is_displayed_config"]];
        rtn.is_allow_edited = [NSNumber numberWithInt:[result intForColumn:@"is_allow_edited"]];
        rtn.is_has_image = [NSNumber numberWithInt:[result intForColumn:@"is_has_image"]];
        rtn.is_selected = [NSNumber numberWithInt:[result intForColumn:@"is_selected"]];
        rtn.is_canceled = [NSNumber numberWithInt:[result intForColumn:@"is_canceled"]];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
        rtn.create_time = [result dateForColumn:@"create_time"];
        rtn.update_userid = [result stringForColumn:@"update_userid"];
        rtn.update_time = [result dateForColumn:@"update_time"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_vehicle_edition_setting_his WHERE %@", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_vehicle_edition_setting_his *rtn = [[client_vehicle_edition_setting_his alloc] init];
        rtn.vehicle_edition_setting_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_setting_id"]];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_edition_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_id"]];
        rtn.group_code = [result stringForColumn:@"group_code"];
        rtn.sale_group_code = [result stringForColumn:@"sale_group_code"];
        rtn.op_code = [result stringForColumn:@"op_code"];
        rtn.op_name = [result stringForColumn:@"op_name"];
        rtn.sale_op_name = [result stringForColumn:@"sale_op_name"];
        rtn.op_seq = [result stringForColumn:@"op_seq"];
        rtn.op_value_code = [result stringForColumn:@"op_value_code"];
        rtn.op_value_name = [result stringForColumn:@"op_value_name"];
        rtn.sale_op_value_name = [result stringForColumn:@"sale_op_value_name"];
        rtn.op_value_level_code = [NSNumber numberWithInt:[result intForColumn:@"op_value_level_code"]];
        rtn.op_value_std_price = [NSNumber numberWithDouble:[result doubleForColumn:@"op_value_std_price"]];
        rtn.op_value_del_price = [NSNumber numberWithDouble:[result doubleForColumn:@"op_value_del_price"]];
        rtn.op_show_grade_disid = [NSNumber numberWithInt:[result intForColumn:@"op_show_grade_disid"]];
        rtn.view_desc = [result stringForColumn:@"view_desc"];
        rtn.is_displayed = [NSNumber numberWithInt:[result intForColumn:@"is_displayed"]];
        rtn.is_displayed_config = [NSNumber numberWithInt:[result intForColumn:@"is_displayed_config"]];
        rtn.is_allow_edited = [NSNumber numberWithInt:[result intForColumn:@"is_allow_edited"]];
        rtn.is_has_image = [NSNumber numberWithInt:[result intForColumn:@"is_has_image"]];
        rtn.is_selected = [NSNumber numberWithInt:[result intForColumn:@"is_selected"]];
        rtn.is_canceled = [NSNumber numberWithInt:[result intForColumn:@"is_canceled"]];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
        rtn.create_time = [result dateForColumn:@"create_time"];
        rtn.update_userid = [result stringForColumn:@"update_userid"];
        rtn.update_time = [result dateForColumn:@"update_time"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_vehicle_edition_setting_his WHERE %@ ORDER BY %@", where, order];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_vehicle_edition_setting_his *rtn = [[client_vehicle_edition_setting_his alloc] init];
        rtn.vehicle_edition_setting_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_setting_id"]];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_edition_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_id"]];
        rtn.group_code = [result stringForColumn:@"group_code"];
        rtn.sale_group_code = [result stringForColumn:@"sale_group_code"];
        rtn.op_code = [result stringForColumn:@"op_code"];
        rtn.op_name = [result stringForColumn:@"op_name"];
        rtn.sale_op_name = [result stringForColumn:@"sale_op_name"];
        rtn.op_seq = [result stringForColumn:@"op_seq"];
        rtn.op_value_code = [result stringForColumn:@"op_value_code"];
        rtn.op_value_name = [result stringForColumn:@"op_value_name"];
        rtn.sale_op_value_name = [result stringForColumn:@"sale_op_value_name"];
        rtn.op_value_level_code = [NSNumber numberWithInt:[result intForColumn:@"op_value_level_code"]];
        rtn.op_value_std_price = [NSNumber numberWithDouble:[result doubleForColumn:@"op_value_std_price"]];
        rtn.op_value_del_price = [NSNumber numberWithDouble:[result doubleForColumn:@"op_value_del_price"]];
        rtn.op_show_grade_disid = [NSNumber numberWithInt:[result intForColumn:@"op_show_grade_disid"]];
        rtn.view_desc = [result stringForColumn:@"view_desc"];
        rtn.is_displayed = [NSNumber numberWithInt:[result intForColumn:@"is_displayed"]];
        rtn.is_displayed_config = [NSNumber numberWithInt:[result intForColumn:@"is_displayed_config"]];
        rtn.is_allow_edited = [NSNumber numberWithInt:[result intForColumn:@"is_allow_edited"]];
        rtn.is_has_image = [NSNumber numberWithInt:[result intForColumn:@"is_has_image"]];
        rtn.is_selected = [NSNumber numberWithInt:[result intForColumn:@"is_selected"]];
        rtn.is_canceled = [NSNumber numberWithInt:[result intForColumn:@"is_canceled"]];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
        rtn.create_time = [result dateForColumn:@"create_time"];
        rtn.update_userid = [result stringForColumn:@"update_userid"];
        rtn.update_time = [result dateForColumn:@"update_time"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_vehicle_edition_setting_his WHERE %@ ORDER BY %@ LIMIT 0,%d", where, order, top];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_vehicle_edition_setting_his *rtn = [[client_vehicle_edition_setting_his alloc] init];
        rtn.vehicle_edition_setting_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_setting_id"]];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_edition_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_id"]];
        rtn.group_code = [result stringForColumn:@"group_code"];
        rtn.sale_group_code = [result stringForColumn:@"sale_group_code"];
        rtn.op_code = [result stringForColumn:@"op_code"];
        rtn.op_name = [result stringForColumn:@"op_name"];
        rtn.sale_op_name = [result stringForColumn:@"sale_op_name"];
        rtn.op_seq = [result stringForColumn:@"op_seq"];
        rtn.op_value_code = [result stringForColumn:@"op_value_code"];
        rtn.op_value_name = [result stringForColumn:@"op_value_name"];
        rtn.sale_op_value_name = [result stringForColumn:@"sale_op_value_name"];
        rtn.op_value_level_code = [NSNumber numberWithInt:[result intForColumn:@"op_value_level_code"]];
        rtn.op_value_std_price = [NSNumber numberWithDouble:[result doubleForColumn:@"op_value_std_price"]];
        rtn.op_value_del_price = [NSNumber numberWithDouble:[result doubleForColumn:@"op_value_del_price"]];
        rtn.op_show_grade_disid = [NSNumber numberWithInt:[result intForColumn:@"op_show_grade_disid"]];
        rtn.view_desc = [result stringForColumn:@"view_desc"];
        rtn.is_displayed = [NSNumber numberWithInt:[result intForColumn:@"is_displayed"]];
        rtn.is_displayed_config = [NSNumber numberWithInt:[result intForColumn:@"is_displayed_config"]];
        rtn.is_allow_edited = [NSNumber numberWithInt:[result intForColumn:@"is_allow_edited"]];
        rtn.is_has_image = [NSNumber numberWithInt:[result intForColumn:@"is_has_image"]];
        rtn.is_selected = [NSNumber numberWithInt:[result intForColumn:@"is_selected"]];
        rtn.is_canceled = [NSNumber numberWithInt:[result intForColumn:@"is_canceled"]];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
        rtn.create_time = [result dateForColumn:@"create_time"];
        rtn.update_userid = [result stringForColumn:@"update_userid"];
        rtn.update_time = [result dateForColumn:@"update_time"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_vehicle_edition_setting_his WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_vehicle_edition_setting_his *rtn = [[client_vehicle_edition_setting_his alloc] init];
        rtn.vehicle_edition_setting_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_setting_id"]];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_edition_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_id"]];
        rtn.group_code = [result stringForColumn:@"group_code"];
        rtn.sale_group_code = [result stringForColumn:@"sale_group_code"];
        rtn.op_code = [result stringForColumn:@"op_code"];
        rtn.op_name = [result stringForColumn:@"op_name"];
        rtn.sale_op_name = [result stringForColumn:@"sale_op_name"];
        rtn.op_seq = [result stringForColumn:@"op_seq"];
        rtn.op_value_code = [result stringForColumn:@"op_value_code"];
        rtn.op_value_name = [result stringForColumn:@"op_value_name"];
        rtn.sale_op_value_name = [result stringForColumn:@"sale_op_value_name"];
        rtn.op_value_level_code = [NSNumber numberWithInt:[result intForColumn:@"op_value_level_code"]];
        rtn.op_value_std_price = [NSNumber numberWithDouble:[result doubleForColumn:@"op_value_std_price"]];
        rtn.op_value_del_price = [NSNumber numberWithDouble:[result doubleForColumn:@"op_value_del_price"]];
        rtn.op_show_grade_disid = [NSNumber numberWithInt:[result intForColumn:@"op_show_grade_disid"]];
        rtn.view_desc = [result stringForColumn:@"view_desc"];
        rtn.is_displayed = [NSNumber numberWithInt:[result intForColumn:@"is_displayed"]];
        rtn.is_displayed_config = [NSNumber numberWithInt:[result intForColumn:@"is_displayed_config"]];
        rtn.is_allow_edited = [NSNumber numberWithInt:[result intForColumn:@"is_allow_edited"]];
        rtn.is_has_image = [NSNumber numberWithInt:[result intForColumn:@"is_has_image"]];
        rtn.is_selected = [NSNumber numberWithInt:[result intForColumn:@"is_selected"]];
        rtn.is_canceled = [NSNumber numberWithInt:[result intForColumn:@"is_canceled"]];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
        rtn.create_time = [result dateForColumn:@"create_time"];
        rtn.update_userid = [result stringForColumn:@"update_userid"];
        rtn.update_time = [result dateForColumn:@"update_time"];
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
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_vehicle_edition_setting_his WHERE %@ ORDER BY %@ LIMIT %d,%d", where, order, beginIndex, length];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_vehicle_edition_setting_his *rtn = [[client_vehicle_edition_setting_his alloc] init];
        rtn.vehicle_edition_setting_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_setting_id"]];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_edition_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_id"]];
        rtn.group_code = [result stringForColumn:@"group_code"];
        rtn.sale_group_code = [result stringForColumn:@"sale_group_code"];
        rtn.op_code = [result stringForColumn:@"op_code"];
        rtn.op_name = [result stringForColumn:@"op_name"];
        rtn.sale_op_name = [result stringForColumn:@"sale_op_name"];
        rtn.op_seq = [result stringForColumn:@"op_seq"];
        rtn.op_value_code = [result stringForColumn:@"op_value_code"];
        rtn.op_value_name = [result stringForColumn:@"op_value_name"];
        rtn.sale_op_value_name = [result stringForColumn:@"sale_op_value_name"];
        rtn.op_value_level_code = [NSNumber numberWithInt:[result intForColumn:@"op_value_level_code"]];
        rtn.op_value_std_price = [NSNumber numberWithDouble:[result doubleForColumn:@"op_value_std_price"]];
        rtn.op_value_del_price = [NSNumber numberWithDouble:[result doubleForColumn:@"op_value_del_price"]];
        rtn.op_show_grade_disid = [NSNumber numberWithInt:[result intForColumn:@"op_show_grade_disid"]];
        rtn.view_desc = [result stringForColumn:@"view_desc"];
        rtn.is_displayed = [NSNumber numberWithInt:[result intForColumn:@"is_displayed"]];
        rtn.is_displayed_config = [NSNumber numberWithInt:[result intForColumn:@"is_displayed_config"]];
        rtn.is_allow_edited = [NSNumber numberWithInt:[result intForColumn:@"is_allow_edited"]];
        rtn.is_has_image = [NSNumber numberWithInt:[result intForColumn:@"is_has_image"]];
        rtn.is_selected = [NSNumber numberWithInt:[result intForColumn:@"is_selected"]];
        rtn.is_canceled = [NSNumber numberWithInt:[result intForColumn:@"is_canceled"]];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
        rtn.create_time = [result dateForColumn:@"create_time"];
        rtn.update_userid = [result stringForColumn:@"update_userid"];
        rtn.update_time = [result dateForColumn:@"update_time"];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (client_vehicle_edition_setting_his *)convertJsonToModel:(NSDictionary *)json
{
    client_vehicle_edition_setting_his *model = [[client_vehicle_edition_setting_his alloc] init];
    model.vehicle_edition_setting_id = [json objectForKey:@"vehicle_edition_setting_id"];
    model.vehicle_configurator_id = [json objectForKey:@"vehicle_configurator_id"];
    model.vehicle_edition_id = [json objectForKey:@"vehicle_edition_id"];
    model.group_code = [json objectForKey:@"group_code"];
    model.sale_group_code = [json objectForKey:@"sale_group_code"];
    model.op_code = [json objectForKey:@"op_code"];
    model.op_name = [json objectForKey:@"op_name"];
    model.sale_op_name = [json objectForKey:@"sale_op_name"];
    model.op_seq = [json objectForKey:@"op_seq"];
    model.op_value_code = [json objectForKey:@"op_value_code"];
    model.op_value_name = [json objectForKey:@"op_value_name"];
    model.sale_op_value_name = [json objectForKey:@"sale_op_value_name"];
    model.op_value_level_code = [json objectForKey:@"op_value_level_code"];
    model.op_value_std_price = [json objectForKey:@"op_value_std_price"];
    model.op_value_del_price = [json objectForKey:@"op_value_del_price"];
    model.op_show_grade_disid = [json objectForKey:@"op_show_grade_disid"];
    model.view_desc = [json objectForKey:@"view_desc"];
    model.is_displayed = [json objectForKey:@"is_displayed"];
    model.is_displayed_config = [json objectForKey:@"is_displayed_config"];
    model.is_allow_edited = [json objectForKey:@"is_allow_edited"];
    model.is_has_image = [json objectForKey:@"is_has_image"];
    model.is_selected = [json objectForKey:@"is_selected"];
    model.is_canceled = [json objectForKey:@"is_canceled"];
    model.create_userid = [json objectForKey:@"create_userid"];
    model.create_time =[BaseInfo getDateFromMSDateString:[json objectForKey:@"create_time"]];
    model.update_userid = [json objectForKey:@"update_userid"];
    model.update_time =[BaseInfo getDateFromMSDateString:[json objectForKey:@"update_time"]];
    model.data_version = [json objectForKey:@"data_version"];
    return model;
}

+ (NSArray *)convertJsonToList:(NSArray *)jsons
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *json in jsons) {
        client_vehicle_edition_setting_his *model = [[client_vehicle_edition_setting_his alloc] init];
        model.vehicle_edition_setting_id = [json objectForKey:@"vehicle_edition_setting_id"];
        model.vehicle_configurator_id = [json objectForKey:@"vehicle_configurator_id"];
        model.vehicle_edition_id = [json objectForKey:@"vehicle_edition_id"];
        model.group_code = [json objectForKey:@"group_code"];
        model.sale_group_code = [json objectForKey:@"sale_group_code"];
        model.op_code = [json objectForKey:@"op_code"];
        model.op_name = [json objectForKey:@"op_name"];
        model.sale_op_name = [json objectForKey:@"sale_op_name"];
        model.op_seq = [json objectForKey:@"op_seq"];
        model.op_value_code = [json objectForKey:@"op_value_code"];
        model.op_value_name = [json objectForKey:@"op_value_name"];
        model.sale_op_value_name = [json objectForKey:@"sale_op_value_name"];
        model.op_value_level_code = [json objectForKey:@"op_value_level_code"];
        model.op_value_std_price = [json objectForKey:@"op_value_std_price"];
        model.op_value_del_price = [json objectForKey:@"op_value_del_price"];
        model.op_show_grade_disid = [json objectForKey:@"op_show_grade_disid"];
        model.view_desc = [json objectForKey:@"view_desc"];
        model.is_displayed = [json objectForKey:@"is_displayed"];
        model.is_displayed_config = [json objectForKey:@"is_displayed_config"];
        model.is_allow_edited = [json objectForKey:@"is_allow_edited"];
        model.is_has_image = [json objectForKey:@"is_has_image"];
        model.is_selected = [json objectForKey:@"is_selected"];
        model.is_canceled = [json objectForKey:@"is_canceled"];
        model.create_userid = [json objectForKey:@"create_userid"];
        model.create_time =[BaseInfo getDateFromMSDateString:[json objectForKey:@"create_time"]];
        model.update_userid = [json objectForKey:@"update_userid"];
        model.update_time =[BaseInfo getDateFromMSDateString:[json objectForKey:@"update_time"]];
        model.data_version = [json objectForKey:@"data_version"];
        [array addObject:model];
    }
    return array;
}

+ (NSArray *)getListForPriceTable:(NSString *)where
{
    NSString *dbPath = [BaseInfo getDataBasePath];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_vehicle_edition_setting_his WHERE %@ ORDER BY op_seq ASC", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_vehicle_edition_setting_his *rtn = [[client_vehicle_edition_setting_his alloc] init];
        rtn.vehicle_edition_setting_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_setting_id"]];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_edition_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_id"]];
        rtn.group_code = [result stringForColumn:@"group_code"];//[NSNumber numberWithInt:[result intForColumn:@"group_code"]];
        rtn.sale_group_code = [result stringForColumn:@"sale_group_code"];//[NSNumber numberWithInt:[result intForColumn:@"sale_group_code"]];
        rtn.op_code = [result stringForColumn:@"op_code"];
        rtn.op_name = [result stringForColumn:@"op_name"];
        rtn.sale_op_name = [result stringForColumn:@"sale_op_name"];
        rtn.op_seq = [result stringForColumn:@"op_seq"];
        rtn.op_value_code = [result stringForColumn:@"op_value_code"];
        rtn.op_value_name = [result stringForColumn:@"op_value_name"];
        rtn.sale_op_value_name = [result stringForColumn:@"sale_op_value_name"];
        rtn.op_value_level_code = [NSNumber numberWithInt:[result intForColumn:@"op_value_level_code"]];
        rtn.op_value_std_price = [NSNumber numberWithDouble:[result doubleForColumn:@"op_value_std_price"]];
        rtn.op_value_del_price = [NSNumber numberWithDouble:[result doubleForColumn:@"op_value_del_price"]];
        rtn.op_show_grade_disid = [NSNumber numberWithInt:[result intForColumn:@"op_show_grade_disid"]];
        rtn.view_desc = [result stringForColumn:@"view_desc"];
        rtn.is_displayed = [NSNumber numberWithInt:[result intForColumn:@"is_displayed"]];
        rtn.is_displayed_config = [NSNumber numberWithInt:[result intForColumn:@"is_displayed_config"]];
        rtn.is_allow_edited = [NSNumber numberWithInt:[result intForColumn:@"is_allow_edited"]];
        rtn.is_has_image = [NSNumber numberWithInt:[result intForColumn:@"is_has_image"]];
        rtn.is_selected = [NSNumber numberWithInt:[result intForColumn:@"is_selected"]];
        rtn.is_canceled = [NSNumber numberWithInt:[result intForColumn:@"is_canceled"]];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
        rtn.create_time = [result dateForColumn:@"create_time"];
        rtn.update_userid = [result stringForColumn:@"update_userid"];
        rtn.update_time = [result dateForColumn:@"update_time"];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        [array addObject:rtn];
    }
    [db close];
    return array;
}

+ (NSNumber *)getMaxId:(FMDatabase *)db
{
    NSNumber *rtn;
    FMResultSet *result = [db executeQuery:@"SELECT MAX(vehicle_edition_setting_id) FROM client_vehicle_edition_setting_his"];
    if ([result next]) {
        int maxId = [result intForColumnIndex:0] + 1;
        rtn = [NSNumber numberWithInt:maxId];
    }
    return rtn;
}

+ (NSArray *)getListForPriceTable:(NSString *)where db:(FMDatabase *)db
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM client_vehicle_edition_setting_his WHERE %@", where];
    FMResultSet *result = [db executeQuery:strSql];
    while ([result next]) {
        client_vehicle_edition_setting_his *rtn = [[client_vehicle_edition_setting_his alloc] init];
        rtn.vehicle_edition_setting_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_setting_id"]];
        rtn.vehicle_configurator_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_configurator_id"]];
        rtn.vehicle_edition_id = [NSNumber numberWithInt:[result intForColumn:@"vehicle_edition_id"]];
        rtn.group_code = [result stringForColumn:@"group_code"];//[NSNumber numberWithInt:[result intForColumn:@"group_code"]];
        rtn.sale_group_code = [result stringForColumn:@"sale_group_code"];//[NSNumber numberWithInt:[result intForColumn:@"sale_group_code"]];
        rtn.op_code = [result stringForColumn:@"op_code"];
        rtn.op_name = [result stringForColumn:@"op_name"];
        rtn.sale_op_name = [result stringForColumn:@"sale_op_name"];
        rtn.op_seq = [result stringForColumn:@"op_seq"];
        rtn.op_value_code = [result stringForColumn:@"op_value_code"];
        rtn.op_value_name = [result stringForColumn:@"op_value_name"];
        rtn.sale_op_value_name = [result stringForColumn:@"sale_op_value_name"];
        rtn.op_value_level_code = [NSNumber numberWithInt:[result intForColumn:@"op_value_level_code"]];
        rtn.op_value_std_price = [NSNumber numberWithDouble:[result doubleForColumn:@"op_value_std_price"]];
        rtn.op_value_del_price = [NSNumber numberWithDouble:[result doubleForColumn:@"op_value_del_price"]];
        rtn.op_show_grade_disid = [NSNumber numberWithInt:[result intForColumn:@"op_show_grade_disid"]];
        rtn.view_desc = [result stringForColumn:@"view_desc"];
        rtn.is_displayed = [NSNumber numberWithInt:[result intForColumn:@"is_displayed"]];
        rtn.is_displayed_config = [NSNumber numberWithInt:[result intForColumn:@"is_displayed_config"]];
        rtn.is_allow_edited = [NSNumber numberWithInt:[result intForColumn:@"is_allow_edited"]];
        rtn.is_has_image = [NSNumber numberWithInt:[result intForColumn:@"is_has_image"]];
        rtn.is_selected = [NSNumber numberWithInt:[result intForColumn:@"is_selected"]];
        rtn.is_canceled = [NSNumber numberWithInt:[result intForColumn:@"is_canceled"]];
        rtn.create_userid = [result stringForColumn:@"create_userid"];
        rtn.create_time = [result dateForColumn:@"create_time"];
        rtn.update_userid = [result stringForColumn:@"update_userid"];
        rtn.update_time = [result dateForColumn:@"update_time"];
        rtn.data_version = [NSNumber numberWithInt:[result intForColumn:@"data_version"]];
        [array addObject:rtn];
    }
    return array;
}

@end