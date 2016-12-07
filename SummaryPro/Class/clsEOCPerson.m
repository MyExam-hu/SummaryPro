//
//  clsEOCPerson.m
//  SummaryPro
//
//  Created by huweidong on 11/11/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "clsEOCPerson.h"

@interface clsEOCPerson()

@property (nonatomic, copy, readwrite) NSString *firstName;
@property (nonatomic, copy, readwrite) NSString *lastName;

@end

static NSMutableArray *kSomeObjects;

@implementation clsEOCPerson{
    NSMutableSet *_internalFriends;
}

+(id)sharedInstans{
    static clsEOCPerson *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance=[[clsEOCPerson alloc] init];
    });
    return shareInstance;
}

+(void)load{
    //系统运行时会调用一次,主要用于调试,实际不可使用,会阻塞主进程
//    sleep(2);
}

+(void)initialize{
    //懒加载,用到时候才调用,NSMutableArray无法初始化所以可以在这里初始化
    kSomeObjects=[NSMutableArray new];
}

-(NSSet *)friends{
    return [_internalFriends copy];
}

-(void)addFriend :(clsEOCPerson*)person{
    [_internalFriends addObject:person];
}

-(void)removeFriend :(clsEOCPerson*)person{
    [_internalFriends removeObject:person];
}

-(id)initWithFirstName :(NSString*)firstName andLastName:(NSString*)lastName{
    if (self=[super init]) {
        _firstName=firstName;
        _lastName=lastName;
        _internalFriends=[NSMutableSet new];
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone{
    clsEOCPerson *copy=[[[self class] allocWithZone:zone] initWithFirstName:_firstName andLastName:_lastName];
    copy->_internalFriends=[_internalFriends mutableCopy];
    return copy;
}

//深拷贝
-(id)deepCopy{
    clsEOCPerson *copy=[[[self class] alloc] initWithFirstName:_firstName andLastName:_lastName];
    copy->_internalFriends=[[NSMutableSet alloc] initWithSet:_internalFriends copyItems:YES];
    return copy;
}

@end
