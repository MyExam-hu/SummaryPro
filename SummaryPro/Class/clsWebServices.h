//
//  clsWebServices.h
//  SummaryPro
//
//  Created by huweidong on 28/11/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol clsWebServiceDelegate <NSObject>

@optional

- (void)WebService_Success:(int)pserviceType :(NSString *)result;
- (void)WebService_Fail:(int)pserviceType;

@end

@interface clsWebServices : NSObject{
    struct{
        unsigned int webService_Success :1;
        unsigned int webService_Fail :1;
    }_delegateFlags;
}

@property (nonatomic, weak) id<clsWebServiceDelegate> delegate;

-(void)forgetPassword:(NSString *)email;

@end
