//
//  LSCollectPE.m
//  Locoso
//
//  Created by yongchang hu on 12-3-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSCollectPE.h"
#import "FileStoreManager.h"
@implementation LSCollectPE
- (void)sendRequest
{
    _state = LSProtocolEngineState_Loading;
    [NSThread detachNewThreadSelector:@selector(getWatchHistory) toTarget:self withObject:nil];
}

- (void)getWatchHistory
{
    @synchronized (self)
    {
        self.rspData = [[[LSListRspData alloc] init] autorelease];
        
        NSString* controllerClassName = @"LSBookDetailViewControllercollection.rtf";
        NSArray* tempdata = [FileStoreManager ReadDataFromFile:controllerClassName];
        NSInteger tempCount = [tempdata count];
        if (tempCount == 0)
        {
            //noop
        }
        else
        {
            if (tempCount > 20)
            {
                NSRange range = NSMakeRange(tempCount - 20, 20);
                tempdata = [tempdata subarrayWithRange:range];
            }
        }
        
        NSMutableArray* arrCompany = [[NSMutableArray alloc] initWithCapacity:20];
        for (id content in tempdata)
        {
            LSDataBook* company = [LSParseDataUtils parseBook:content];
            if (company)
            {
                [arrCompany addObject:company];
            }
        }
        self.rspData.arrContent = arrCompany;
        [self performSelectorOnMainThread:@selector(getCollectingFinished) withObject:nil waitUntilDone:NO];
    }
}

- (void)getCollectingFinished
{
    _state = LSProtocolEngineState_Finished;
    _op = LSProtocolEngineOp_Pending;
    [_delegate didProtocolEngineFinished:self newData:self.rspData];
}
@end
