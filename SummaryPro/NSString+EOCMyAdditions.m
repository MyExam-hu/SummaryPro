//
//  NSString+EOCMyAdditions.m
//  OpenGLESDemo
//
//  Created by huweidong on 9/11/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "NSString+EOCMyAdditions.h"
#import <objc/runtime.h>

@implementation NSString (EOCMyAdditions)

- (instancetype)init
{
    self = [super init];
    if (self) {
        //替换两个方法的实现达到输出测试结果的目的(作用范围,整个运行期)
        Method originalMethod=class_getInstanceMethod([NSString class], @selector(lowercaseString));
        Method swappedMethod=class_getInstanceMethod([NSString class], @selector(eoc_myLowercaseString));
        method_exchangeImplementations(originalMethod, swappedMethod);
    }
    return self;
}

-(NSString *)eoc_myLowercaseString{
    NSString *lowercase=[self eoc_myLowercaseString];
    NSLog(@"%@=>%@",self,lowercase);
    return lowercase;
}

@end
