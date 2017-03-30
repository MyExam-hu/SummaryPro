//
//  clsWebServices.m
//  SummaryPro
//
//  Created by huweidong on 28/11/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "clsWebServices.h"
#import "AFNetworking.h"

@interface clsWebServices(){
    struct{
        unsigned int webService_Success :1;
        unsigned int webService_Fail :1;
    }_delegateFlags;
}

@property (strong, nonatomic) AFHTTPSessionManager *manager;

@end

@implementation clsWebServices

-(void)dealloc{
    self.manager=nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.manager=[AFHTTPSessionManager manager];
        self.manager.requestSerializer=[AFJSONRequestSerializer serializer];
        self.manager.requestSerializer.timeoutInterval=30;
        self.manager.responseSerializer=[AFJSONResponseSerializer serializer];
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    }
    return self;
}

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


-(void)login:(NSString *)areaCode :(NSString *)tel :(NSString *)pwd{
    NSMutableDictionary * para = [NSMutableDictionary dictionary] ;
//    [para setObject:KEY forKey:@"SESSION_KEY"];
    [para setObject:areaCode forKey:@"AREA_CODE"];
    [para setObject:tel forKey:@"TEL"] ;
    [para setObject:pwd forKey:@"PASSWORD"];
    [para setObject:@1 forKey:@"DEVICE_TYPE"];
//    [para setObject:[clsOtherFun getDeviceToken] forKey:@"DEVICE_TOKEN"];
    
    [self post:@"Traveler/Login" :1 :para];
}

-(void)post:(NSString *)method :(int)type :(NSDictionary *)para{
//    NSString * url=[clsOtherFun getWSURL:method];
    NSString * url=@"http://172.16.1.9/DmCareApi";
    
    [self.manager POST:url parameters:para progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [self deSerializeClass:type :responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(error.code!=-999){
            if(self.delegate && [self.delegate respondsToSelector:@selector(WebService_Fail:)]){
                [self.delegate WebService_Fail:type];
            }
        }
    }];
    
}

-(void)cancel {
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [self.manager.operationQueue cancelAllOperations];
    [self.manager invalidateSessionCancelingTasks:YES];
}

@end
