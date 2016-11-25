//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "LZLoginController.h"
#import "LZLoginManager.h"
@interface LZLoginController ()<UITextFieldDelegate>

@end

@implementation LZLoginController

#pragma mark ************** 初始化ib
- (void)loadFromNib
{
    _headImageView.layer.cornerRadius=50;
    _headImageView.layer.masksToBounds=YES;
    _headImageView.image = [UIImage imageNamed:@"minex"];
    [_headImageView setContentMode:UIViewContentModeScaleAspectFill];
    _headImageView.clipsToBounds=YES;
    
    UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];//  毛玻璃视图
    effectView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    effectView.alpha = 1;//设置模糊透明度
    [_bgImageView addSubview:effectView];
    
    _loginsBtn.layer.cornerRadius=3;
    _loginsBtn.layer.masksToBounds=YES;
    _loginsBtn.layer.borderWidth = 0.5;
    _loginsBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [_hidePassBtn setImage:[UIImage imageNamed:@"icon_visible"] forState:UIControlStateNormal];
    [_hidePassBtn setImage:[UIImage imageNamed:@"icon_hide"] forState:UIControlStateSelected];
    
    _iDTextFied.clearButtonMode=YES;
    _iDTextFied.returnKeyType = UIReturnKeyNext; // 设置return样色，登陆时使用
    _iDTextFied.delegate = self;
    _passWordTextFied.clearButtonMode=YES;
    _passWordTextFied.secureTextEntry=YES; //文本框文字是否保密
    _passWordTextFied.returnKeyType = UIReturnKeyJoin; // 设置return样色，登陆时使用
    _passWordTextFied.delegate = self;
    
    
    [_weiboBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [_QQBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [_weixinBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];

    CABasicAnimation *bigAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    bigAnimation.duration=1.5f;
    bigAnimation.fromValue = @1;//原始比例
    bigAnimation.toValue=@1.2;//放大比例
    bigAnimation.autoreverses=YES;//动画 完成后自动回放
    bigAnimation.repeatCount = FLT_MAX;//次数
    [_bgImageView.layer addAnimation:bigAnimation forKey:@"ani_scale"];
    
}
#pragma mark ************** 是否隐藏密码
- (IBAction)hiddenPassAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    
    _passWordTextFied.secureTextEntry=!_passWordTextFied.secureTextEntry; //文本框文字是否保密
}
- (IBAction)registBtn:(id)sender {
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
    
    [self loadFromNib];
    
    [self addSubviewsForView];
    
    [self addConstraintsForView];
    
    [self getPhoneArray];
    
}
- (void)getPhoneArray
{
    NSMutableArray *array =  [LZUserManager getPhoneListArray];
    if(array.count != 0)
    {
        _iDTextFied.text = array[0];
    }
}
#pragma mark ************** 设置导航栏
- (void)setNav
{
    self.view.backgroundColor = RGB(231 ,233, 237);
    
}

#pragma mark ************** 点击登陆
- (void)loginAction
{
    [SVProgressHUD showWithStatus:@"登陆中"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if(![RegExpValidate validateMobile:_iDTextFied.text])
        {
            [SVProgressHUD showErrorWithStatus:@"手机号码格式不正确"];
            return;
        }
        else
        {
             [SVProgressHUD showSuccessWithStatus:@"登陆成功"];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [LZUserManager savePhoneNumWithString:_iDTextFied.text];//保存电话号码
             });
            
        }
     
    });
    
}
#pragma mark ************** 点击屏幕
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];//结束编辑
}
#pragma mark ************** 点击return 隐藏键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    if (textField == _iDTextFied)
    {
        [_iDTextFied resignFirstResponder];
        [_passWordTextFied becomeFirstResponder];
    }
    else
    {
        [_passWordTextFied resignFirstResponder];
        
        [self loginAction];
    }
    return YES;
    
}
- (IBAction)loginAcion:(id)sender {
    
     [self loginAction];
}

#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    
    
}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    
}
@end
