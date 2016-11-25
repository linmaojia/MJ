//
//  GetOrderList.h
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MJHomeManager : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;

/*判断是否为空字符串*/
- (BOOL) isNullString:(id)string;


@property (nonatomic,copy) void(^cellClickBlack)(UIImageView *moveView);


@end
