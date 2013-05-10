//
//  CarColorViewModel.h
//  HigerVise
//
//  Created by Kevin.Mao on 12-10-31.
//  Copyright (c) 2012年 JijeSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    CarColorLoadSuccess             = 1000,     //加载成功
    CarColorUpdateSuccess           = 1001,     //更新成功
    
    CarColorUpdateErrorNotNet       = 1101,     //系统网络异常
    CarColorUpdateErrorUserKey      = 1102,     //帐号交互密钥错误
} CarColorResult;

@interface CarColorViewModel : NSObject

@property (strong, nonatomic) NSNumber *result;
@property (strong, nonatomic) NSArray *groups;

@property (assign, nonatomic) int sumCount;
@property (assign, nonatomic) int finishedCount;
@property (assign, nonatomic) int failedCount;

@end
