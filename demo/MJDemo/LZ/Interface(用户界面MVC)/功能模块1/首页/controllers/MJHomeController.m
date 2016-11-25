//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "MJHomeController.h"
#import "MJHomeManager.h"
#import "MJHomeTableVIewCell.h"
#import "MJHomeTableSectionFootView.h"
#import "MJHomeTableHeadView.h"
#import "MJPhotoSaveView.h"
#import <Photos/Photos.h>
#import "LZLocalData.h"
@interface MJHomeController ()

@property (nonatomic, strong) MJHomeManager *manager;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) MJHomeTableHeadView *tableHeadView;
@property (nonatomic, strong) NSString *nextPageUrl;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL isFirst;//是否第一次请求


@end

@implementation MJHomeController

#pragma mark ************** 懒加载控件
- (MJHomeTableHeadView *)tableHeadView {
    if (!_tableHeadView) {
        _tableHeadView = [[MJHomeTableHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        
    }
    return _tableHeadView;
}
- (UITableView *)tableView
{
    if (!_tableView)
    {
        ESWeakSelf;
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
       
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [__weakSelf getData];
        }];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            __weakSelf.isFirst = NO;
            
             [__weakSelf getData];
        }];
        _tableView.mj_footer.hidden = YES;
        _tableView.delegate = self.manager;
        _tableView.dataSource = self.manager;
        [_tableView registerClass:[MJHomeTableVIewCell class] forCellReuseIdentifier:@"MJHomeTableVIewCell"];
        [_tableView registerClass:[MJHomeTableSectionFootView class] forHeaderFooterViewReuseIdentifier:@"MJHomeTableSectionFootView"];

        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor colorWithHexColorString:@"f9f9f9"];
        
        _tableView.tableHeaderView = self.tableHeadView;

    }
    return _tableView;
}
- (MJHomeManager *)manager {
    if (!_manager) {
        ESWeakSelf;
        _manager = [[MJHomeManager alloc]init];
        _manager.cellClickBlack = ^(UIImageView *moveView){
            
            [MJPhotoSaveView showPhotoViewWithImageView:moveView TitleBtnBlock:^{
                [__weakSelf loadImageFinished:moveView.image];
            }];
        };
    }
    return _manager;
}
#pragma mark ************** 保存图片到相册
- (void)loadImageFinished:(UIImage *)image
{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        //写入图片到相册
        PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
        NSLog(@"success = %d, error = %@", success, error);
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];//设置导航栏
    
    [self addSubviewsForView];
    
    [self addConstraintsForView];
 
    [self.tableView.mj_header beginRefreshing];
   
}
#pragma mark ************** 设置导航栏
- (void)setNav
{
    self.title = @"首页";
    self.view.backgroundColor = RGB(235, 235, 241);
    self.nextPageUrl = @"http://baobab.kaiyanapp.com/api/v3/tabs/selected?pagination=1&needFilter=true&date=1479301200000";
    //接收双击刷新通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginRefreshing:) name:HomeRefreshingNotification object:nil];
}

#pragma mark ************** 获取数据
- (void)getData
{
    ESWeakSelf;
    NSString * url;
    if(!self.isFirst)
    {
       [SVProgressHUD show];
        
        url = APIHomeTop;
 
         self.isFirst = YES;
        
       [self.dataArray removeAllObjects];
        
    }
    else
    {
        url = [self.nextPageUrl stringByAppendingString:APIUrlStr];
    }
    
    NSLog(@"---%@",url);
    
    [MJAFNetWorking requestDataByURL:url Parameters:nil success:^(id responseObject) {
        
        
        
        [SVProgressHUD dismiss];
        
        __weakSelf.tableView.mj_footer.hidden = NO;
        
         [__weakSelf.tableView.mj_header endRefreshing];
        
         [__weakSelf.tableView.mj_footer endRefreshing];
        
         NSDictionary *dic = (NSDictionary *)responseObject;
        
        if([self.manager isNullString:dic[@"nextPageUrl"]])
        {
            [__weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];//设置没有更多数据
        }
        else
        {
            self.nextPageUrl = dic[@"nextPageUrl"];
        }
        
          [__weakSelf addDataDictionary:dic];//数据处理
        
    } failBlock:^(NSError *error) {
        
         [__weakSelf.tableView.mj_footer endRefreshing];
         [__weakSelf.tableView.mj_header endRefreshing];
        
        [SVProgressHUD showErrorWithStatus:@"哎呦，你的网络有问题"];
        
        if(error.code == -1009)
        {
            
           if([url isEqualToString:APIHomeTop])
           {
               LZLocalData *ddxxxada = [LZPublicManager accessToken];
               
               __weakSelf.dataArray = ddxxxada.homeArr;
               
               __weakSelf.manager.dataArray = ddxxxada.homeArr;//管理者赋值
               
               [__weakSelf.tableView reloadData];
               NSLog(@"---xx---%@",ddxxxada.homeArr);
           }
            
        }
        
    }];
    

}

#pragma mark ************** 数据处理
- (void)addDataDictionary:(NSDictionary *)dic
{
  
    if(!self.dataArray)
    {
        self.dataArray = [NSMutableArray array];
    }
    
    [self.dataArray addObject:dic];
    
    self.manager.dataArray = self.dataArray;//管理者赋值
    
    [self.tableView reloadData];
    
    if(self.dataArray.count == 1)
    {
        //保存第一次请求数据到本地
        LZLocalData *dada = [[LZLocalData alloc]init];
        dada.homeArr = self.dataArray;
        [LZPublicManager saveAccessToken:dada];
    
    }
    
}

#pragma mark ************** 双击刷新界面
- (void)beginRefreshing:(NSNotification *)sender
{
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
    [self.tableView.mj_header beginRefreshing];
}
#pragma mark ************** 销毁通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HomeRefreshingNotification object:nil];
}

#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    [self.view addSubview:self.tableView];
  
}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
@end
