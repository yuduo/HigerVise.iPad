#define  RefreshViewHight 65.0f

#import "EGORefreshTableFooterView.h"


#define TEXT_COLOR     [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
#define FLIP_ANIMATION_DURATION 0.18f


@interface EGORefreshTableFooterView (Private)
- (void)setState:(EGOPullRefreshState)aState;
@end

@implementation EGORefreshTableFooterView

@synthesize delegate=_delegate;


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, RefreshViewHight - 30.0f, self.frame.size.width, 20.0f)];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        label.font = [UIFont systemFontOfSize:12.0f];
        label.textColor = TEXT_COLOR;
        label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
        label.shadowOffset = CGSizeMake(0.0f, 1.0f);
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        [self addSubview:label];
        _lastUpdatedLabel=label;
        [label release];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, RefreshViewHight - 48.0f, self.frame.size.width, 20.0f)];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        label.font = [UIFont boldSystemFontOfSize:13.0f];
        label.textColor = TEXT_COLOR;
        label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
        label.shadowOffset = CGSizeMake(0.0f, 1.0f);
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        [self addSubview:label];
        _statusLabel=label;
        [label release];
        
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(25.0f, RefreshViewHight - RefreshViewHight, 30.0f, 55.0f);
        layer.contentsGravity = kCAGravityResizeAspect;
        layer.contents = (id)[UIImage imageNamed:@"blueArrow.png"].CGImage;
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
            layer.contentsScale = [[UIScreen mainScreen] scale];
        }
#endif
        
        [[self layer] addSublayer:layer];
        _arrowImage=layer;
        
        UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        view.frame = CGRectMake(25.0f, RefreshViewHight - 38.0f, 20.0f, 20.0f);
        [self addSubview:view];
        _activityView = view;
        [view release];
        
        
        [self setState:EGOOPullRefreshNormal];
        
    }
    
    return self;
    
}

#pragma mark -
#pragma mark Setters

- (void)refreshLastUpdatedDate {
    
    if ([_delegate respondsToSelector:@selector(egoRefreshTableFooterDataSourceLastUpdated:)]) {
        
        NSDate *date = [_delegate egoRefreshTableFooterDataSourceLastUpdated:self];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setAMSymbol:@"上午"];
        [formatter setPMSymbol:@"下午"];
        [formatter setDateFormat:@"yyyy/MM/dd hh:mm:ss"];
        _lastUpdatedLabel.text = [NSString stringWithFormat:@"最后加载: %@", [formatter stringFromDate:date]];
        
        [[NSUserDefaults standardUserDefaults] setObject:_lastUpdatedLabel.text forKey:@"EGORefreshTableView_LastRefresh"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [formatter release];
        
    } else {
        
        _lastUpdatedLabel.text = nil;
        
    }
    
}

