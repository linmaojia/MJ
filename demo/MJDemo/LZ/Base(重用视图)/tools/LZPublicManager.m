//
//  UserManager.m
//  Masonry
//
//  Created by LXY on 16/5/28.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "LZPublicManager.h"
#define ETAccessTokenFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"YZGaccessToken.data"]
@implementation LZPublicManager

//解档令牌模型
+ (LZLocalData *)accessToken
{
    //解档
    LZLocalData *accessToken = [NSKeyedUnarchiver unarchiveObjectWithFile:ETAccessTokenFilepath];
    return accessToken;
    
}

//归档令牌模型
+ (void)saveAccessToken:(LZLocalData *)accessToken
{
    [NSKeyedArchiver archiveRootObject:accessToken toFile:ETAccessTokenFilepath];
}





+ (void)seveDataToLocalWithArray:(NSMutableArray *)dataArray Key:(NSString *)key
{
    
   //    NSLog(@"000-----%@",[[NSUserDefaults standardUserDefaults] objectForKey:key]);
//     [[NSUserDefaults standardUserDefaults] synchronize];
}

//+ (void)seveDataToLocalWithArray:(NSMutableArray *)dataArray Key:(NSString *)key
//{
//    
//    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);//获取本地沙盒路径
//    
//    NSString *documentsPath = [path objectAtIndex:0];//获取完整路径
//    
//    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"MY_Data.plist"];
//    
//    if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath] == NO)
//    {
//        
//        NSFileManager* fileManager = [NSFileManager defaultManager];
//        
//        [fileManager createFileAtPath:plistPath contents:nil attributes:nil];//if(IOS8)
//    
//    }
//    
//    NSDictionary *dic2 = @{key:dataArray};
//    
//    [dic2 writeToFile:plistPath atomically:YES];
//    
//    NSLog(@"--%@",plistPath);
//    
//    //读文件
//    NSDictionary* dic3 = [NSDictionary dictionaryWithContentsOfFile:plistPath];
//    NSLog(@"dic is:%@",dic3);
//    
//}
+ (NSArray *)readLocalDataWithKry:(NSString *)key
{
    //获取本地沙盒路径
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //获取完整路径
    NSString *documentsPath = [path objectAtIndex:0];
    
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"MY_Data.plist"];
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];  //读取数据
    NSLog(@"-bbbb-%@",dic2);
    NSArray *array = [dic2 objectForKey:key];

    return array;
}
/*
 NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);//获取本地沙盒路径
 
 NSString *documentsPath = [path objectAtIndex:0];//获取完整路径
 
 NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"My_Data.txt"];
 
 NSFileManager* fileManager = [NSFileManager defaultManager];
 if ([fileManager fileExistsAtPath:plistPath] == NO)
 {
 [fileManager createFileAtPath:plistPath contents:nil attributes:nil];//if(IOS8)
 }
 
 NSDictionary *dic2 = @{key:@{@"xxx":@"00000"}};
 
 if ([dic2 writeToFile:plistPath atomically:YES]) {
 NSLog(@"保存成功");
 
 }else{
 NSLog(@"保存失败");
 }
 NSLog(@"保存成功---%@",plistPath);

 */
@end
