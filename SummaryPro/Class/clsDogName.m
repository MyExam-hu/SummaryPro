//
//  clsDogName.m
//  SummaryPro
//
//  Created by huweidong on 7/12/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "clsDogName.h"
#import <MJExtension/MJExtension.h>

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

+(clsDogName *)deSerializeObj:(NSDictionary*)obj{
    clsDogName * user = [clsDogName mj_objectWithKeyValues:obj];
    return user;
}

+(NSMutableArray *)deSerializeList:(NSArray*)list{
    NSMutableArray * array=[NSMutableArray array];
    NSArray *tempList = [clsDogName mj_objectArrayWithKeyValuesArray:list];
    [array addObjectsFromArray:tempList];
    return array;
}

-(void)changeName{
    [self setDogNameStr:@"小李"];
}

- (void)hello{
    NSLog(@"hello 2333");
}

+(BOOL)automaticallyNotifiesObserversForKey:(NSString *)key{
    //自动通知
    if ([key isEqualToString:@"dogNameStr"]) {
        return YES;
    }
    //手动通知
    if ([key isEqualToString:@"masterName"]) {
        return NO;
    }
    return [super automaticallyNotifiesObserversForKey:key];
}

-(void)setMasterName:(NSString *)pmasterName{
    //设置手动通知
    [self willChangeValueForKey:@"masterName"];
    @synchronized(self) {
        _masterName=pmasterName;
    }
    [self didChangeValueForKey:@"masterName"];
}

@end
