//
//  YZGMineTableHeadView.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "MJHomeTableSectionFootView.h"
#import "LZHomeFootCollectCell.h"

static float const collect_H = 200 - 10;//10 为UICollection 区的空隙
@interface MJHomeTableSectionFootView()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation MJHomeTableSectionFootView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor grayColor];
        [self addSubviewsForView];
        [self addConstraintsForView];
        NSLog(@"--fff-%lf",self.frame.size.height);
    }
    return self;
}
#pragma mark ************** 懒加载控件
- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        ESWeakSelf;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f);
        layout.minimumInteritemSpacing = 5; //列与列之间的间距
        layout.minimumLineSpacing = 0;//行与行之间的间距
        layout.itemSize = CGSizeMake((collect_H - 55) * 1.72 , collect_H);//cell的大小, 减去55 是文字高度
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;//水平滑动
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor colorWithHexColorString:@"f9f9f9"];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[LZHomeFootCollectCell class] forCellWithReuseIdentifier:@"cellIdentifi"];//注册cell
        
    }
    return _collectionView;
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    
    [_collectionView reloadData];
   
}
#pragma mark ************** CollectionView 代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    LZHomeFootCollectCell *cell = (LZHomeFootCollectCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifi" forIndexPath:indexPath];
    
    cell.model = _dataArray[indexPath.row];
    
     return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *model = _dataArray[indexPath.row];
    
    if([model[@"type"] isEqualToString:@"video"])
    {
        return  CGSizeMake((collect_H - 55) * 1.72 , collect_H);
    }
    else
    {
        return  CGSizeMake((collect_H - 55) , collect_H);
    }
   
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    [self addSubview:self.collectionView];
    
}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

@end
