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

+ (void)load {
    Method originalMethod=class_getInstanceMethod([UILabel class], @selector(setFont:));
    Method swappedMethod=class_getInstanceMethod([UILabel class], @selector(setCustomFont:));
    method_exchangeImplementations(originalMethod, swappedMethod);
}

-(void)setCustomFont:(UIFont *)font{
    NSLog(@"font=%@",font.fontName);
    CGFloat fontSize = self.font.pointSize;
    [self setCustomFont:[UIFont fontWithName:@"Zapfino" size:fontSize]];
}

@end
