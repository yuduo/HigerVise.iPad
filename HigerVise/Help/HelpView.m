//
//  HelpView.m
//  HigerVise
//
//  Created by jije jijesoft on 12-11-20.
//  Copyright (c) 2012年 JijeSoft. All rights reserved.
//

#import "HelpView.h"

@implementation HelpView
@synthesize delegate;
@synthesize count;
@synthesize index;

- (void)dealloc
{
    if (_images) {
        [_images removeAllObjects];
        _images = nil;
    }
    
    if (_imageViews) {
        for (int i = [_imageViews count] - 1 ; i >= 0 ; i--) {
            UIImageView *imageView = [_imageViews objectAtIndex:i];
            [_imageViews removeObject:imageView];
            [imageView removeFromSuperview];
            imageView = nil;
        }
        [_imageViews removeAllObjects];
        _imageViews = nil;
    }

    _scvImage.delegate = nil;
    [_scvImage removeFromSuperview];
    _scvImage = nil;
    
    [_btnSkip removeFromSuperview];
    _btnSkip = nil;
    
    self.delegate = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)didReceiveMemoryWarning
{
    if (_imageViews) {
        for (int i = [_imageViews count] - 1 ; i >= 0 ; i--) {
            UIImageView *imageView = [_imageViews objectAtIndex:i];
            [_imageViews removeObject:imageView];
            [imageView removeFromSuperview];
            imageView = nil;
        }
        [_imageViews removeAllObjects];
        _imageViews = nil;
    }
    
    _imageViews = [[NSMutableArray alloc] init];
    [self showWithIndex:index];
}

- (void)loadWithView:(HelpViewType)helpViewType startIndex:(int)startIndex
{
    //设置私有存储变量集合
    _images = [[NSMutableArray alloc] init];
    _imageViews = [[NSMutableArray alloc] init];
    
    //设置滚动控件
    _scvImage = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _scvImage.delegate = self;
    _scvImage.pagingEnabled = YES;
    [self addSubview:_scvImage];
    
    //设置跳过按钮
    _btnSkip = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 104, 60)];
    [_btnSkip setBackgroundColor:[UIColor clearColor]];
    [_btnSkip setTitle:@"skip" forState:UIControlStateNormal];
    [_btnSkip setImage:[UIImage imageNamed:@"help-btn-skip.png"] forState:UIControlStateNormal];
    [_btnSkip addTarget:self action:@selector(btnSkip_TouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btnSkip];
    
    //设置页面视图属性
    self.alpha = 0;
    self.backgroundColor = [UIColor blackColor];
    
    //设置图片路径
    switch (helpViewType) {
        case HelpViewIndexType: //如果是主页帮助
            [self addImagesForIndex];//设置主页帮助图片
            break;
        case HelpViewSearchType: //如果是查询帮助
            [self addImagesForSearch];//设置查询帮助图片
            break;
        case HelpViewPriceTableType: //如果是价格表帮助
            [self addImagesForPriceTable];//设置价格表帮助图片
            break;
        case HelpViewCarColorType: //如果是车型查看帮助
            [self addImagesForCarColor];//设置车型查看帮助
            break;
        case HelpViewSystemConfigType: //如果是全部帮助
            [self addImagesForSystemConfig];//设置全部帮助图片
            break;
        default:
            break;
    }
    
    //设置属性参数    
    self.index = startIndex;
    self.count = _images.count;
    
    //设置滚动控件内容长度以及起始位置
    _scvImage.contentSize = CGSizeMake(_scvImage.frame.size.width * _images.count , self.frame.size.height);
    _scvImage.contentOffset = CGPointMake(_scvImage.frame.size.width * startIndex, 0);
    
    //设置图片控件
    [self showWithIndex:index];
}

- (void)showWithView
{
    //帮助页面消失动画
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)showWithIndex:(int)show_index
{
    //设置图片前后索引
    int pre_index = show_index - 1;
    int last_index = show_index + 1;
    
    //判断索引越界
    if (pre_index >= 0) {
        [self addWithIndex:pre_index]; //加载前面一张图片
    }
    //判断索引越界
    if (last_index < count ) {
        [self addWithIndex:last_index]; //加载后面一张图片
    }
    //判断本索引越界
    if (show_index >= 0 && show_index < count) {
        [self addWithIndex:show_index]; //加载图片
    }
}

