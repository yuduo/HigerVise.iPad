//
//  LSListProtocolEngine.h
//  Locoso
//
//  Created by yongchang hu on 12-3-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSBaseProtocolEngine.h"

#import "SBJson.h"

#import "LSParseDataUtils.h"

@class LSListRspData;
@interface LSListProtocolEngine : LSBaseProtocolEngine
{
    NSInteger _pageNo;
    NSInteger _pageSize;
    LSListRspData* _rspData;
}
@property (nonatomic) NSInteger pageNo;
@property (nonatomic) NSInteger pageSize;
@property (nonatomic, retain) LSListRspData* rspData;

- (void)setPageParamsDefault;
- (NSString*)requestURLByAppendPageParams:(NSString*)aURL;

//---子类重载-----
- (id)parseContent:(id)aContent;//noop.解析array中的某个index的数据
@end

@interface LSListRspData : LSBaseResponseData
{
    NSMutableArray* _arrContent;
}
@property (nonatomic, retain) NSMutableArray* arrContent;
@end