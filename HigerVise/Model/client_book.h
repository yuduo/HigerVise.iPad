//
//  client_book.h
//  HigerManage
//
//  Created by jijesoft on 13-5-20.
//  Copyright (c) 2013年 WuHanNvl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface client_book : NSObject
@property (nonatomic, strong) NSString * resource_url;
@property (nonatomic, strong) NSString * resource_title;
@property (nonatomic, strong) NSString * resource_size;
@property (nonatomic, strong) NSNumber * resource_type;
@property (nonatomic, strong) NSNumber * resource_master_id;
@property (nonatomic, strong) NSString * resource_thum_url;
@end
