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

typedef void(^webServiceSuccessBlock) (NSString *result);
typedef void(^webService_FailBlock) (NSError *error);
typedef void(^webServiceFinish) (NSData *result,NSError *error);

@interface clsWebServices : NSObject

@property (nonatomic, weak) id<clsWebServiceDelegate> delegate;

-(void)forgetPassword:(NSString *)email;
-(void)forgetPassword:(NSString *)email :(webServiceSuccessBlock)backBlock :(webService_FailBlock)backError;
-(void)forgetPassword:(NSString *)email :(webServiceFinish)backBlock;

-(void)login:(NSString *)areaCode :(NSString *)tel :(NSString *)pwd;

@end
