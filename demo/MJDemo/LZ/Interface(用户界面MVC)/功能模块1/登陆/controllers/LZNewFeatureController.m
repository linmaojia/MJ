//
//  YZGNewFeatureViewController.m
//  yzg
//
//  Created by EDS on 16/7/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "LZNewFeatureController.h"
#import "LZLoginController.h"
#import "EAIntroPage.h"
#import "EAIntroView.h"
@interface LZNewFeatureController ()<UIScrollViewDelegate,EAIntroDelegate>

@end

@implementation LZNewFeatureController

- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showIntroWithCustomView];
}
- (void)showIntroWithCustomView {
    EAIntroPage *page1 = [EAIntroPage page];
    page1.bgImage = [UIImage imageNamed:@"guid1"];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.bgImage = [UIImage imageNamed:@"guid2"];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.bgImage = [UIImage imageNamed:@"guid3"];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3]];
    [intro.skipButton setTitle:@"登录体验" forState:UIControlStateNormal];
    
    [intro setDelegate:self];
    [intro showInView:self.view animateDuration:0.3];
}
#pragma mark **************** EAIntroView delegate
- (void)introDidFinish:(EAIntroView *)introView wasSkipped:(BOOL)wasSkipped
{
    LZLoginController *loginVC = [[LZLoginController alloc] init];
    LZRootNavigationController *rootNav = [[LZRootNavigationController alloc] initWithRootViewController:loginVC];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    keyWindow.rootViewController = rootNav;
}
@end
