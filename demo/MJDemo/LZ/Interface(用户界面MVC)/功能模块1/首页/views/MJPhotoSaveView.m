//
//  ETCollectMoreView.m
//  ETao
//
//  Created by AVGD－Mai on 16/3/7.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "MJPhotoSaveView.h"


@interface MJPhotoSaveView ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    UIVisualEffectView * effe;
    CGRect newframe;
    CGFloat currentScale,maxScale,minScale;
    BOOL isClockwise;
    CGPoint pointTap;
}
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) UIImageView *photoImg;
@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, strong) UIScrollView *scrollView;         /**<  图片 */


@property (nonatomic,copy) void(^saveBlock)();


@end

@implementation MJPhotoSaveView
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        maxScale = 3.0;
        minScale = 1.0;
        currentScale = 1.0;
        _scrollView=[[UIScrollView alloc]initWithFrame:self.frame];
        _scrollView.maximumZoomScale=4.0;//图片的放大倍数
        _scrollView.minimumZoomScale=1.0;//图片的最小倍率
        _scrollView.contentSize = CGSizeMake(self.frame.size.width *1.001, self.frame.size.height *1.001);
        _scrollView.delegate=self;
        
    }
    return _scrollView;
}
- (UIButton *)saveBtn   {
    if (!_saveBtn ) {
        _saveBtn =[[UIButton alloc]init];
        [_saveBtn  setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _saveBtn .titleLabel.font = systemFont(13);//标题文字大小
        _saveBtn .layer.cornerRadius = 3;
        _saveBtn .layer.masksToBounds = YES;
        [_saveBtn  addTarget:self action:@selector(saveClick:) forControlEvents:UIControlEventTouchDown];
        _saveBtn.backgroundColor = mainColor;
        
    }
    return _saveBtn;
}
- (UIImageView *)photoImg {
    if (!_photoImg) {
        _photoImg = [[UIImageView alloc] init];
        _photoImg.image = _image;
        _photoImg.backgroundColor = [UIColor grayColor];
        [_photoImg setMultipleTouchEnabled:YES];//多点触摸
        _photoImg.userInteractionEnabled = YES;
        [self addGestureRecognizerToView:_photoImg];
    }
    return _photoImg;
}
- (void)tapSinView:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [self dismiss];
}
// 处理拖拉手势
- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    
    //当缩放比例为最小的时候才允许拖动
    if(currentScale == minScale)
    {
        
        UIView *view = panGestureRecognizer.view;
        
        if (panGestureRecognizer.state == UIGestureRecognizerStateBegan )
        {
            pointTap = [panGestureRecognizer locationInView:view];//点击位置
            
            if(pointTap.y > _photoImg.frame.size.height/2)
            {
                isClockwise = YES;
            }
            else
            {
                isClockwise = NO;
            }
            NSLog(@"--x--%@",NSStringFromCGPoint(pointTap));
        }
        
        if (panGestureRecognizer.state == UIGestureRecognizerStateChanged)
        {
            
            
            CGPoint translation = [panGestureRecognizer translationInView:view.superview];
            
            CGFloat angle = (view.center.x - view.frame.size.width / 2.0) / view.frame.size.width/1.5;
            
            if(isClockwise)
            {
                view.transform = CGAffineTransformMakeRotation( -angle);//旋转角度(里面为圆周率，M_PI 则为倒转，正数为顺时针)
                NSLog(@"----ooo-----view--yyy---%lf",_photoImg.frame.size.height/2);
            }
            else
            {
                view.transform = CGAffineTransformMakeRotation( angle);//旋转角度(里面为圆周率，M_PI 则为倒转，正数为顺时针)
            }
            
            [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
            
            [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
        }
        if(panGestureRecognizer.state == UIGestureRecognizerStateEnded)
        {
            NSLog(@"移动结束");
            [UIView animateWithDuration:0.3 animations:^{
                
                view.center = self.center;
                
                view.transform = CGAffineTransformMakeRotation(0);
            }];
        }
        
    }
    
    
}

//双击手势
- (void)tapView:(UITapGestureRecognizer *)tapGestureRecognizer
{
    
    
    //当前倍数等于最大放大倍数
    //双击默认为缩小到原图
    if (currentScale==maxScale)
    {
        currentScale=minScale;
        
        [self.scrollView setZoomScale:currentScale animated:YES];
        
        return;
    }
    //当前等于最小放大倍数
    //双击默认为放大到最大倍数
    if (currentScale==minScale)
    {
        currentScale=maxScale;
        [self.scrollView setZoomScale:currentScale animated:YES];
        
        return;
    }
    
    
    //当前倍数大于平均倍数
    //双击默认为放大最大倍数
    if (currentScale>minScale) {
        currentScale=minScale;
        [self.scrollView setZoomScale:currentScale animated:YES];
        
        return;
    }
    
    
    
}
// 当缩放结束后，并且缩放大小回到minimumZoomScale与maximumZoomScale之间后（我们也许会超出缩放范围），调用该方法。
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale {
    
    NSLog(@"xxx----%@",NSStringFromCGPoint(_photoImg.center));
    
    currentScale = scale;//记录缩放比例
}
//缩放,每次缩放都会调用
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    
    [self centerScrollViewContents];
    
}
- (void)centerScrollViewContents
{
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.photoImg.frame;
    
    if (contentsFrame.size.width < boundsSize.width)
    {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    }
    else
    {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height)
    {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    }
    else
    {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.photoImg.frame = contentsFrame;
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    
    return _photoImg;
}

// 添加所有的手势
- (void) addGestureRecognizerToView:(UIView *)view
{
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
    [doubleTapGesture setNumberOfTapsRequired:2];
    doubleTapGesture.numberOfTouchesRequired = 1;
    [view addGestureRecognizer:doubleTapGesture];
    
    
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSinView:)];
    singleTapGesture.numberOfTouchesRequired = 1;
    [view addGestureRecognizer:singleTapGesture];
     [singleTapGesture requireGestureRecognizerToFail:doubleTapGesture];
    // 移动手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [view addGestureRecognizer:panGestureRecognizer];
    
    
    //添加轻扫手势
