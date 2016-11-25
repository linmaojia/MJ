//
//  YZGRootNavigationController.m
//  yzg
//
//  Created by AVGD—JK on 16/5/30.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "LZRootNavigationController.h"
@interface LZRootNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation LZRootNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavigationBarTheme];//导航栏主题设置
    
}
#pragma mark ************** 导航栏主题设置
- (void)setNavigationBarTheme
{
 
    UINavigationBar *appearance = [UINavigationBar appearance];
    
    //导航栏背景颜色
    //[appearance setBarTintColor:mainColor];
    
    //设置中部文字属性,颜色和字体大小
    [appearance setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor] ,NSFontAttributeName:[UIFont boldSystemFontOfSize:17]}];
    
    //返回item颜色
    [appearance setTintColor:[UIColor blackColor]];
    
}

#pragma mark ************** 设置是否显示底部标签栏
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.viewControllers.count > 0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }

      [super pushViewController:viewController animated:animated];
}



@end
