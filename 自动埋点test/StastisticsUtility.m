//
//  StastisticsUtility.m
//  自动埋点test
//
//  Created by 何志博 on 2018/8/15.
//  Copyright © 2018年 何志博. All rights reserved.
//

#import "StastisticsUtility.h"

@implementation StastisticsUtility

+ (void)stastisticEventData:(NSString *)key extraDic:(NSDictionary *)Dic {
    
    NSLog(@"controlName-->%@  extraDic--->%@",key,Dic);
}

@end
