

#import "LZHomeFootCollectCell.h"

@interface LZHomeFootCollectCell ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *productImg;     /**< 品牌图片 */
@property (nonatomic, strong) UIImageView *shadeView;
@property (nonatomic, strong) UILabel *titleLab;      /**<  标题 */
@property (nonatomic, strong) UILabel *messageLab;      /**<  附标题 */

@property (nonatomic, strong) UILabel *allLab;      /**<  全部标题 */

@end

@implementation LZHomeFootCollectCell
- (UIImageView *)shadeView {
    if (!_shadeView) {
        _shadeView = [[UIImageView alloc] init];
        _shadeView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        
    }
    return _shadeView;
}
#pragma mark ************** 懒加载控件
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UILabel *)messageLab {
    if (!_messageLab) {
        _messageLab = [[UILabel alloc] init];
        _messageLab.textAlignment = NSTextAlignmentCenter;
        _messageLab.font = systemFont(14);
        _messageLab.text = @"查看详情";
        _messageLab.textColor = [UIColor grayColor];
    }
    return _messageLab;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = boldSystemFont(16);
        _titleLab.text = @"查看详情";
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.backgroundColor = [UIColor clearColor];
    }
    return _titleLab;
}
- (UILabel *)allLab {
    if (!_allLab) {
        _allLab = [[UILabel alloc] init];
        _allLab.textAlignment = NSTextAlignmentCenter;
        _allLab.font = boldSystemFont(16);
        _allLab.text = @"查看详情";
        _allLab.textColor = [UIColor blackColor];
        _allLab.layer.borderWidth = 2;
        _allLab.layer.borderColor = RGB(229, 229, 229).CGColor;
        _allLab.backgroundColor = RGB(248, 248, 248);
    }
    return _allLab;
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

- (void)setModel:(NSDictionary *)model{
    _model = model;
    
    if([model[@"type"] isEqualToString:@"video"])
    {
        NSDictionary *dic = model[@"data"];
        
        NSURL *url = [NSURL URLWithString:dic[@"cover"][@"detail"]];
        
        [_productImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"logo_del_pro"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
        
        
        _titleLab.text = dic[@"title"];
        
        _messageLab.text = [NSString stringWithFormat:@"#%@%@%@",dic[@"category"],@" / ",[self timeStrFormTime:dic[@"duration"]]];
        
        _allLab.hidden = YES;
        
        _bgView.hidden = NO;
    }
    else
    {
        _allLab.text = model[@"data"][@"text"];
        
        _allLab.hidden = NO;
        
        _bgView.hidden = YES;
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
#pragma mark ************** 添加子控件
- (void)addSubviewsForCell
{
    [self.contentView addSubview:self.bgView];
    [self.contentView addSubview:self.allLab];

    [self.bgView addSubview:self.productImg];
    [self.productImg addSubview:self.shadeView];
    [self.bgView addSubview:self.titleLab];
    [self.bgView addSubview:self.messageLab];
    
}
#pragma mark **************** 约束
- (void)addConstraintsForCell
{
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [_allLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-55);
    }];
    
    [_messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_bgView);
        make.left.equalTo(_bgView).offset(5);
        make.right.equalTo(_bgView);
        make.height.equalTo(@25);
    }];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_messageLab);
        make.bottom.equalTo(_messageLab.top);
        make.right.equalTo(_bgView);
        make.height.equalTo(@30);
    }];
    [_productImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(_bgView);
        make.bottom.equalTo(_titleLab.top);
    }];
    [_shadeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_productImg);
    }];
  
   
    
    
}



@end
