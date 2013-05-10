//
//  SearchService.m
//  HigerVise
//
//  Created by Kevin.Mao on 12-10-12.
//  Copyright (c) 2012年 JijeSoft. All rights reserved.
//

#import "SearchService.h"

@implementation SearchService

- (id)initWithViewModel:(SearchViewModel *)searchViewModel
{
    self = [super init];
    if (self) {
        _searchViewModel = searchViewModel;
    }
    return self;
}

- (void)dealloc
{
    _searchViewModel = nil;
}

- (void)loadSearchOptions:(NSNumber *)index
{
    int vehicle_class_id = _vehicle_class_id;
    client_search *search = [_searchViewModel.searchConditions objectAtIndex:[index intValue]];
    int search_id = [search.search_id intValue];
    
    if ([search.field_name isEqualToString:@"vehicle_series"]) {
        search.search_options = [client_search_option_dal getListForSearch:[NSString stringWithFormat:@"search_id=%d AND vehicle_class_id=%d ORDER BY field_value ASC", search_id, vehicle_class_id]];//获取某车型系列的车系数据
        
        //获取车系条件选项对应的约束条件以及选项
        for (int j = 0; j < search.search_options.count; j++) {
            client_search_option *search_option = [search.search_options objectAtIndex:j];
            int search_option_id = [search_option.search_option_id intValue];
            NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
            for (int k = 0; k < _searchViewModel.searchConditions.count; k++) {
                int slave_search_id = [((client_search *)[_searchViewModel.searchConditions objectAtIndex:k]).search_id intValue];
                if (slave_search_id != search_id) {
                    
                    NSArray *array = [client_search_option_dal getListByMasterSearchOption:search_option_id slave_search_id:slave_search_id];
                    
                    if (array.count > 0) {
                        [dictionary setValue:array forKey:[[NSNumber numberWithInt:slave_search_id] stringValue]];
                    } 
                }
            }
            search_option.search_option_relations = dictionary;
            //search_option.search_option_relations = [client_search_option_relation_dal getList:[NSString stringWithFormat:@"master_search_option_id=%d", search_option_id]];
            //search_option.search_option_setting_relations = [client_search_option_setting_relation_dal getList:[NSString stringWithFormat:@"search_option_id=%d", search_option_id]];
        }
    }
    else {
        search.search_options = [client_search_option_dal getListByVehcileClass:vehicle_class_id field_name:@"vehicle_series" slave_search_id:search_id];
        if (search.search_options.count <= 0) {
            search.search_options = [client_search_option_dal getListForSearch:[NSString stringWithFormat:@"search_id=%d ORDER BY field_value ASC", search_id]];
        }
    }

    [_searchViewModel setValue:[NSNumber numberWithInt:SearchLoadOptionSuccess] forKey:@"result"];
}

- (void)loadSearchConditions:(NSNumber *)vehicleClassId
{
    _vehicle_class_id = [vehicleClassId intValue];
    NSArray *searchs = [client_search_dal getListForSearch];
    _searchViewModel.searchConditions = searchs;
    [_searchViewModel setValue:[NSNumber numberWithInt:SearchLoadConditionSuccess] forKey:@"result"];
}

- (void)loadSearchPrompts:(NSString *)condition
{
    //根据条件搜索结果，八个条件＋搜索框公告车型模糊搜索
    _searchViewModel.searchPrompts = [client_vehicle_configurator_dal getListForPrompt:condition];
    [_searchViewModel setValue:[NSNumber numberWithInt:SearchLoadPromptSuccess] forKey:@"result"];
}

- (void)loadSearchResults:(NSString *)condition pageNumber:(NSNumber *)pageNumber
{
    //根据条件搜索结果，八个条件＋搜索框全文模糊搜索
    NSArray *vehicles = [client_vehicle_configurator_dal getListForResult:condition order:@"vehicle_series,item_model ASC" page:[pageNumber intValue] pageSize:kSearchResultPageSize];
    //NSArray *vehicles = [client_vehicle_configurator_dal getListForResult:condition];
    for (int i = 0; i <vehicles.count; i++) {
        client_vehicle_configurator *vehicle = [vehicles objectAtIndex:i];
        NSArray *images = [client_image_dal getList:[NSString stringWithFormat:@"image_type=1002 AND reference_id='%@'", vehicle.vehicle_code]];
        if (images.count > 0) {
            client_image *image = [images objectAtIndex:0];
            vehicle.image_url = [BaseInfo getImageFullPath:image.image_url];
            vehicle.image_data_version = image.data_version;
        }
        else {
            vehicle.image_url = [BaseInfo getImageFullPath:@""];
            vehicle.image_data_version = [NSNumber numberWithInt:0];
        }
    }
    [((NSMutableArray *)_searchViewModel.searchResults) addObjectsFromArray:vehicles];
    [_searchViewModel setValue:[NSNumber numberWithInt:SearchLoadResultPageSuccess] forKey:@"result"];
}

- (void)loadSearchResults:(NSString *)condition
{
    //根据条件搜索结果，八个条件＋搜索框全文模糊搜索
    NSArray *vehicles = [client_vehicle_configurator_dal getListForResult:condition order:@"vehicle_series,item_model ASC" page:1 pageSize:kSearchResultPageSize];
    //NSArray *vehicles = [client_vehicle_configurator_dal getListForResult:condition];
    for (int i = 0; i <vehicles.count; i++) {
        client_vehicle_configurator *vehicle = [vehicles objectAtIndex:i];
        NSArray *images = [client_image_dal getList:[NSString stringWithFormat:@"image_type=1002 AND reference_id='%@'", vehicle.vehicle_code]];
        if (images.count > 0) {
            client_image *image = [images objectAtIndex:0];
            vehicle.image_url = [BaseInfo getImageFullPath:image.image_url];
            vehicle.image_data_version = image.data_version;
        }
        else {
            vehicle.image_url = [BaseInfo getImageFullPath:@""];
            vehicle.image_data_version = [NSNumber numberWithInt:0];
        }
    }
    _searchViewModel.searchResults = vehicles;
    [_searchViewModel setValue:[NSNumber numberWithInt:SearchLoadResultSuccess] forKey:@"result"];
}

@end
