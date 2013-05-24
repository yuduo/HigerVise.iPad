//
//  LSBookListPE.m
//  Locoso
//
//  Created by yongchang hu on 12-3-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSBookListPE.h"

@implementation LSBookListPE
- (id)parseContent:(id)aContent
{
    return [LSParseDataUtils parseBook:aContent];
}
@end