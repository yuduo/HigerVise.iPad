//
//  LSData.h
//  HigerManage
//
//  Created by jijesoft on 13-5-17.
//  Copyright (c) 2013年 WuHanNvl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSData : NSObject

@end
//
//LSDataBook
//
@interface LSDataBook : NSObject
{
    long            _bookID;
    NSString*       _bookName;
    NSString*       _logo;
    NSString*       _local_resource;
    NSInteger       _bookType;
    
}
@property (nonatomic) long bookID;
@property (nonatomic, retain) NSString* bookName;
@property (nonatomic, retain) NSString* logo;
@property (nonatomic, retain) NSString* local_resource;
@property (nonatomic) NSInteger bookType;
@property (nonatomic) NSInteger bookSize;
@property (nonatomic, retain) NSString *createTime;
@end