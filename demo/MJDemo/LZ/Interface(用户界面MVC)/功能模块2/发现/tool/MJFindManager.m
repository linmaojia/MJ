//
//  GetOrderList.m
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "MJFindManager.h"
#import "MJFindCollectCell.h"
#import "MJFindTopCollectCell.h"
@interface MJFindManager ()

@end
@implementation MJFindManager


#pragma mark ************** CollectionView 代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.item == 0)
    {
        MJFindTopCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MJFindTopCollectCell" forIndexPath:indexPath];
        cell.model =  _dataArray[indexPath.item];
        return cell;
    }
    else
    {
        MJFindCollectCell *cell = (MJFindCollectCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"MJFindCollectCell" forIndexPath:indexPath];
        cell.model =  _dataArray[indexPath.item];

        return cell;
    }
    
    
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size;
    if(indexPath.item == 0 || indexPath.item == 3)
    {
        size = CGSizeMake(SCREEN_WIDTH, 200);
    }
    else
    {
        size = CGSizeMake((SCREEN_WIDTH - 5)/2, (SCREEN_WIDTH - 5)/2);
    }
    
    return size;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  
    
}

@end
