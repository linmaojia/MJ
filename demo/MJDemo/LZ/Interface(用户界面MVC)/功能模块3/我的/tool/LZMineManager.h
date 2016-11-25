//
//  GetOrderList.h
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LZMineManager : NSObject<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,copy) void(^cellClickBlack)(UIImageView *moveView);
@property (nonatomic,copy) void(^offsetYBlack)(CGFloat offsetY);


@end
