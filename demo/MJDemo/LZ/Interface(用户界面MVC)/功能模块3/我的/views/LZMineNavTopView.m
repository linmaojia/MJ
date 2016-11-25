//
//  YZGMineTableHeadView.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "LZMineNavTopView.h"

@interface LZMineNavTopView()

@property (nonatomic, strong) UIImageView *bgImgView;
@property (nonatomic, strong) UIVisualEffectView * effectView;

@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) UILabel *titleLab;      /**<  标题 */
@end

@implementation LZMineNavTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
         self.alpha = 0.0;
        [self addSubviewsForView];
        [self addConstraintsForView];
    }
    return self;
}
#pragma mark ************** 懒加载控件
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = systemFont(16);
        _titleLab.text = @"月前龙马";
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.backgroundColor = [UIColor clearColor];
        _titleLab.alpha = 0.0;
    }
    return _titleLab;
}
- (UIImageView *)headImg {
    if (!_headImg) {
        _headImg = [[UIImageView alloc] init];
        _headImg.image = [UIImage imageNamed:@"minebg"];
        _headImg.backgroundColor = [UIColor grayColor];
        _headImg.userInteractionEnabled = YES;
        _headImg.layer.cornerRadius = 15;
        _headImg.layer.masksToBounds = YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headImgClick:)];
        [_headImg addGestureRecognizer:tap];
        _headImg.alpha = 0.0;
        
    }
    return _headImg;
}
-(void)headImgClick:(UITapGestureRecognizer *)sender
{
    
}
- (UIVisualEffectView *)effectView {
    /**  毛玻璃特效类型
     *   UIBlurEffectStyleExtraLight,
     *   UIBlurEffectStyleLight,
     *   UIBlurEffectStyleDark
     */
    if (!_effectView) {
        
        UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        _effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];//  毛玻璃视图
        _effectView.alpha = 0.7f;//设置模糊透明度
    }
    return _effectView;
}
- (UIImageView *)bgImgView {
    
    if (!_bgImgView) {
        _bgImgView = [[UIImageView alloc] init];
        _bgImgView.image = [UIImage imageNamed:@"minex"];
        [_bgImgView setContentMode:UIViewContentModeScaleAspectFill]; //去图片中间部分，图片太大的情况
        _bgImgView.clipsToBounds=YES;
    }
    return _bgImgView;
}

- (void)setIsShowTitle:(BOOL)isShowTitle
{

    if(isShowTitle)
    {
        [UIView animateWithDuration:0.5 animations:^{
            _titleLab.alpha = 1;
            _headImg.alpha = 1;
        }];
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            _titleLab.alpha = 0;
            _headImg.alpha = 0;
        }];

    }
   
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    
    [self addSubview:self.bgImgView];
    
    [self.bgImgView addSubview:self.effectView];
 
    [self addSubview:self.headImg];
    
    [self addSubview:self.titleLab];
   
}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    [_bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [_effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_bgImgView);
    }];
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self).offset(10);
        make.height.width.equalTo(@30);
    }];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.left.right.bottom.equalTo(self);
    }];
}

@end
