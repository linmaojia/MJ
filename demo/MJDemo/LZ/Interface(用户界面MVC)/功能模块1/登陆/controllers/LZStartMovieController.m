//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "LZStartMovieController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import "LZLoginController.h"
@interface LZStartMovieController ()
@property (strong, nonatomic) MPMoviePlayerController *player;
@property (nonatomic, strong) UIButton *enterBtn;             /**<  系统按钮 */

@end

@implementation LZStartMovieController

#pragma mark ************** 懒加载控件

- (UIButton *)enterBtn {
    if (!_enterBtn) {
        _enterBtn=[[UIButton alloc]init];
        [_enterBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _enterBtn.layer.borderWidth = 0.5;
        _enterBtn.layer.cornerRadius = 24;
        _enterBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        [_enterBtn setTitle:@"进入应用" forState:UIControlStateNormal];
        _enterBtn.alpha = 0;
        [_enterBtn addTarget:self action:@selector(enterBtnClick:) forControlEvents:UIControlEventTouchDown];
        
    }
    return _enterBtn;
}

#pragma mark ************** 按钮被点击
- (void)enterBtnClick:(UIButton *)sender
{
    
    LZLoginController *loginVC = [[LZLoginController alloc] init];
    LZRootNavigationController *rootNav = [[LZRootNavigationController alloc] initWithRootViewController:loginVC];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    keyWindow.rootViewController = rootNav;
    
}
- (MPMoviePlayerController *)player {
    
    if (!_player) {
        NSString *myFilePath = [[NSBundle mainBundle]pathForResource:@"qidong"ofType:@"mp4"];
        NSURL *movieURL = [NSURL fileURLWithPath:myFilePath];
        _player = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
        _player.shouldAutoplay = YES;
        [_player setControlStyle:MPMovieControlStyleNone];
        _player.repeatMode = MPMovieRepeatModeOne;
        _player.view.alpha = 0;
        
    }
    return _player;
}
#pragma mark ************** 懒加载控件
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];//设置导航栏
    
    [self addSubviewsForView];
    
    [self animationAction];
}
#pragma mark ************** 设置导航栏
- (void)setNav
{
    self.view.backgroundColor = RGB(235, 235, 241);

}

#pragma mark ************** 动画
- (void)animationAction
{
    [UIView animateWithDuration:3 animations:^{
         self.player.view.alpha = 1;
        [self.player prepareToPlay];
        
        self.enterBtn.alpha = 1.0;
    }];
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    [self.view addSubview:self.player.view];
    self.player.view.frame = self.view.bounds;
    
    [self.view addSubview:self.enterBtn];
    self.enterBtn.frame = CGRectMake(24, [UIScreen mainScreen].bounds.size.height - 32 - 48, [UIScreen mainScreen].bounds.size.width - 48, 48);
    
}

@end
