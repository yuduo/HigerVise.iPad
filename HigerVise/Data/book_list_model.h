//
//  book_list_model.h
//  HigerManage
//
//  Created by jijesoft on 13-5-20.
//  Copyright (c) 2013年 WuHanNvl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface book_list_model : NSObject
+(NSArray*)getBookList:(NSInteger)index;
+(NSArray*)getBookListAll;
+(void)updateBookListMarked:(NSString*)sql;
+(void)updateBookListUnMark:(NSString*)sql;
+(NSArray*)getMarkedBookList;
@end
