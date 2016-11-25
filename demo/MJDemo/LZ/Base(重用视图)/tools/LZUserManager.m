//
//  UserManager.m
//  Masonry
//
//  Created by LXY on 16/5/28.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "LZUserManager.h"
#import "LZLoginController.h"
@implementation LZUserManager

+ (BOOL)firstLaunch
{
    if(![[NSUserDefaults standardUserDefaults] boolForKey:FirstLaunch])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:FirstLaunch];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        return YES;
    }
    
    return NO;
}
+ (BOOL)isLogin
{

    return [[NSUserDefaults standardUserDefaults] boolForKey:ISLOGIN];
}
/* 退出登陆状态*/
+ (void)outLoginState
{
    if([[NSUserDefaults standardUserDefaults] boolForKey:ISLOGIN])
    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:ISLOGIN];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        LZRootNavigationController *loginNav = [[LZRootNavigationController alloc] initWithRootViewController:[LZLoginController new]];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        window.rootViewController = loginNav;
    }
}
+ (NSMutableArray *)getPhoneListArray
{
    NSMutableArray *phoneListArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:PHONE_LIST]];
    return phoneListArray;
}
/* 保存电话号码，登陆状态*/
+ (void)savePhoneNumWithString:(NSString *)phoneNum
{
    NSMutableArray *phoneListArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:PHONE_LIST]];
    
    if(!phoneListArray)
    {
        phoneListArray = [NSMutableArray new];
    }
    if ([phoneListArray containsObject:phoneNum])
    {
        [phoneListArray removeObject:phoneNum];
        [phoneListArray insertObject:phoneNum atIndex:0];
    }
    else
    {
        [phoneListArray insertObject:phoneNum atIndex:0];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:phoneListArray forKey:PHONE_LIST];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self saveLoginState];//保存登陆状态
    
}
+ (void)saveLoginState
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:ISLOGIN];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;//跳转到tabBarController
    //配置tabBarController
    LZTabBarControllerConfig *tabBarControllerConfig = [[LZTabBarControllerConfig alloc] init];
    [window setRootViewController:tabBarControllerConfig.tabBarController];
    
}


@end
