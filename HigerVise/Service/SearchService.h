//
//  SearchService.h
//  HigerVise
//
//  Created by Kevin.Mao on 12-10-12.
//  Copyright (c) 2012年 JijeSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseInfo.h"
#import "ConfigInfo.h"
#import "UserInfo.h"
#import "SearchViewModel.h"

@interface SearchService : NSObject
{
    SearchViewModel *_searchViewModel;
    int _vehicle_class_id;
}

- (id)initWithViewModel:(SearchViewModel *)searchViewModel;
- (void)loadSearchConditions:(NSNumber *)vehicleClassId;
- (void)loadSearchOptions:(NSNumber *)index;
- (void)loadSearchPrompts:(NSString *)condition;
- (void)loadSearchResults:(NSString *)condition;
- (void)loadSearchResults:(NSString *)condition pageNumber:(NSNumber *)pageNumber;

@end
