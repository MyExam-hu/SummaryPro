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

@end
