//
//  LSBookListViewController.m
//  Locoso
//
//  Created by yongchang hu on 12-3-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LSBookListViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "LSString.h"
#import "UIImageExt.h"

#import "LSCompanyListCell.h"

#pragma mark - LSBookListViewController
@implementation LSBookListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.morePage = YES;
}
- (UIImage*)handleImageHook:(UIImage*)aSrcImage
{
    return [aSrcImage imageByScalingAndCroppingForSize:CGSizeMake(70, 70)];
}

#pragma mark UITableViewDataSource,UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSDataBook* company = [_listPE.rspData.arrContent objectAtIndex:indexPath.row];
    LSCompanyListCell* cell = [LSCompanyListCell companyListCell:tableView];
    [cell setCompanyData:company imageViewController:self];
    return cell;
   /* 
    NSString* reuseID = @"cell";
    UITableViewCell* cell = [_tableView dequeueReusableCellWithIdentifier:reuseID];
    if (nil == cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = LSFontNormal;
        cell.textLabel.textColor = LSCOLOR_BLACK;
        cell.detailTextLabel.font = LSFontSmall;
        cell.detailTextLabel.textColor = LSCOLOR_6A6A6A;
        
        cell.imageView.image = LSImageByName(LSImage_icon_placeholder);
        cell.imageView.clipsToBounds = YES;
        CALayer* layer = cell.imageView.layer;
        layer.cornerRadius = 5.0f;
        layer.borderColor = LSCOLOR_CORNER.CGColor;
        layer.borderWidth = 1;
    }
    
    LSDataBook* company = [_listPE.rspData.arrContent objectAtIndex:indexPath.row];
    cell.textLabel.text = company.bookName;
    cell.detailTextLabel.text = company.address;
    if ([company.logo length] > 0)
    {
        [self addImage:cell.imageView imageURL:[company.logo stringByHandleImageURL]];
    }
    return cell;
    */
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}


@end
