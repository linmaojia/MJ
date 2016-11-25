//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "LZMineController.h"
#import "LZMineManager.h"
#import "LZMineTableHeadView.h"
#import "LZMineNavTopView.h"
#import "JWMenuView.h"
static float const TABLeHEAD_H = 250;
static float const NAVBAR_H = 64;

@interface LZMineController ()
@property (nonatomic, strong) LZMineManager *manager;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LZMineTableHeadView *tableHeadView;
@property (nonatomic, strong) LZMineNavTopView *navTopView;
@property (nonatomic, strong) UIButton *setBtn;
@property (nonatomic, strong) UIImageView *personBgImg;    /**< 个人背景图 */
@property (nonatomic, assign) CGFloat offsetY;

@end

@implementation LZMineController

#pragma mark ************** 懒加载控件
- (UIImageView *)personBgImg {
    
    if (!_personBgImg) {
        _personBgImg = [[UIImageView alloc] init];
        _personBgImg.image = [UIImage imageNamed:@"minex"];
        // 填充整个ImageView的，可能只有部分图片显示出来(中间部分)
        _personBgImg.contentMode = UIViewContentModeScaleAspectFill;
        _personBgImg.clipsToBounds=YES;
        _personBgImg.userInteractionEnabled = YES;
        
    }
    return _personBgImg;
}
- (UIButton *)setBtn {
    if (!_setBtn) {
        _setBtn = [[UIButton alloc]init];
        [_setBtn setImage:[UIImage imageNamed:@"nav_set_white"] forState:UIControlStateNormal];
        [_setBtn addTarget:self action:@selector(setBtnClick) forControlEvents:UIControlEventTouchDown];
        
    }
    return _setBtn;
}
- (void)setBtnClick
{
    ESWeakSelf
    [JWMenuView showWithImageArray:@[@"menu_icon_chat",@"menu_icon_phone",@"menu_icon_folder",@"menu_icon_scan"] titleArray:@[@"多人聊天",@"语音电话",@"传文件",@"退出登录"] itemAction:^(NSString *title) {
        
        [__weakSelf menuClickAcionWithTitle:title];
       
    }];
}
- (void)menuClickAcionWithTitle:(NSString *)title
{
    if([title isEqualToString:@"退出登录"])
    {
        [LZUserManager outLoginState];
    }
   
}
- (LZMineNavTopView *)navTopView {
    if (!_navTopView) {
        _navTopView = [[LZMineNavTopView alloc]init];
        _navTopView.backgroundColor = [UIColor clearColor];
        
    }
    return _navTopView;
}
- (LZMineTableHeadView *)tableHeadView {
    if (!_tableHeadView) {
        ESWeakSelf;
        _tableHeadView = [[LZMineTableHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TABLeHEAD_H)];
        _tableHeadView.backgroundColor = [UIColor clearColor];
        _tableHeadView.headImgClick = ^(){
        };
        
    }
    return _tableHeadView;
}
- (UITableView *)tableView
{
    if (!_tableView)
    {
        ESWeakSelf;
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _tableView.delegate = self.manager;
        _tableView.dataSource = self.manager;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        
        _tableView.tableHeaderView = self.tableHeadView;
        
    }
    return _tableView;
}
- (LZMineManager *)manager {
    if (!_manager) {
        ESWeakSelf;
        _manager = [[LZMineManager alloc]init];
        _manager.offsetYBlack = ^(CGFloat offsetY){
            __weakSelf.offsetY = offsetY;
        };
        
    }
    return _manager;
}
- (void)setOffsetY:(CGFloat)offsetY
{
    //个人背景
    CGFloat height = TABLeHEAD_H - offsetY;
    if (height < TABLeHEAD_H)
    {
        height = TABLeHEAD_H;
    }
    
    [_personBgImg mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height));
    }];
    
    //顶部导航栏
    CGFloat scroll_y = TABLeHEAD_H - NAVBAR_H;
    if(offsetY >= scroll_y)
    {
        _navTopView.alpha = 1.0;
        _navTopView.isShowTitle = YES;
    }
    else
    {
        _navTopView.alpha = offsetY/scroll_y;
        _navTopView.isShowTitle = NO;
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];//设置导航栏
    
    [self addSubviewsForView];
    
    [self addConstraintsForView];
    
    [self getData];
}
#pragma mark ************** 设置导航栏
- (void)setNav
{
    self.view.backgroundColor = RGB(235, 235, 241);
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ************** 获取数据
- (void)getData
{
    [_tableView reloadData];
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    [self.view addSubview:self.personBgImg];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.navTopView];
    [self.view addSubview:self.setBtn];
}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    [_personBgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@(TABLeHEAD_H));
    }];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_navTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.view);
        make.height.equalTo(@(NAVBAR_H));
    }];
    
    [_setBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset((44-30)/2+20);
        make.right.equalTo(self.view).offset(-5);
        make.height.width.equalTo(@30);
    }];
}
@end
