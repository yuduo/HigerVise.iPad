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
-(id)init
{
    self = [super init];

    readAllBooks = [[ReadAllBook alloc]init];
    readAllBooks.viewSource = self;
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.title = @"下载内容";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.morePage = NO;
//    [self setNavigationBarButtonItemWithTitleStytlePlain:@"编辑" itemType:LSNavigationbarButtonItem_Right];
    controlArray = [[NSMutableArray alloc]init];
    [self.navigationItem setHidesBackButton:YES animated:NO];
    
}
-(void)addControlToNavi
{
    {
        UIImageView *view = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"my_book_button.png"]];
        view.frame = CGRectMake(((bLandScape == YES ? 1024 : 768)-138)/2, 10, 138, 40);
        view.tag = 1;
        [self.navigationController.navigationBar addSubview:view];
        [controlArray addObject:view];
    }
    
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame = CGRectMake(10, 10, 46, 40);
    btnBack.tag = 3;
    [btnBack setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back" ofType:@"png"]] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:btnBack];
    [controlArray addObject:btnBack];
    
    UIButton *btnHome = [UIButton buttonWithType:UIButtonTypeCustom];
    btnHome.frame = (bLandScape == YES ? CGRectMake(904, 11, 97, 40):CGRectMake(653, 11, 97, 40));
    btnHome.tag = 4;
    [btnHome setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"button_edit" ofType:@"png"]] forState:UIControlStateNormal];
    [btnHome addTarget:self action:@selector(navigationRightButtonItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:btnHome];
    [controlArray addObject:btnHome];
}
-(void)backButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    UIDeviceOrientation interfaceOrientation=[[UIApplication sharedApplication] statusBarOrientation];
    if (interfaceOrientation == UIDeviceOrientationPortrait || interfaceOrientation == UIDeviceOrientationPortraitUpsideDown) {
        //翻转为竖屏时
        bLandScape = NO;
    }else if (interfaceOrientation==UIDeviceOrientationLandscapeLeft || interfaceOrientation == UIDeviceOrientationLandscapeRight) {
        //翻转为横屏时
        bLandScape = YES;
    }
    [self addControlToNavi];
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0,  (bLandScape == YES ? 1024 : 768), 60)];
    _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, (bLandScape == YES ? 1024 : 768), 16)];
    [_tableView setFrame:CGRectMake(0, 0, (bLandScape == YES ? 1024 : 768), (bLandScape == YES ? 768 : 1024))];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    for (int i = 0; i < [controlArray count]; i ++) {
        
        [(UIView*)[controlArray objectAtIndex:i] removeFromSuperview];
    }
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
        //delete file
        {
            LSDataBook *temp = [_listPE.rspData.arrContent objectAtIndex:indexPath.row];
            [self deleteTheLocalFiles:temp.local_resource];
        }
        //
        [_listPE.rspData.arrContent removeObjectAtIndex: indexPath.row];
        [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        

        NSMutableArray *newArray =  [[NSMutableArray alloc]init];
        for (int i = 0; i < [_listPE.rspData.arrContent count]; i ++) {
            LSDataBook *temp = [_listPE.rspData.arrContent objectAtIndex:i];
            [newArray addObject:
             [NSMutableDictionary dictionaryWithObjectsAndKeys:
              [NSNumber numberWithInt:temp.bookID], @"bookID",
              temp.bookName!=nil?temp.bookName:[NSNull null], @"bookName",
              temp.local_resource!=nil?temp.local_resource:[NSNull null], @"local_resource",
              temp.logo != nil ? temp.logo:[NSNull null] ,@"logo",
              nil]
             ];
        }
        [self saveCompanyIDArrayDataToFile:newArray name:@"collection"];
        if ([newArray count] == 0) {
            NSString *filename = @"LSBookDetailViewControllercollection.rtf";
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSDataBook *temp = [_listPE.rspData.arrContent objectAtIndex:indexPath.row];
    if (temp != nil) {
        NSString *filePath = temp.local_resource;
        NSInteger type = temp.bookType;
        
        if (type == RESOURCE_TYPE_IMAGE) {
            
            [self searchDocFindPicture:filePath];
            
        }else
        {
            
            //创建文件管理器
            NSFileManager *fileManager = [NSFileManager defaultManager];
            //判断temp文件夹是否存在
            BOOL fileExists = [fileManager fileExistsAtPath:filePath];
            
            if (!fileExists) {//如果不存在,下载
                return;
            }
            
            
            [readAllBooks readButtonClicked:type path:filePath];
        }
    }
}
-(void)searchDocFindPicture:(NSString*)path
{
    //创建文件管理器
	NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *err;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath: path error: &err];  // path 时绝对路径
    BOOL haveDoc = NO;
    if ([files count]) {
        //have doc
        for (int i = 0; i < [files count]; i ++) {
            NSDictionary *attribs;
            NSString *filepath = [files objectAtIndex:i];
            attribs = [fileManager attributesOfItemAtPath:[path stringByAppendingPathComponent:filepath] error: NULL];
            if ([attribs objectForKey: NSFileType] == NSFileTypeDirectory) {
                [readAllBooks readButtonClicked:RESOURCE_TYPE_IMAGE path:[path stringByAppendingPathComponent:filepath]];
                haveDoc = YES;
                break;
            }
        }
    }
    if (!haveDoc) {
        [readAllBooks readButtonClicked:RESOURCE_TYPE_IMAGE path:path];
    }
}
-(UIViewController*)getCurrentViewController
{
    return self;
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
	if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
	   interfaceOrientation == UIInterfaceOrientationLandscapeRight)
	{
		bLandScape = YES;
        
	}else {
		bLandScape = NO;
        
	}
	[self.navigationController.navigationBar setFrame:CGRectMake(0, 0, (bLandScape == YES ? 1024 : 768), 60)];
    [self resetControlPosition];
}
-(void)resetControlPosition
{
    
    
    for (int i = 0; i < [controlArray count]; i ++) {
        UIView *view = [controlArray objectAtIndex:i];
        int tag = view.tag;
        switch (tag) {
            case 1:
                [view setFrame:bLandScape == YES ? CGRectMake((1024-138)/2, 10, 138, 40):CGRectMake((768-138)/2, 10, 138, 40)];
                break;
            case 2:
                
                break;
            case 3:
                [view setFrame:bLandScape == YES ? CGRectMake(10, 10, 46, 40):CGRectMake(10, 10, 46, 40)];
                break;
            case 4:
                [view setFrame:bLandScape == YES ? CGRectMake(904, 11, 97, 40):CGRectMake(653, 11, 97, 40)];
                break;
            default:
                break;
        }
    }
}
-(void)deleteTheLocalFiles:(NSString*)filePath
{
    NSError *error = nil;
    NSFileManager* manager = [[NSFileManager alloc] init];
    if ([manager fileExistsAtPath:filePath]) {
        [manager removeItemAtPath:filePath error:&error];
    }
}
@end
