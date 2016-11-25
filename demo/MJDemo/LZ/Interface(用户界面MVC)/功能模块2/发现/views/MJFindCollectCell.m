

#import "MJFindCollectCell.h"

@interface MJFindCollectCell ()
@property (nonatomic, strong) UIImageView *productImg;     /**< 品牌图片 */
@property (nonatomic, strong) UIImageView *shadeView;
@property (nonatomic, strong) UILabel *titleLab;      /**<  标题 */
@end

@implementation MJFindCollectCell
#pragma mark ************** 懒加载控件
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
- (UIImageView *)shadeView {
    if (!_shadeView) {
        _shadeView = [[UIImageView alloc] init];
        _shadeView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        
    }
    return _shadeView;
}
- (UIImageView *)productImg {
    if (!_productImg) {
        _productImg = [[UIImageView alloc] init];
        _productImg.image = [UIImage imageNamed:@"logo_del_pro"];
        
    }
    return _productImg;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubviewsForCell];
        
        [self addConstraintsForCell];
    }
    return self;
}

#pragma mark ************** 设置cell 内容
- (void)setModel:(NSDictionary *)model
{
    _model = model;
  
    
    NSDictionary *dic = model[@"data"];

    NSURL *url = [NSURL URLWithString:dic[@"image"]];
        
    [_productImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"logo_del_pro"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
    
     _titleLab.text = dic[@"title"];
    
    if([model[@"type"] isEqualToString:@"rectangleCard"])
    {
       _shadeView.hidden = YES;
    }
    else
    {
       _shadeView.hidden = NO;
    }
    
}


#pragma mark ************** 添加子控件
- (void)addSubviewsForCell
{
    [self.contentView addSubview:self.productImg];
    [self.productImg addSubview:self.shadeView];
    [self.contentView addSubview:self.titleLab];
    
}
#pragma mark **************** 约束
- (void)addConstraintsForCell
{
    [_productImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [_shadeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_productImg);
    }];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.left.equalTo(self.contentView);
        make.height.equalTo(@30);
    }];
}



@end
