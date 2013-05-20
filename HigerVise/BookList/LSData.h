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
//LSDataCompany
//
@interface LSDataCompany : NSObject
{
    long            _companyID;
    NSString*       _companyName;
    NSString*       _logo;
    NSString*       _address;
    NSInteger       _state;//认证状态
    
}
@property (nonatomic) long companyID;
@property (nonatomic, retain) NSString* companyName;
@property (nonatomic, retain) NSString* logo;
@property (nonatomic, retain) NSString* address;
@property (nonatomic) NSInteger state;
@end