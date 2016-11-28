//
//  clsExam.m
//  OpenGLESDemo
//
//  Created by huweidong on 9/11/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "clsExam.h"

@interface clsExam()<NSCopying>

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

//打印输出黑科技
- (NSString *)description
{
//    return [NSString stringWithFormat:@"<%@: %p,\"%@ %@\">", [self class],self,_myName,_youName];
    return [NSString stringWithFormat:@"<%@: %p, %@", [self class],self,@{@"youName":_youName,
                                                                                                                @"myName":_myName}];
}

- (NSString *)debugDescription
{
//    return [NSString stringWithFormat:@"<%@: %p, %@", [self class],self,@{@"youName":_youName,
//                                                                          @"myName":_myName}];
    return [self description];
}

-(id)copyWithZone:(NSZone *)zone{
    clsExam *copy=[[[self class] allocWithZone:zone] init];
    copy->_youName=[_youName copy];
    copy->_myName=[_myName copy];
    return copy;
}

@end
