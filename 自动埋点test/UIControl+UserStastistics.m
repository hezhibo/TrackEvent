//
//  UIControl+UserStastistics.m
//  自动埋点test
//
//  Created by 何志博 on 2018/8/15.
//  Copyright © 2018年 何志博. All rights reserved.
//

#import "UIControl+UserStastistics.h"
#import "StastisticsUtility.h"
#import "CommonUtility.h"
#import <objc/runtime.h>

@implementation UIControl (UserStastistics)

static char *extraKey = "stastisticExtraKey";

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      //原方法
                      SEL originalSelector = @selector(sendAction:to:forEvent:);
                      //我们要实现的方法
                      SEL swizzledSelector = @selector(swiz_sendAction:to:forEvent:);
                      //方法交换（具体实现在上面）
                      [CommonUtility swizzlingInClass:[self class] originalSelector:originalSelector swizzledSelector:swizzledSelector];
                  });
}

#pragma mark - Runtime增加属性
- (void)setStastisticExtraDic:(NSMutableDictionary *)stastisticExtraDic
{
    objc_setAssociatedObject(self, &extraKey,stastisticExtraDic,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)stastisticExtraDic
{
    return objc_getAssociatedObject(self, &extraKey);
}

#pragma mark - Method Swizzling
- (void)swiz_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    [self swiz_sendAction:action to:target forEvent:event];
    //插入埋点代码
    [self performUserStastisticsAction:action to:target forEvent:event];
}

- (void)performUserStastisticsAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    NSString *actionStr = NSStringFromSelector(action);
    actionStr = [actionStr hasPrefix:@"_"]?[actionStr substringFromIndex:1]:actionStr;
    
    //我以NSStringFromClass([target class])_actionStr_self.tag作为key来配置埋点文件
    NSString *controlName = self.tag>0?[NSString stringWithFormat:@"%@_%@_%ld", NSStringFromClass([target class]), actionStr,self.tag]:[NSString stringWithFormat:@"%@_%@", NSStringFromClass([target class]), actionStr];
    
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"a" ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    NSDictionary *tmpDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    NSDictionary *dataSource = [tmpDic objectForKey:@"eventStastistics"];
    NSLog(@"dataSource-->%@",dataSource);
    if ([dataSource objectForKey:controlName]) {
        self.stastisticExtraDic = [dataSource objectForKey:controlName];
    }else {
        self.stastisticExtraDic = nil;
    }
    
    //埋点具体实现
    [StastisticsUtility stastisticEventData:controlName extraDic:self.stastisticExtraDic];
}

@end
