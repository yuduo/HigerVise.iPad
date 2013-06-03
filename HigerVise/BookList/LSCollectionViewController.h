//
//  LSCollectionViewController.h
//  Locoso
//
//  Created by yongchang hu on 12-3-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSBookListViewController.h"
#import "ReadAllBook.h"
@interface LSCollectionViewController : LSBookListViewController<ReadAllBookDelegate>
{
    ReadAllBook *readAllBooks;
    NSMutableArray *controlArray;
    BOOL bLandScape;
}
@end
