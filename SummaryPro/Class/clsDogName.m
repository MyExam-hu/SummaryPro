//
//  clsDogName.m
//  SummaryPro
//
//  Created by huweidong on 7/12/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "clsDogName.h"

@implementation clsDogName

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setDogNameStr:@"大黄"];
        [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(changeName)userInfo:nil repeats:NO];
    }
    return self;
}

-(void)changeName{
    [self setDogNameStr:@"小花"];
}

+(BOOL)automaticallyNotifiesObserversForKey:(NSString *)key{
    if ([key isEqualToString:@"dogNameStr"]) {
        return YES;
    }
    return [super automaticallyNotifiesObserversForKey:key];
}

@end
