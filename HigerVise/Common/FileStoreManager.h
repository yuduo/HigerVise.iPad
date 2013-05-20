//
//  FileStoreManager.h
//  Locoso
//
//  Created by yongchang hu on 11-12-31.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileStoreManager: NSObject
+(void)SaveDataToFile:(NSArray*)persistentArray fileName:(NSString*)myFilename;
+(NSArray*)ReadDataFromFile:(NSString*)myFilename;
@end
