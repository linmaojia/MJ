

#import "MJFindTopCollectCell.h"
#import "HYBLoopScrollView.h"


@interface MJFindTopCollectCell ()
/**< 广告轮播图 */
@property (nonatomic, weak) HYBLoopScrollView *loop;
/*url 数组*/
@property (nonatomic, strong) NSMutableArray *urlArray;
@end

@implementation MJFindTopCollectCell
#pragma mark ************** 懒加载控件

- (HYBLoopScrollView *)loop
{
    if(!_loop)
    {
        _loop = [HYBLoopScrollView loopScrollViewWithFrame:CGRectZero imageUrls:_urlArray timeInterval:5 didSelect:^(NSInteger atIndex) {
            
            
        } didScroll:^(NSInteger toIndex) {
            
        }];
        
        _loop.placeholder = [UIImage imageNamed:@"logo_del_pro"];
        
        _loop.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"logo_del_pro"]];
        
        _loop.alignment = kPageControlAlignCenter;
        
        _loop.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        
        _loop.imageContentMode = UIViewContentModeScaleAspectFill;
        
    }
    return _loop;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _urlArray = [NSMutableArray array];
        
        [self addSubviewsForCell];
        
        [self addConstraintsForCell];
    }
    return self;
}

#pragma mark ************** 设置cell 内容
- (void)setModel:(NSDictionary *)model
{
    _model = model;
    
    NSArray *array = model[@"data"][@"itemList"];
    for(NSDictionary *dic in array)
    {
         NSString *url = dic[@"data"][@"image"];
        [_urlArray addObject:url];
    }

    _loop.imageUrls = _urlArray;
}

#pragma mark ************** 添加子控件
- (void)addSubviewsForCell
{
    [self.contentView addSubview:self.loop];
  
}
#pragma mark **************** 约束
- (void)addConstraintsForCell
{
    [_loop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
   
}



@end
