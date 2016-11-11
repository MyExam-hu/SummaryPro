//
//  EOCSoundPlayer.h
//  SummaryPro
//
//  Created by huweidong on 11/11/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EOCSoundPlayer;
@protocol EOCSoundPlayerDelegate <NSObject>

-(void)soundPlayerDelegate: (EOCSoundPlayer *)player;

@end

@interface EOCSoundPlayer : NSObject

@property (nonatomic, weak) id <EOCSoundPlayerDelegate> delegate;

-(id)initWithURL: (NSURL *)url;
-(void)playSound;

@end
