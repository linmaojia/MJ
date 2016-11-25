//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "LZFindController.h"
#import "MJFindManager.h"
#import "MJFindCollectCell.h"
#import "MJFindTopCollectCell.h"
@interface LZFindController ()
@property (nonatomic, strong) MJFindManager *manager;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation LZFindController

#pragma mark ************** 懒加载控件
- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
        layout.minimumInteritemSpacing = 5; //列与列之间的间距
        layout.minimumLineSpacing = 5;//行与行之间的间距
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self.manager;
        _collectionView.dataSource = self.manager;
        [_collectionView registerClass:[MJFindTopCollectCell class] forCellWithReuseIdentifier:@"MJFindTopCollectCell"];
        [_collectionView registerClass:[MJFindCollectCell class] forCellWithReuseIdentifier:@"MJFindCollectCell"];//注册cell
    }
    return _collectionView;
}
- (MJFindManager *)manager {
    if (!_manager) {
        _manager = [[MJFindManager alloc]init];
    }
    return _manager;
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
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
    self.title = @"发现";
    self.view.backgroundColor = RGB(235, 235, 241);
    
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ************** 获取数据
- (void)getData
{
    ESWeakSelf;
     [SVProgressHUD show];
    [MJAFNetWorking requestDataByURL:APIFindUrl Parameters:nil success:^(id responseObject) {
        
        [SVProgressHUD dismiss];
        
        NSMutableArray *array = [NSMutableArray arrayWithArray:responseObject[@"itemList"]];
        
        __weakSelf.manager.dataArray = array;//管理者赋值
        
        [__weakSelf.collectionView reloadData];
 
        
    } failBlock:^(NSError *error) {
        [SVProgressHUD dismiss];
        
    }];
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
  [self.view addSubview:self.collectionView];
}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
@end
