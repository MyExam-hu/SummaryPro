//
//  UILabel+CustomFontLabel.m
//  SummaryPro
//
//  Created by huweidong on 14/3/2017.
//  Copyright © 2017年 huweidong. All rights reserved.
//

#import "UILabel+CustomFontLabel.h"
#import <objc/runtime.h>

@implementation UILabel (CustomFontLabel)

- (instancetype)init
{
    self = [super init];
    if (self) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            Method originalMethod=class_getInstanceMethod([UILabel class], @selector(setFont:));
            Method swappedMethod=class_getInstanceMethod([UILabel class], @selector(setCustomFont:));
            method_exchangeImplementations(originalMethod, swappedMethod);
        });
    }
    return self;
}

-(void)setCustomFont:(UIFont *)font{
    NSLog(@"font=%@",font.fontName);
    [self setCustomFont:[UIFont fontWithName:@"Zapfino" size:9]];
}

@end
