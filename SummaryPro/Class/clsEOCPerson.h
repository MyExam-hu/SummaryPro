//
//  clsEOCPerson.h
//  SummaryPro
//
//  Created by huweidong on 11/11/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface clsEOCPerson : NSObject<NSCopying>

@property (nonatomic, copy, readonly) NSString *firstName;
@property (nonatomic, copy, readonly) NSString *lastName;
@property (nonatomic, strong, readonly) NSSet *friends;

//尽量使用不可变变量
-(id)initWithFirstName :(NSString*)firstName andLastName:(NSString*)lastName;
-(void)addFriend :(clsEOCPerson*)person;
-(void)removeFriend :(clsEOCPerson*)person;

@end
