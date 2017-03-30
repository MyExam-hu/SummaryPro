//
//  HTTPManger.m
//  Eateraction
//
//  Created by huweidong on 28/3/2017.
//  Copyright © 2017年 com.zxd.eateraction. All rights reserved.
//

#import "HTTPManger.h"

@implementation HTTPManger

static AFHTTPSessionManager *manager;

+ (AFHTTPSessionManager *)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[AFHTTPSessionManager manager];
        manager.requestSerializer=[AFJSONRequestSerializer serializer];
        manager.requestSerializer.timeoutInterval=30;
        manager.responseSerializer=[AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    });
    return manager;
}

@end
