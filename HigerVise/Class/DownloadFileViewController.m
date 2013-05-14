//
//  DownloadFileViewController.m
//  HigerManage
//
//  Created by jijesoft on 13-5-13.
//  Copyright (c) 2013年 WuHanNvl. All rights reserved.
//

#import "DownloadFileViewController.h"
#import "DownloadFileManage.h"
#import "EGOImageView.h"
@interface DownloadFileViewController ()

@end

@implementation DownloadFileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSArray *sourceIDArray = [DownloadFileManage getDownloadFileArray];
    downloadedArray = [[NSMutableArray alloc]init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//=======================处理代码==========================

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.

    return [downloadedArray count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"etuancell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (!cell) {
		//cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:identifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        // 取消选择模式
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else{
        // 删除cell中的子对象,刷新覆盖问题。
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    if ([downloadedArray count] > indexPath.row) {
         NSDictionary *dic = [downloadedArray objectAtIndex:indexPath.row];
        if (dic != nil) {
            //
            EGOImageView *imageView = [[EGOImageView alloc]init];
            imageView.imageURL = [dic objectForKey:@"url"];
            [cell.contentView addSubview:imageView];
            cell.textLabel.text = [dic objectForKey:@"title"];
            
        }
    }
    
        
    
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    CGFloat height = 234;
	return 234;
}

@end
