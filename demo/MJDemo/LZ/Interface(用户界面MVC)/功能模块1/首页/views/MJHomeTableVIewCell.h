//
//  YZGMineTableOrderCell.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface MJHomeTableVIewCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *model;

@property (nonatomic,copy) void(^cellClickBlack)(UIImageView *moveView);

@end
