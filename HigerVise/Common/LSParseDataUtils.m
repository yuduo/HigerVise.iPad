//
//  LSParseDataUtils.m
//  Locoso
//
//  Created by yongchang hu on 12-3-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSParseDataUtils.h"

@implementation LSParseDataUtils
+ (LSDataBook*)parseBook:(NSDictionary*)aJSONData
{
    LSDataBook* company = [[[LSDataBook alloc] init] autorelease];
    
    company.bookID = [[aJSONData valueForKey:@"bookID"] longValue];
    company.bookName = [aJSONData valueForKey:@"bookName"];
    company.logo = [aJSONData valueForKey:@"logo"];
//    company.logo = @"Book_Cover.png";
    company.local_resource = [aJSONData valueForKey:@"local_resource"];
    company.createTime = [aJSONData valueForKey:@"createTime"];
    company.bookType  = [[aJSONData valueForKey:@"bookType"] integerValue];
    return company;
}
@end
