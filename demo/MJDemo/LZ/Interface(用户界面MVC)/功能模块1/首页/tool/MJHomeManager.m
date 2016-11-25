//
//  GetOrderList.m
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "MJHomeManager.h"
#import "MJHomeTableVIewCell.h"
#import "MJHomeTableSectionFootView.h"
@interface MJHomeManager ()

@end
@implementation MJHomeManager
/*
 判断是否为空字符串
 */
- (BOOL) isNullString:(id)string
{
    if(string == nil)
    {
        return YES;
    }
    else if([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else if([string isEqualToString:@"(null)"])
    {
        return YES;
    }
    else if([string isEqualToString:@"<null>"])
    {
        return YES;
    }
    else if([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
/*cell 数组*/
- (NSArray *)cellArrayWithSection:(NSInteger)section
{
    
    NSArray *arr = _dataArray[section][@"sectionList"];
    
    NSArray *cellArr = arr[0][@"itemList"];
    
    return cellArr;
}
/*cell 高度*/
- (CGFloat )cellHeightWithIndexPatch:(NSIndexPath *)indexPatch
{
    CGFloat cell_H = 0;
    
    NSArray *cellArr = [self cellArrayWithSection:indexPatch.section];
    
    NSDictionary *model = cellArr[indexPatch.row];
    
    if([model[@"type"] isEqualToString:@"textHeader"])
    {
        cell_H = 60;
    }
    else
    {
        cell_H = SCREEN_WIDTH/1.72;
    }
    
    return cell_H;
}

#pragma mark ************** UITableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray *cellArr = [self cellArrayWithSection:section];
    
    return  cellArr.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [self cellHeightWithIndexPatch:indexPath];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MJHomeTableVIewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MJHomeTableVIewCell" forIndexPath:indexPath];
    
    NSArray *cellArr = [self cellArrayWithSection:indexPath.section];
    
    cell.model = cellArr[indexPath.row];
    
    cell.cellClickBlack = ^(UIImageView *moveView){
        if(self.cellClickBlack)
        {
            self.cellClickBlack(moveView);
        }
    };
 
    return cell;
    
}


/*分区头部部高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

/*分区尾部高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    NSArray *arr = _dataArray[section][@"sectionList"];
    
    if(arr.count == 1)
    {
         return 0.1;
    }
    else
    {
         return 200;
    }
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    MJHomeTableSectionFootView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MJHomeTableSectionFootView"];

    if(!footView)
    {
        footView = [[MJHomeTableSectionFootView alloc] initWithReuseIdentifier:@"MJHomeTableSectionFootView"];
    }
    NSArray *arr = _dataArray[section][@"sectionList"];
    
    if(arr.count != 1)
    {
        NSArray *dataArray = arr[1][@"itemList"][0][@"data"][@"itemList"];
        
        footView.dataArray = dataArray;
    }

    return footView;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
}
@end
