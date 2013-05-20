//
//  LSListProtocolEngine.m
//  Locoso
//
//  Created by yongchang hu on 12-3-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSListProtocolEngine.h"

//
//LSListProtocolEngine
//
#pragma mark - LSListProtocolEngine
@implementation LSListProtocolEngine
@synthesize pageNo = _pageNo;
@synthesize pageSize = _pageSize;
@synthesize rspData = _rspData;

- (void)dealloc
{
    self.rspData = nil;
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        [self setPageParamsDefault];
    }
    return self;
}

- (void)setPageParamsDefault
{
    _pageNo = 1;
    _pageSize = 10;
}

- (NSString*)requestURLByAppendPageParams:(NSString*)aURL
{
    NSString* strURL = aURL;
    if (_pageNo > 1)
    {
        strURL = [strURL stringByAppendingFormat:@"&pageindex=%d", _pageNo];
    }
    if (_pageSize > 0)
    {
        strURL = [strURL stringByAppendingFormat:@"&pagesize=%d", _pageSize];
    }
    return strURL;
}

- (void)reset
{
    [self setPageParamsDefault];
    [super reset];
}

- (LSBaseResponseData*)parseResponseData:(NSString*)aResponseString
{
    id jsonValue = [aResponseString JSONValue];
    if (nil == jsonValue)
    {
        return nil;
    }
    
    NSArray* jsonArray = (NSArray*)jsonValue;
    NSMutableArray* arrContent = [[NSMutableArray alloc] initWithCapacity:10];
    for (id content in jsonArray)
    {
        if ([content isKindOfClass:[NSDictionary class]])
        {
            id contentData = [self parseContent:content];
            if (contentData)
            {
                [arrContent addObject:contentData];
            }
        }
        else if ([content isKindOfClass:[NSString class]])
        {
            [arrContent addObject:content];
        }
    }
    
    LSListRspData* rspData = [[[LSListRspData alloc] init] autorelease];
    rspData.arrContent = arrContent;
    [arrContent release];
    
    return rspData;
}

- (BOOL)handleResponseData:(LSBaseResponseData*)aNewData
{
    if (LSProtocolEngineOp_Refresh == _op)
    {
        self.rspData = (LSListRspData*)aNewData;
    }
    else if (LSProtocolEngineOp_More == _op)
    {
        LSListRspData* newData = (LSListRspData*)aNewData;
        [self.rspData.arrContent addObjectsFromArray:newData.arrContent];
    }
    return [super handleResponseData:aNewData];
}

- (id)parseContent:(id)aContent
{
    return nil;
}
@end


//
//LSListRspData
//
#pragma mark - LSListRspData
@implementation LSListRspData
@synthesize arrContent = _arrContent;

- (void)dealloc
{
    self.arrContent = nil;
    [super dealloc];
}
@end