- (void)setState:(EGOPullRefreshState)aState{
    
    switch (aState) {
        case EGOOPullRefreshPulling:
            
            _statusLabel.text = NSLocalizedString(@"松开即可加载...", @"松开即可加载...");
            [CATransaction begin];
            [CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
            _arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
            [CATransaction commit];
            
            break;
        case EGOOPullRefreshNormal:
            
            if (_state == EGOOPullRefreshPulling) {
                [CATransaction begin];
                [CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
                _arrowImage.transform = CATransform3DIdentity;
                [CATransaction commit];
            }
            
            _statusLabel.text = NSLocalizedString(@"上拉加载更多...", @"上拉加载更多...");
            [_activityView stopAnimating];
            [CATransaction begin];
            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
            _arrowImage.hidden = NO;
            _arrowImage.transform = CATransform3DIdentity;
            [CATransaction commit];
            
            [self refreshLastUpdatedDate];
            
            break;
        case EGOOPullRefreshLoading:
            
            _statusLabel.text = NSLocalizedString(@"加载中...", @"加载中...");
            [_activityView startAnimating];
            [CATransaction begin];
            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
            _arrowImage.hidden = YES;
            [CATransaction commit];
            
            break;
        default:
            break;
    }
    
    _state = aState;
}


#pragma mark -
#pragma mark ScrollView Methods

//手指屏幕上不断拖动调用此方法
- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView {    
    
    if (_state == EGOOPullRefreshLoading) {
        
        CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
        offset = MIN(offset, 60);
        scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0f, RefreshViewHight, 0.0f);
        
    } else if (scrollView.isDragging) {
        
        BOOL _loading = NO;
        if ([_delegate respondsToSelector:@selector(egoRefreshTableFooterDataSourceIsLoading:)]) {
            _loading = [_delegate egoRefreshTableFooterDataSourceIsLoading:self];
        }
//        NSLog(@"%.2f",scrollView.contentOffset.y + (scrollView.frame.size.height));
        if (scrollView.frame.size.height > scrollView.contentSize.height) {
            if (_state == EGOOPullRefreshPulling && scrollView.contentOffset.y < RefreshViewHight && scrollView.contentOffset.y > 0.0f && !_loading) {
                [self setState:EGOOPullRefreshNormal];
            } else if (_state == EGOOPullRefreshNormal && scrollView.contentOffset.y > RefreshViewHight  && !_loading) {
                [self setState:EGOOPullRefreshPulling];
            }
        }else{
            if (_state == EGOOPullRefreshPulling && scrollView.contentOffset.y + (scrollView.frame.size.height) < scrollView.contentSize.height + RefreshViewHight && scrollView.contentOffset.y > 0.0f && !_loading) {
                [self setState:EGOOPullRefreshNormal];
            } else if (_state == EGOOPullRefreshNormal && scrollView.contentOffset.y + (scrollView.frame.size.height) > scrollView.contentSize.height + RefreshViewHight  && !_loading) {
                [self setState:EGOOPullRefreshPulling];
            }
        }
        
        if (scrollView.contentInset.bottom != 0) {
            scrollView.contentInset = UIEdgeInsetsZero;
        }
        
    }
    
}

//当用户停止拖动，并且手指从屏幕中拿开的的时候调用此方法
- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
    
    BOOL _loading = NO;
    if ([_delegate respondsToSelector:@selector(egoRefreshTableFooterDataSourceIsLoading:)]) {
        _loading = [_delegate egoRefreshTableFooterDataSourceIsLoading:self];
    }
//    NSLog(@"%.2f",scrollView.contentSize.height + RefreshViewHight);
    float y1 = scrollView.contentOffset.y + (scrollView.frame.size.height);
    float y2 = scrollView.contentSize.height + RefreshViewHight;
    if (scrollView.frame.size.height > scrollView.contentSize.height) {
        y1 = scrollView.contentOffset.y;
        y2 = RefreshViewHight;
    }
    if (y1 > y2 && !_loading) {
        
        if ([_delegate respondsToSelector:@selector(egoRefreshTableFooterDidTriggerRefresh:)]) {
            [_delegate egoRefreshTableFooterDidTriggerRefresh:self];
        }
        
        [self setState:EGOOPullRefreshLoading];
       
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        if (scrollView.frame.size.height > scrollView.contentSize.height) {
            self.frame = CGRectMake(0, scrollView.frame.size.height - RefreshViewHight, scrollView.frame.size.width, scrollView.bounds.size.height);
        }
        scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, RefreshViewHight , 0.0f);
        [UIView commitAnimations];
        
    }
    
}

//当开发者页面页面刷新完毕调用此方法，[delegate egoRefreshScrollViewDataSourceDidFinishedLoading: scrollView];
- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.3];
    [scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
    if (scrollView.contentSize.height <= scrollView.frame.size.height) {
        self.frame = CGRectMake(0, scrollView.frame.size.height, scrollView.frame.size.width, scrollView.bounds.size.height);
    }else{
        self.frame = CGRectMake(0.0f, scrollView.contentSize.height, scrollView.frame.size.width, scrollView.bounds.size.height);
    }
    [UIView commitAnimations];
    
    [self setState:EGOOPullRefreshNormal];
    
}

#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
    
    _delegate=nil;
    _activityView = nil;
    _statusLabel = nil;
    _arrowImage = nil;
    _lastUpdatedLabel = nil;
    [super dealloc];
}


@end