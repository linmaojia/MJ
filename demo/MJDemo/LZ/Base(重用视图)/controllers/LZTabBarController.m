//
//  YZGTabBarController.m
//  yzg
//
//  Created by AVGD—JK on 16/5/31.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "LZTabBarController.h"
#import "MJHomeController.h"
@interface LZTabBarController ()
{
    NSDate *_lastDate;
}

@end

@implementation LZTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        
        UINavigationController* nav = (UINavigationController*)viewController;
        
        NSDate *date = [NSDate date];
        if([nav.topViewController isKindOfClass:[MJHomeController class]])
        {
            if (date.timeIntervalSince1970 - _lastDate.timeIntervalSince1970 < 0.5)
            {
                NSLog(@"双击我");
               
                [[NSNotificationCenter defaultCenter] postNotificationName:HomeRefreshingNotification object:nil userInfo:nil]; //发送刷新通知
                
                return NO;
            }
             _lastDate = date;
        }
    }
     return YES;

}

/*销毁通知*/
- (void)dealloc
{
   
}

@end
