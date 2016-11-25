//
//  YZGMineTableHeadView.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "LZMineTableHeadView.h"

@interface LZMineTableHeadView()

@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) UILabel *titleLab;      /**<  标题 */


@end

@implementation LZMineTableHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
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
    }
    return _titleLab;
}
- (UIImageView *)headImg {
    if (!_headImg) {
        _headImg = [[UIImageView alloc] init];
        _headImg.image = [UIImage imageNamed:@"minebg"];
        _headImg.backgroundColor = [UIColor grayColor];
        _headImg.layer.cornerRadius = 40;
        _headImg.layer.masksToBounds = YES;
        _headImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headImgClick:)];
        [_headImg addGestureRecognizer:tap];
        
    }
    return _headImg;
}
-(void)headImgClick:(UITapGestureRecognizer *)sender
{
    if(self.headImgClick)
    {
        self.headImgClick();
    }
}


#pragma mark ************** 设置按钮被点击
- (void)setBtnClick{
    
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    [self addSubview:self.headImg];
    [self addSubview:self.titleLab];
}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-15);
        make.height.width.equalTo(@80);
    }];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_headImg.bottom);
        make.height.equalTo(@30);
        make.left.right.equalTo(self);
    }];
 
}

@end
