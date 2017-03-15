//
//  UILabel+CustomFontLabel.m
//  SummaryPro
//
//  Created by huweidong on 14/3/2017.
//  Copyright © 2017年 huweidong. All rights reserved.
//

#import "UILabel+CustomFontLabel.h"
#import <objc/runtime.h>

static NSString *customFontName=@"ProximaNova-Light";//Copperplate-Bold

@implementation UILabel (CustomFontLabel)

+ (void)load {
    static dispatch_once_t t;
    dispatch_once(&t, ^{
        Class class = [self class];
        // When swizzling a class method, use the following:
        //替换字体的set方法
        Method originalMethod=class_getInstanceMethod(class, @selector(setFont:));
        Method swappedMethod=class_getInstanceMethod(class, @selector(setCustomFont:));
        method_exchangeImplementations(originalMethod, swappedMethod);
        //替换三个初始化方法
        SEL selector_init = @selector(init);
        SEL selector_initWithFrame = @selector(initWithFrame:);
        SEL selector_awakeFromeNib = @selector(awakeFromNib);
        
        SEL selector_lfinit = @selector(LFinit);
        SEL selector_lfinitWithFrame = @selector(LFinitWithFrame:);
        SEL selector_lfawakeFromeNib = @selector(LFawakeFromNib);
        
        Method method_init = class_getInstanceMethod(class, selector_init);
        Method method_initWithFrame = class_getInstanceMethod(class, selector_initWithFrame);
        Method method_awakeFromeNib = class_getInstanceMethod(class, selector_awakeFromeNib);
        
        Method method_lfinit = class_getInstanceMethod(class, selector_lfinit);
        Method method_lfinitWithFrame = class_getInstanceMethod(class, selector_lfinitWithFrame);
        Method method_lfawakeFromeNib = class_getInstanceMethod(class, selector_lfawakeFromeNib);
        
        
        BOOL didAddMethod_init = class_addMethod(class, selector_init, method_getImplementation(method_lfinit), method_getTypeEncoding(method_lfinit));
        BOOL didAddMethod_initWithFrame = class_addMethod(class, selector_initWithFrame, method_getImplementation(method_lfinitWithFrame), method_getTypeEncoding(method_lfinitWithFrame));
        BOOL didAddMethod_awakeFromeNib = class_addMethod(class, selector_awakeFromeNib, method_getImplementation(method_lfawakeFromeNib), method_getTypeEncoding(method_lfawakeFromeNib));
        
        if (didAddMethod_init) {
            class_replaceMethod(class, selector_lfinit, method_getImplementation(method_init), method_getTypeEncoding(method_init));
        }else{
            method_exchangeImplementations(method_init, method_lfinit);
        }
        
        if (didAddMethod_initWithFrame) {
            class_replaceMethod(class, selector_lfinitWithFrame, method_getImplementation(method_initWithFrame), method_getTypeEncoding(method_initWithFrame));
        }else{
            method_exchangeImplementations(method_initWithFrame, method_lfinitWithFrame);
        }
        
        if (didAddMethod_awakeFromeNib) {
            class_replaceMethod(class, selector_lfawakeFromeNib, method_getImplementation(method_awakeFromeNib), method_getTypeEncoding(method_awakeFromeNib));
        }else{
            method_exchangeImplementations(method_awakeFromeNib, method_lfawakeFromeNib);
        }
    });
    
}
#pragma mark - 在以下方法中更换字体
- (instancetype)LFinit {
    id _self = [self LFinit];
    UIFont *font = [UIFont fontWithName:customFontName size:self.font.pointSize];
    if (font) {
        self.font = font;
    }
    return _self;
    
}
- (instancetype)LFinitWithFrame:(CGRect)frame {
    id _self = [self LFinitWithFrame:frame];
    UIFont *font = [UIFont fontWithName:customFontName size:self.font.pointSize];
    if (font) {
        self.font = font;
    }
    return _self;
}

- (void)LFawakeFromNib {
    [self LFawakeFromNib];
    UIFont *font = [UIFont fontWithName:customFontName size:self.font.pointSize];
    if (font) {
        self.font = font;
    }
}

- (void)setCustomFont:(UIFont *)font {
    if (font) {
        CGFloat fontSize = self.font.pointSize;
        [self setCustomFont:[UIFont fontWithName:customFontName size:fontSize]];
    }
}

@end
