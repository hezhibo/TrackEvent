//
//  CommonUtility.h
//  自动埋点test
//
//  Created by 何志博 on 2018/8/15.
//  Copyright © 2018年 何志博. All rights reserved.
//


// 工具类

#import <Foundation/Foundation.h>

@interface CommonUtility : NSObject

+ (void)swizzlingInClass:(Class)cls originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

@end
