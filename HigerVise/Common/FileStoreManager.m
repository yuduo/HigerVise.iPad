//
//  FileStoreManager.m
//  Locoso
//
//  Created by yongchang hu on 11-12-31.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "FileStoreManager.h"
@implementation FileStoreManager

+(void)SaveDataToFile:(NSArray*)persistentArray fileName:(NSString*)myFilename
{
    
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,    NSAllDomainsMask, YES);
    
    int pathLen = [pathArray count];
    
    NSLog(@"path number is :%d",pathLen);
    
    NSString *filePath = nil;
    
    for(int i = 0; i < pathLen; i++)
    {
        filePath = [pathArray objectAtIndex:i];
        NSLog(@"%d path is :%@",i,filePath);
    }
        
    myFilename = [filePath stringByAppendingPathComponent:myFilename];
    NSLog(@"myfile's path is :%@",myFilename);
    
    // no files generated in correspond directory now
    
    [NSKeyedArchiver archiveRootObject:persistentArray toFile:myFilename];
    // now the myFile.rtf is generated
}

+(NSArray*)ReadDataFromFile:(NSString*)myFilename
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,    NSAllDomainsMask, YES);
    
    int pathLen = [pathArray count];
    
    NSLog(@"path number is :%d",pathLen);
    
    NSString *filePath = nil;
    
    for(int i = 0; i < pathLen; i++)
    {
        filePath = [pathArray objectAtIndex:i];
        NSLog(@"%d path is :%@",i,filePath);
    }
    // unarchive
    myFilename = [filePath stringByAppendingPathComponent:myFilename];
    
        NSArray *unarchiveArray = [NSKeyedUnarchiver unarchiveObjectWithFile:myFilename];
        //NSString *UnstrOne = [unarchiveArray objectAtIndex:0];
        //NSString *UnstrTwo = [unarchiveArray objectAtIndex:1];
        
        //NSLog(@"UnstrOne = %@,UnstrTwo = %@",UnstrOne,UnstrTwo);
    
    return unarchiveArray;
}
@end
