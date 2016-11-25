//
//  ETCollectMoreView.h
//  ETao
//
//  Created by AVGD－Mai on 16/3/7.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJPhotoSaveView : UIView

+ (void)showPhotoViewWithImageView:(UIImageView *)imageView TitleBtnBlock:(void(^)())saveBlock;
@end
