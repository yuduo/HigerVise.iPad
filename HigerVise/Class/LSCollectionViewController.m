//
//  LSCollectionViewController.m
//  Locoso
//
//  Created by yongchang hu on 12-3-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSCollectionViewController.h"
#import "LSCollectPE.h"
#import "RJFileUtils.h"
#import "FileStoreManager.h"
@interface LSCollectionViewController ()

@end

@implementation LSCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"收藏企业";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.morePage = NO;
    [self setNavigationBarButtonItemWithTitleStytlePlain:@"编辑" itemType:LSNavigationbarButtonItem_Right];
}

- (LSListProtocolEngine*)protocolEngine
{
    return [[[LSCollectPE alloc] init] autorelease];
}

- (void)setProtocolEngineParams:(LSListProtocolEngine*)aEngine
{
}

- (void)navigationRightButtonItemClicked:(id)aSender
{
    [self setEditing:!self.editing animated:YES];
}
#pragma mark Editing

// The editing style for a row is the kind of button displayed to the left of the cell when in editing mode.
- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    // No editing style if not editing or the index path is nil.
    if (self.editing == NO || !indexPath) return UITableViewCellEditingStyleNone;
    // Determine the editing style based on whether the cell is a placeholder for adding content or already 
    // existing content. Existing content can be deleted.
    
    NSLog(@"list count = %d",[_listPE.rspData.arrContent count]);
    {
        
        {
            if (indexPath.row >= [_listPE.rspData.arrContent count]) {
                return UITableViewCellEditingStyleInsert;
            } else {
                return UITableViewCellEditingStyleDelete;
            }
        }
    }
    return UITableViewCellEditingStyleNone;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    // Calculate the index paths for all of the placeholder rows based on the number of items in each section.
    
    
    //    NSArray *indexPaths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:[menuList count]-1 inSection:0]];
    
    [_tableView beginUpdates];
    [_tableView setEditing:editing animated:YES];
    if (editing) {
        // Show the placeholder rows
        // [myTableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    } else {
        // Hide the placeholder rows.
        //[myTableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    }
    [_tableView endUpdates];
    
}
// Update the data model according to edit actions delete or insert.
- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //
        [_listPE.rspData.arrContent removeObjectAtIndex: indexPath.row];
        [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        

        NSMutableArray *newArray =  [[NSMutableArray alloc]init];
        for (int i = 0; i < [_listPE.rspData.arrContent count]; i ++) {
            LSDataCompany *temp = [_listPE.rspData.arrContent objectAtIndex:i];
            [newArray addObject:
             [NSMutableDictionary dictionaryWithObjectsAndKeys:
              [NSNumber numberWithInt:temp.companyID], @"companyid",
              temp.companyName!=nil?temp.companyName:[NSNull null], @"companyname",
              temp.address!=nil?temp.address:[NSNull null], @"address",
              temp.logo != nil ? temp.logo:[NSNull null] ,@"logo",
              nil]
             ];
        }
        [self saveCompanyIDArrayDataToFile:newArray name:@"collection"];
        if ([newArray count] == 0) {
            NSString *filename = @"LSCompanyDetailViewControllercollection.rtf";
            [RJFileUtils removeItemAtPathWithinDocumentDir:filename];
        }
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
        
    }
}

-(void)saveCompanyIDArrayDataToFile:(NSArray*)savedata name:(NSString*)sname
{
    NSString* controllerClassName = @"LSCompanyDetailViewController";
    controllerClassName = [controllerClassName stringByAppendingFormat:@"%@",sname];
    controllerClassName = [controllerClassName stringByAppendingString:@".rtf"];
    
    [FileStoreManager SaveDataToFile:savedata fileName:controllerClassName];
}
@end
