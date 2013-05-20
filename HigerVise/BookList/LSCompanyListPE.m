//
//  LSCompanyListPE.m
//  Locoso
//
//  Created by yongchang hu on 12-3-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSCompanyListPE.h"

@implementation LSCompanyListPE
- (id)parseContent:(id)aContent
{
    return [LSParseDataUtils parseCompany:aContent];
}
@end