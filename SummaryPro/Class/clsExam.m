//
//  clsExam.m
//  OpenGLESDemo
//
//  Created by huweidong on 9/11/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "clsExam.h"

@interface clsExam()

@end

@implementation clsExam

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.youName=@"";
        self.myName=@"";
    }
    return self;
}

-(BOOL)isEqualToclsExam:(clsExam *)object{
    if (self == object) return YES;
    if (![_youName isEqualToString:object.youName]) {
        return NO;
    }
    if (![_myName isEqualToString:object.myName]) {
        return NO;
    }
    return YES;
}

- (BOOL)isEqual:(id)other
{
    if ([self class] == [other class]) {
        return [self isEqualToclsExam:(clsExam *)other];
    }else{
        return [super isEqual:other];
    }
}

- (NSUInteger)hash
{
    NSUInteger myNameHash=[_myName hash];
    NSUInteger youNameHash=[_youName hash];
    return myNameHash^youNameHash;
}

@end
