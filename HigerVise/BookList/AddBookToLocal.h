//
//  AddBookToLocal.h
//  HigerManage
//
//  Created by jijesoft on 13-5-21.
//  Copyright (c) 2013年 WuHanNvl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSData.h"
@interface AddBookToLocal : NSObject
+(void)addBookToArray:(LSDataBook*)detail;
+(void)saveCompanyIDArrayDataToFile:(NSArray*)savedata;
@end
