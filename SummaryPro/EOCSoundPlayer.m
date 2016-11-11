//
//  EOCSoundPlayer.m
//  SummaryPro
//
//  Created by huweidong on 11/11/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "EOCSoundPlayer.h"
#import <AudioToolbox/AudioToolbox.h>
//命名请加上项目前缀，或其他意义的前缀
void HWDCompletion(SystemSoundID ssID,void *clientData){
    EOCSoundPlayer *player=(__bridge EOCSoundPlayer *)(clientData);
    if ([player.delegate respondsToSelector:@selector(soundPlayerDelegate:)]) {
        [player.delegate soundPlayerDelegate:player];
    }
}

@implementation EOCSoundPlayer{
    SystemSoundID _systemSoundID;
}


-(id)initWithURL: (NSURL *)url{
    
    if (self = [super init]) {
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &_systemSoundID);
    }
    return self;
}

-(void)playSound{
    AudioServicesAddSystemSoundCompletion(_systemSoundID, NULL, NULL, HWDCompletion, (__bridge void * _Nullable)(self));
    AudioServicesPlaySystemSound(_systemSoundID);
}

-(void)dealloc{
    AudioServicesDisposeSystemSoundID(_systemSoundID);
}

@end
