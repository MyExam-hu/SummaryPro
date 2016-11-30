//
//  clsExam.m
//  OpenGLESDemo
//
//  Created by huweidong on 9/11/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "clsExam.h"

class Hello {
private:
    id greeting_text;  // holds an NSString
public:
    Hello() {
        greeting_text = @"Hello, world!";
    }
    Hello(const char* initial_greeting_text) {
        greeting_text = [[NSString alloc] initWithUTF8String:initial_greeting_text];
    }
    void say_hello() {
        printf("%s\n", [greeting_text UTF8String]);
    }
};

//class-continuation分類
@interface clsExam()<NSCopying>{
    int otherName;
}

@end

@implementation clsExam

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.youName=@"";
        self.myName=@"";
        Hello *hello = new Hello("Bonjour, monde!");
        hello->say_hello();
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