- (void)addWithIndex:(int)add_index
{
    //判断图片是否存在
    for (UIImageView *imageView in _imageViews) {
        if (imageView && imageView.tag == add_index) {
            return;
        }
    }
    
    //图片不存在 则实例化新的对象
    NSString *path = [_images objectAtIndex:add_index];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:path]];
    imageView.frame = CGRectMake(self.frame.size.width * add_index, 0, _scvImage.frame.size.width, _scvImage.frame.size.height);//设置图片坐标
    imageView.tag = add_index;//设置tag
    imageView.contentMode = UIViewContentModeScaleAspectFit;//设置图片填充
    [_scvImage addSubview:imageView];
    [_imageViews addObject:imageView];
}

//动态释放图片
- (void)hideWithIndex:(int)hide_index
{
    //设置图片前后索引
    int pre_index = hide_index - 1;
    int last_index = hide_index + 1;
    
    //判断索引越界
    if (pre_index >= 0 && pre_index != index) {
        [self removeWithIndex:pre_index];//释放图片
    }
    //判断索引越界
    if (last_index < count && last_index != index) {
        [self removeWithIndex:last_index];//释放图片
    }
    //if (hide_index >= 0 && hide_index < count && hide_index != index) {
    //    [self removeWithIndex:hide_index];
    //}
}

//释放图片功能
- (void)removeWithIndex:(int)remove_index
{
    //如果控件数组存在则进行操作
    if (_imageViews) {
        for (int i = [_imageViews count] - 1 ; i >= 0 ; i--) {
            UIImageView *imageView = [_imageViews objectAtIndex:i];//提取对象
            if (imageView.tag == remove_index) {//判断是否需要删除
                [_imageViews removeObject:imageView];//从数组中删除对象
                [imageView removeFromSuperview];//从视图中删除控件
                imageView = nil;//释放对象
                break;
            }
        }
    }
}

- (void)btnSkip_TouchUpInside:(id)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if ([delegate respondsToSelector:@selector(helpViewRemoveFromSuperView:)]) {
            [delegate performSelector:@selector(helpViewRemoveFromSuperView:) withObject:self];
        }
    }];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int new_index = scrollView.bounds.origin.x / scrollView.frame.size.width;
    if (new_index != index) {
        int old_index = index;
        index = new_index;
        [self hideWithIndex:old_index];//隐藏其他图片（移除）
        [self showWithIndex:new_index];//添加当前图片
        if ([delegate respondsToSelector:@selector(helpViewIndexChanged:)]) {
            [delegate performSelector:@selector(helpViewIndexChanged:) withObject:self];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

}

#pragma mark - init images
//添加全部帮助图片
- (void)addImagesForSystemConfig
{
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-index-1" ofType:@"png"]];//0
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-index-2" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-index-3" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-index-4" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-index-5" ofType:@"png"]];
    
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-search-1" ofType:@"png"]];//5
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-search-2" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-search-3" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-search-4" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-search-5" ofType:@"png"]];
    
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-1" ofType:@"png"]];//10
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-2" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-3" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-4" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-5" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-6" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-7" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-8" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-9" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-10" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-11" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-12" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-13" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-14" ofType:@"png"]];
    
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-15" ofType:@"png"]];//24
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-16" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-17" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-18" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-19" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-20" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-21" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-22" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-23" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-24" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-25" ofType:@"png"]];
    
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-carcolor-1" ofType:@"png"]];//35
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-carcolor-2" ofType:@"png"]];
}
//添加主页帮助图片
- (void)addImagesForIndex
{
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-index-1" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-index-2" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-index-3" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-index-4" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-index-5" ofType:@"png"]];
    //[_images addObject:[[NSBundle mainBundle] pathForResource:@"help-index-6" ofType:@"png"]];
    //[_images addObject:[[NSBundle mainBundle] pathForResource:@"help-index-7" ofType:@"png"]];
}
//添加搜索帮助图片
- (void)addImagesForSearch
{
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-search-1" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-search-2" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-search-3" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-search-4" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-search-5" ofType:@"png"]];
}
//添加价格表帮助图片
- (void)addImagesForPriceTable
{
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-1" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-2" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-3" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-4" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-5" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-6" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-7" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-8" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-9" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-10" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-11" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-12" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-13" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-14" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-15" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-16" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-17" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-18" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-19" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-20" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-21" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-22" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-23" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-24" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-pricetable-25" ofType:@"png"]];
}
//添加车型查看帮助图片
- (void)addImagesForCarColor
{
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-carcolor-1" ofType:@"png"]];
    [_images addObject:[[NSBundle mainBundle] pathForResource:@"help-carcolor-2" ofType:@"png"]];
}

@end
