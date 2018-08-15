//
//  StastisticsUtility.h
//  自动埋点test
//
//  Created by 何志博 on 2018/8/15.
//  Copyright © 2018年 何志博. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StastisticsUtility : NSObject

+ (void)stastisticEventData:(NSString *)key extraDic:(NSDictionary *)Dic;

@end
