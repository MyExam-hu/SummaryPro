//
//  NSString+EOCMyAdditions.m
//  OpenGLESDemo
//
//  Created by huweidong on 9/11/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "NSString+EOCMyAdditions.h"

@implementation NSString (EOCMyAdditions)

-(NSString *)eoc_myLowercaseString{
    NSString *lowercase=[self eoc_myLowercaseString];
    NSLog(@"%@=>%@",self,lowercase);
    return lowercase;
}

@end
