//
//  clsWebServices.m
//  SummaryPro
//
//  Created by huweidong on 28/11/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "clsWebServices.h"

@interface clsWebServices(){
    struct{
        unsigned int webService_Success :1;
        unsigned int webService_Fail :1;
    }_delegateFlags;
}

@end

@implementation clsWebServices

-(void)setDelegate:(id<clsWebServiceDelegate>)delegate{
    _delegate=delegate;
    _delegateFlags.webService_Success=delegate && [delegate respondsToSelector:@selector(WebService_Success::)];
     _delegateFlags.webService_Fail=delegate && [delegate respondsToSelector:@selector(WebService_Fail:)];
}

-(void)forgetPassword:(NSString *)email{
    //判断
    if (_delegateFlags.webService_Success) {
        [self.delegate WebService_Success:5 :@"233"];
    }
}

-(void)forgetPassword:(NSString *)email :(webServiceSuccessBlock)backBlock :(webService_FailBlock)backError{
    if (backBlock) {
        //请求发送到的路径
        NSURL *url = [NSURL URLWithString:@"http://172.16.1.9/DmCareApi/Glucose/CurveReport"];
        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
        
        NSDictionary *para=@{@"SESSION_KEY":@"X29McF3vLHFIYSdIzOXB0W4Hv4L98d359kpwPrYY5QZOmP++IecoWenqfxrh9vQLbultoQ27ngc845RvqhdgKA==",@"DATE":@"2016-12-08 11:13:57",@"DAY":@7};
        NSString *soapMessage;
        if ([NSJSONSerialization isValidJSONObject:para])
        {
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:para options:NSJSONWritingPrettyPrinted error: &error];
            soapMessage= [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
        
        //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
        [theRequest addValue: @"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [theRequest setHTTPMethod:@"POST"];
//        [theRequest addValue: [clsBaseOtherFun getWS_User] forHTTPHeaderField:@"UserName"];
//        [theRequest addValue: [clsBaseOtherFun getWS_PWD] forHTTPHeaderField:@"Password"];
        [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
        
        // 3.获得会话对象
        NSURLSession *session = [NSURLSession sharedSession];
        
        // 4.根据会话对象，创建一个Task任务
        NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:theRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSLog(@"从服务器获取到数据");
            backBlock(@"233");
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
            NSLog(@"%@",dict);
        }];
        
        //5.最后一步，执行任务，(resume也是继续执行)。
        [sessionDataTask resume];
    }
}

-(void)forgetPassword:(NSString *)email :(webServiceFinish)backBlock{
    
}

@end