//    UISwipeGestureRecognizer *swipeGestureLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
//    //设置轻扫的方向
//    swipeGestureLeft.direction = UISwipeGestureRecognizerDirectionLeft; //默认向右
//    [view addGestureRecognizer:swipeGestureLeft];

}
+ (void)showPhotoViewWithImageView:(UIImageView *)imageView TitleBtnBlock:(void(^)())saveBlock
{
  
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    MJPhotoSaveView *blackView = [[MJPhotoSaveView alloc] initWithFrame:keyWindow.frame];//黑色阴影
    [keyWindow addSubview:blackView];
    
    [blackView setImageView:imageView];
    
    blackView.saveBlock = saveBlock;
    
}
#pragma mark **************** init
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = RGBA(0, 0, 0, 0);
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];//添加手势
        
        
        UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        effe = [[UIVisualEffectView alloc]initWithEffect:blur];
        effe.frame = self.frame;
        
        [self addSubview:effe];
        
       
        
    }
    return self;
}
- (void)setImageView:(UIImageView *)imageView
{
    _image = imageView.image;
    
    newframe = [imageView convertRect:imageView.bounds toView:self];
    
     NSLog(@"--%@",NSStringFromCGRect(newframe));
    
    [self addSubviewsForView];//添加子控件
    [self layoutSubviewsForView];//布局子控件
    [self show];//显示视图
}

#pragma mark ************** 按钮被点击
-(void)viewClick:(UITapGestureRecognizer *)sender
{

 
    
}
#pragma mark ************** 按钮被点击
- (void)saveClick:(UIButton *)sender
{
    self.saveBlock();
}
- (void)show
{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = RGBA(0, 0, 0, 0);
        
        self.photoImg.center = self.center;
        

    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        
        self.backgroundColor = RGBA(0, 0, 0, 0);
        
        self.photoImg.frame = newframe;
        
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark **************** 添加子控件
- (void)addSubviewsForView
{
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.photoImg];
    [self addSubview:self.saveBtn];


}
- (void)layoutSubviewsForView
{
    self.photoImg.frame = newframe;
    self.saveBtn.frame = CGRectMake(SCREEN_WIDTH - 60, SCREEN_HEIGHT - 35, 50, 25);
}

@end
