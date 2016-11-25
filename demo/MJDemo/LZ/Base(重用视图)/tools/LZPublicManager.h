//
//  UserManager.h
//  Masonry
//
//  Created by LXY on 16/5/28.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZLocalData.h"

@interface LZPublicManager : NSObject


+ (LZLocalData *)accessToken;//反归档，用户数据

+ (void)saveAccessToken:(LZLocalData *)accessToken;//对象归档，保存数据




/** 保存数据到本地*/
+ (void)seveDataToLocalWithArray:(NSMutableArray *)dataArray Key:(NSString *)key;

/** 读取本地数据*/
+ (NSArray *)readLocalDataWithKry:(NSString *)key;



@end
