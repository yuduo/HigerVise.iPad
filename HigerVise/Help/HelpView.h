//
//  HelpView.h
//  HigerVise
//
//  Created by jije jijesoft on 12-11-20.
//  Copyright (c) 2012年 JijeSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kHelpViewIndexStartIndex 0
#define kHelpViewSearchStartIndex 5
#define kHelpViewPriceTableStartIndex 10
#define kHelpViewPriceTableEditStartIndex 24
#define kHelpViewCarColorStartIndex 35

typedef enum
{
    HelpViewSystemConfigType        = 1000, //帮助类型：总帮助
    HelpViewIndexType               = 1001, //帮助类型：主页帮助
    HelpViewSearchType              = 1002, //帮助类型：搜索帮助
    HelpViewPriceTableType          = 1003, //帮助类型：价格帮助
    HelpViewCarColorType            = 1004, //帮助类型：车型信息帮助
} HelpViewType;

@protocol HelpViewDelegate;

@interface HelpView : UIView<UIScrollViewDelegate> {
    NSMutableArray *_images; //帮助图片数组
    NSMutableArray *_imageViews; //帮助图片控件数组
    UIScrollView *_scvImage; //帮助滚动控件
    UIButton *_btnSkip; //帮助功能返回按钮
}

@property (nonatomic, weak) id <HelpViewDelegate> delegate;
@property (nonatomic) int count; //总图片数量
@property (nonatomic) int index; //目前所浏览的图片号

- (void)loadWithView:(HelpViewType)helpViewType startIndex:(int)startIndex;  //通过类型读取帮助内容并跳到设置的索引
- (void)showWithView; //显示帮助页面
- (void)didReceiveMemoryWarning; //内存警告响应

@end

@protocol HelpViewDelegate <NSObject>
- (void)helpViewIndexChanged:(HelpView *)sender; //帮助索引更改后的反馈
- (void)helpViewRemoveFromSuperView:(HelpView *)sender; //帮助页面被移除后的反馈
@end