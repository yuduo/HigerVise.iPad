//
//  PrintView.h
//  HigerVise
//
//  Created by jije jijesoft on 12-11-12.
//  Copyright (c) 2012年 WuHanNvl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrintView : UIView

@property(nonatomic , weak)IBOutlet UIImageView *bacegroundIV;
@property(nonatomic , weak)IBOutlet UILabel *title1;
@property(nonatomic , weak)IBOutlet UILabel *title2;
@property(nonatomic , weak)IBOutlet UILabel *price;
@property(nonatomic , weak)IBOutlet UITextView *remark;


@property(nonatomic , weak)IBOutlet UIView *view1;
@property(nonatomic , weak)IBOutlet UIImageView *pic;
@property(nonatomic , weak)IBOutlet UILabel *view1_key1;
@property(nonatomic , weak)IBOutlet UILabel *view1_key2;
@property(nonatomic , weak)IBOutlet UILabel *view1_key3;
@property(nonatomic , weak)IBOutlet UILabel *view1_key4;
@property(nonatomic , weak)IBOutlet UILabel *view1_value1;
@property(nonatomic , weak)IBOutlet UILabel *view1_value2;
@property(nonatomic , weak)IBOutlet UILabel *view1_value3;
@property(nonatomic , weak)IBOutlet UILabel *view1_value4;


@property(nonatomic , weak)IBOutlet UIView *view2;
@property(nonatomic , weak)IBOutlet UITextView *view2_info;


@property(nonatomic , weak)IBOutlet UIView *view3;
@property(nonatomic , weak)IBOutlet UITextView *view3_info;


@property(nonatomic , weak)IBOutlet UIView *view4;
@property(nonatomic , weak)IBOutlet UITextView *view4_info;

@end
