//
//  YZGMineTableHeadView.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZMineTableHeadView : UIView


@property (nonatomic,assign) CGFloat offsetY;

@property (nonatomic,copy) void(^headImgClick)();      /**< 排行榜回调 */




@end
