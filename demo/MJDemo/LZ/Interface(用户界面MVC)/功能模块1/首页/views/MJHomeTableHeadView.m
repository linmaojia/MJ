//
//  YZGMineTableHeadView.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "MJHomeTableHeadView.h"
#import "HYBLoopScrollView.h"

@interface MJHomeTableHeadView()
/**< 广告轮播图 */
@property (nonatomic, weak) HYBLoopScrollView *loop;
/*url 数组*/
@property (nonatomic, strong) NSMutableArray *urlArray;

@end

@implementation MJHomeTableHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _urlArray = [NSMutableArray array];
        [_urlArray addObject:@"http://cache.fotoplace.cc/161109/admin/F425DF7F289F2EB710FBD754B91C4E57.jpeg"];
        [_urlArray addObject:@"http://cache.fotoplace.cc/161028/admin/AD0C24676952B888443B5C7352BACA47.jpg"];
        [_urlArray addObject:@"http://cache.fotoplace.cc/161110/admin/C65CCF888299214D0C657401453C20EC.jpg"];
        [_urlArray addObject:@"http://cache.fotoplace.cc/161102/admin/3077E4EB4F22088AC5D984D7FC99C68B.jpg"];
        [_urlArray addObject:@"http://dn.fotoplace.cc/5c525985693e4145947b751303223151.jpg-mb"];


        [self addSubviewsForView];
        [self addConstraintsForView];
        
    }
    return self;
}
#pragma mark ************** 懒加载控件

- (HYBLoopScrollView *)loop
{
    if(!_loop)
    {
        _loop = [HYBLoopScrollView loopScrollViewWithFrame:CGRectZero imageUrls:_urlArray timeInterval:5 didSelect:^(NSInteger atIndex) {
            
            NSLog(@"---%ld",atIndex);
            
        } didScroll:^(NSInteger toIndex) {
            
            NSLog(@"--xxxx-%ld",toIndex);//切换页面时调用
        }];
        
        _loop.placeholder = [UIImage imageNamed:@"logo_del_pro"];
        
        _loop.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"logo_del_pro"]];
        
        _loop.alignment = kPageControlAlignCenter;
        
        _loop.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        
        _loop.imageContentMode = UIViewContentModeScaleAspectFill;
        
        
    }
    return _loop;
}



#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    
    [self addSubview:self.loop];
    
}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    
    [_loop makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self);
        make.bottom.equalTo(self).offset(-5);
    }];
}

@end
