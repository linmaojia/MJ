//
//  YZGRootViewController.m
//  yzg
//
//  Created by AVGD—JK on 16/5/30.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "LZRootViewController.h"


@interface LZRootViewController ()

@end

@implementation LZRootViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"[%@]===已被创建",NSStringFromClass([self class]));
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = RGB(235, 235, 241);
    
     //设置CGRectZero从导航栏下开始计算
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
- (void)dealloc
{
    NSLog(@"[%@]===已被释放",NSStringFromClass([self class]));
}

@end
