//
//  SearchViewModel.h
//  HigerVise
//
//  Created by Kevin.Mao on 12-10-12.
//  Copyright (c) 2012年 JijeSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    SearchLoadConditionSuccess      = 1000, //加载成功
    SearchLoadPromptSuccess         = 1001, //提示加载成功
    SearchLoadResultSuccess         = 1002, //数据加载成功
    SearchLoadResultPageSuccess     = 1003, //分页数据加载成功
    SearchLoadOptionSuccess         = 1004, //条件选项加载成功
} SearchResult;

@interface SearchViewModel : NSObject

@property (strong, nonatomic) NSNumber *result;
@property (strong, nonatomic) NSArray *searchConditions;//用于存储搜索条件
@property (strong, nonatomic) NSArray *searchResults;//用于存储搜索出来的数据结果
@property (strong, nonatomic) NSArray *searchPrompts;//用于存储搜索提示的关键字集合

@end
