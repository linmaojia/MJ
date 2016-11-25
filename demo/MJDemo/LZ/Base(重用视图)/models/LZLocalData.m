//
//  ETAccessToken.m
//  ETao
//
//  Created by AVGD—JK on 16/3/4.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "LZLocalData.h"

@implementation LZLocalData

/**
 *  当把一个对象 归档 到文件中 会调用一次
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    
    [encoder encodeObject:self.homeArr forKey:@"homeArr"];
    [encoder encodeObject:self.findArr forKey:@"findArr"];

}

/**
 *  从文件中 解析 一个对象 时会调用1次
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        
        self.homeArr = [decoder decodeObjectForKey:@"homeArr"];
        self.findArr = [decoder decodeObjectForKey:@"findArr"];

    }
    return self;
}

@end
