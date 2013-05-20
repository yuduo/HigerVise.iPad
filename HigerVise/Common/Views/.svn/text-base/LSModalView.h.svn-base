//
//  LSModalView.h
//  Locoso
//
//  Created by zhiwei ma on 12-3-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LSViewUtilsStringConfirm            @"确定"
#define LSViewUtilsStringCancel             @"取消"

@interface LSModalAlertView : NSObject
+ (void)messageBox:(NSString*)aTitle message:(NSString*)aMessage;
+ (NSUInteger)confirmMessageBox:(NSString*)aTitle message:(NSString*)aMessage;
+ (NSUInteger)confirmMessageBox:(NSString*)aTitle message:(NSString*)aMessage cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitles;
+ (NSUInteger)selectBox:(NSString*)aTitle message:(NSString*)aMessage cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles,...;
@end
