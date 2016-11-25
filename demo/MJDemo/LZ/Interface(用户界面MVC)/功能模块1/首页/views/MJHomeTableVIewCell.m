//
//  YZGMineTableOrderCell.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "MJHomeTableVIewCell.h"

@interface MJHomeTableVIewCell()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *cellImageView;

@property (nonatomic, strong) UIImageView *shadeView;

@property (nonatomic, strong) UILabel *titleLab;      /**<  标题 */

@property (nonatomic, strong) UILabel *messageLab;      /**<  附标题 */

@property (nonatomic, strong) UILabel *headLab;      /**<  头部标题 */

@end
@implementation MJHomeTableVIewCell
#pragma mark ************** 懒加载控件
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
- (UILabel *)headLab {
    if (!_headLab) {
        _headLab = [[UILabel alloc] init];
        _headLab.textAlignment = NSTextAlignmentCenter;
        _headLab.font = [UIFont fontWithName:MyEnFont size:14];;
        _headLab.text = @"查看详情";
        _headLab.backgroundColor = [UIColor whiteColor];
    }
    return _headLab;
}

- (UILabel *)messageLab {
    if (!_messageLab) {
        _messageLab = [[UILabel alloc] init];
        _messageLab.textAlignment = NSTextAlignmentCenter;
        _messageLab.font = systemFont(14);
        _messageLab.text = @"";
        _messageLab.textColor = [UIColor whiteColor];
    }
    return _messageLab;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = boldSystemFont(16);
        _titleLab.text = @"";
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.backgroundColor = [UIColor clearColor];
    }
    return _titleLab;
}
- (UIImageView *)cellImageView {
    if (!_cellImageView) {
        _cellImageView = [[UIImageView alloc] init];
        _cellImageView.image = [UIImage imageNamed:@"logo_del_pro"];
        _cellImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleImgClick:)];
        [_cellImageView addGestureRecognizer:tap];
    }
    return _cellImageView;
}
- (UIImageView *)shadeView {
    if (!_shadeView) {
        _shadeView = [[UIImageView alloc] init];
        _shadeView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];

    }
    return _shadeView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = RGB(237, 237, 237);
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        
        [self addSubviewsForCell];
        
        [self addConstraintsForCell];
        
        
        
    }
    return self;
}
#pragma mark ************** 设置cell 内容
- (void)setModel:(NSDictionary *)model{
    _model = model;
    
    //头部
    if([model[@"type"] isEqualToString:@"textHeader"])
    {
        NSDictionary *dic = model[@"data"];
        
        _headLab.text = dic[@"text"];
     
        _bgView.hidden = YES;
        
        _headLab.hidden = NO;
    }
    else
    {
        NSDictionary *dic = model[@"data"];
        
        NSURL *url = [NSURL URLWithString:dic[@"cover"][@"detail"]];
        
        [_cellImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"logo_del_pro"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
        
        _titleLab.text = dic[@"title"];
        
        _messageLab.text = [NSString stringWithFormat:@"#%@%@%@",dic[@"category"],@" / ",[self timeStrFormTime:dic[@"duration"]]];
        
        _headLab.hidden = YES;
        
        _bgView.hidden = NO;
    }
    

}
#pragma mark ************** 转换时间格式
-(NSString *)timeStrFormTime:(NSString *)timeStr
{
    int time = [timeStr intValue];
    int minutes = time / 60;
    int second = (int)time % 60;
    return [NSString stringWithFormat:@"%02d'%02d\"",minutes,second];
}
#pragma mark ************** 点击图片
-(void)titleImgClick:(UITapGestureRecognizer *)sender
{
    if(self.cellClickBlack)
    {
        self.cellClickBlack((UIImageView *)sender.view);
    }
}
#pragma mark **************** 添加子控件
- (void)addSubviewsForCell
{
    [self.contentView addSubview:self.bgView];
    
    [self.contentView addSubview:self.headLab];

    [self.bgView addSubview:self.cellImageView];
  
    [self.cellImageView addSubview:self.shadeView];

    [self.bgView addSubview:self.titleLab];
    
    [self.bgView addSubview:self.messageLab];

  
    
}
#pragma mark **************** 约束
- (void)addConstraintsForCell
{
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [_headLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(5);
    }];
    
    [_cellImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_bgView);
    }];
    
    [_shadeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_cellImageView);
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bgView).offset(-35/2);
        make.right.left.equalTo(_bgView);
        make.height.equalTo(@30);
    }];
    
    [_messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLab.bottom).offset(10);
        make.right.left.equalTo(_bgView);
        make.height.equalTo(@25);
    }];
    
    
 
}
@end
