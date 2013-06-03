//
//  AddBookToLocal.m
//  HigerManage
//
//  Created by jijesoft on 13-5-21.
//  Copyright (c) 2013年 WuHanNvl. All rights reserved.
//

#import "AddBookToLocal.h"
#import "FileStoreManager.h"
#import "LSData.h"
@implementation AddBookToLocal
+(void)addBookToArray:(LSDataBook*)detail
{
//    LSDataBook *detail ;//= _companyInfoPE.rspData.arrCategory;
    
    if (detail.bookID == 0) {
        return;
    }
    NSInteger dataID = detail.bookID;
    NSString* controllerClassName = @"LSBookDetailViewControllercollection.rtf";
    
    NSArray *tempdata = [FileStoreManager ReadDataFromFile:controllerClassName];
    for (NSMutableDictionary * member in tempdata) {
        NSLog(@"id1 = %d id2 = %d",dataID,[[member objectForKey:@"bookID"] unsignedIntValue]);
        if([[member objectForKey:@"bookID"] unsignedIntValue] == dataID)
            return;
    }
    NSMutableArray *newArray = [NSMutableArray arrayWithArray:tempdata];
    
    
    [newArray addObject:
     [NSMutableDictionary dictionaryWithObjectsAndKeys:
      [NSNumber numberWithInt:detail.bookID], @"bookID",
      detail.bookName!=nil?detail.bookName:[NSNull null], @"bookName",
      detail.local_resource!=nil?detail.local_resource:[NSNull null], @"local_resource",
      detail.createTime!=nil?detail.createTime:[NSNull null], @"createTime",
      detail.logo != nil ? detail.logo:[NSNull null] ,@"logo",
      [NSNumber numberWithInt:detail.bookType] ,@"bookType",
      
      nil]
     ];
    
    [self saveCompanyIDArrayDataToFile:newArray];
    
    
}

+(void)saveCompanyIDArrayDataToFile:(NSArray*)savedata
{
    NSString* controllerClassName = @"LSBookDetailViewControllercollection.rtf";
    [FileStoreManager SaveDataToFile:savedata fileName:controllerClassName];
}
@end
