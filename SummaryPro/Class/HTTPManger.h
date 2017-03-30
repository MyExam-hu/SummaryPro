//
//  HTTPManger.h
//  Eateraction
//
//  Created by huweidong on 28/3/2017.
//  Copyright © 2017年 com.zxd.eateraction. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface HTTPManger : AFHTTPSessionManager

+ (AFHTTPSessionManager *)sharedManager;

@end
