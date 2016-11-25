//
//  AppDelegate.m
//  LZ
//
//  Created by LXY on 16/11/4.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "AppDelegate.h"
#import "LZTabBarControllerConfig.h"
#import "LZNewFeatureController.h"
#import "LZLoginController.h"
#import "IQKeyboardManager.h"
#import <JSPatchPlatform/JSPatch.h>
//#import "iVersion.h"
#import <Bugtags/Bugtags.h>
#import "LZStartMovieController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [NSThread sleepForTimeInterval:1.0];//设置启动页面时间
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self handleOtherLogic];//配置相关第三方
    
    [self jumpToViewControllerOnLoginState];//处理跳转逻辑
 
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark **************** 根据是否是首次登录来进行跳转控制器
- (void)jumpToViewControllerOnLoginState
{
    if ([LZUserManager firstLaunch])//首次使用
    {
        LZStartMovieController *featureVC = [[LZStartMovieController alloc] init];
        [self.window setRootViewController:featureVC];
        
    }
    else
    {
        
        if (![LZUserManager isLogin])//登录状态
        {
            LZLoginController *loginVC = [[LZLoginController alloc] init];
            LZRootNavigationController *loginNav = [[LZRootNavigationController alloc] initWithRootViewController:loginVC];
            self.window.rootViewController = loginNav;
        }
        else
        {
            LZTabBarControllerConfig *tabBarControllerConfig = [[LZTabBarControllerConfig alloc] init];
            [self.window setRootViewController:tabBarControllerConfig.tabBarController];
        }
    }
    
}
#pragma mark **************** 配置相关第三方
- (void)handleOtherLogic
{
    /* 配置JSPatch热修复*/
    
    //调试模式测试
    [JSPatch testScriptInBundle];
    
    //正式环境
    //[JSPatch startWithAppKey:JSPatchKey];
    //[JSPatch sync];
    
    
    /* 配置崩溃日志*/
    BugtagsOptions *options = [[BugtagsOptions alloc] init];
    options.trackingCrashes = YES;
    options.trackingNetwork = YES; // 具体可设置的属性请查看 Bugtags.h
    [Bugtags startWithAppKey:BugTagsKey invocationEvent:BTGInvocationEventNone];
    
    /* 配置 图片最大缓存大小(10M)*/
    [SDImageCache sharedImageCache].maxCacheSize = 1024 * 1024 * 10;
    
    /* 配置 IQKeyboardManager*/
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;//激活
    manager.shouldResignOnTouchOutside = YES;//设置点击View其它位置收回键盘
    manager.shouldToolbarUsesTextFieldTintColor = YES;//设置工具栏颜色是否跟文本框一致
    manager.enableAutoToolbar = YES;//激活工具栏
    
    
    /*配置SVP*/
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setFont:[UIFont boldSystemFontOfSize:16.f]];
    
}
#pragma mark **************** 版本更新,后面加
//+ (void)initialize
//{
//    //如果是苹果商店  直接传bundleID
//    [iVersion sharedInstance].applicationBundleID = BundleID;
//    //其它设置
//    [iVersion sharedInstance].appStoreCountry = @"cn";
//    [iVersion sharedInstance].updateAvailableTitle = @"有新版本可供下载";
//    [iVersion sharedInstance].remindButtonLabel = @"残忍拒绝";
//    [iVersion sharedInstance].downloadButtonLabel = @"现在下载";
//    [iVersion sharedInstance].showOnFirstLaunch = YES;
//}
@end
