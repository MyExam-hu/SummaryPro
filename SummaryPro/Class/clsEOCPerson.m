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

@implementation clsEOCPerson{
    NSMutableSet *_internalFriends;
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

@end
