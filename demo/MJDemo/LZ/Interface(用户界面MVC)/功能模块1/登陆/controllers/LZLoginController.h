//
//  YZGUserSettingViewController.h
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "LZRootViewController.h"
/**< 登陆 */
@interface LZLoginController : LZRootViewController
@property (strong, nonatomic) IBOutlet UIImageView *bgImageView;
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UIButton *loginsBtn;
@property (strong, nonatomic) IBOutlet UIButton *passWordBtn;
@property (strong, nonatomic) IBOutlet UITextField *iDTextFied;
@property (strong, nonatomic) IBOutlet UITextField *passWordTextFied;
@property (strong, nonatomic) IBOutlet UIButton *hidePassBtn;

@property (strong, nonatomic) IBOutlet UIButton *weiboBtn;
@property (strong, nonatomic) IBOutlet UIButton *QQBtn;
@property (strong, nonatomic) IBOutlet UIButton *weixinBtn;

@end
