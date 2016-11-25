//
//  GetOrderList.m
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "LZMineManager.h"

@interface LZMineManager ()
@property (nonatomic, strong) NSArray *dataArray;

@end
@implementation LZMineManager


-(instancetype)init
{
    if(self=[super init]) // 重新赋值了
    {
        _dataArray = @[@"我的消息",@"我的缓存",@"我要投稿",@"意见反馈",@"我的照片",@"我的消息",@"我的缓存",@"我要投稿",@"意见反馈",@"我的照片"];
        
    }
    return self;
    
}
#pragma mark ************** UITableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  _dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *cellIden = @"cell";//普通cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellIden];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//右边尖括号
    cell.textLabel.text = _dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//去掉点击效果
    return cell;
 
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 计算当前偏移位置
    CGFloat offsetY = scrollView.contentOffset.y;
    if(self.offsetYBlack)
    {
        self.offsetYBlack(offsetY);
    }
    NSLog(@"offsetY=%f",offsetY);
   
}
@end
