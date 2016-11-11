//
//  EOCAutoDictionary.m
//  OpenGLESDemo
//
//  Created by huweidong on 9/11/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "EOCAutoDictionary.h"
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface EOCAutoDictionary()

@property (nonatomic, strong) NSMutableDictionary *backingStore;

@end

@implementation EOCAutoDictionary

@dynamic string,number,date,opaqueObject;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backingStore=[NSMutableDictionary new];
    }
    return self;
}

//动态方法解析函数
+(BOOL)resolveInstanceMethod:(SEL)sel{
    NSString *selectorString=NSStringFromSelector(sel);
    if ([selectorString hasPrefix:@"set"]) {
        class_addMethod(self, sel, (IMP)autoDictionarySetter, "v@:@");
    }else{
        class_addMethod(self, sel, (IMP)autoDictionaryGetter, "@@:");
    }
    return YES;
}

id autoDictionaryGetter(id self,SEL _cmd){
    EOCAutoDictionary *typeSelf=(EOCAutoDictionary *)self;
    NSMutableDictionary *backingStore=typeSelf.backingStore;
    NSString *key=NSStringFromSelector(_cmd);
    return [backingStore objectForKey:key];
}

void autoDictionarySetter(id self,SEL _cmd,id value){
    EOCAutoDictionary *typeSelf=(EOCAutoDictionary *)self;
    NSMutableDictionary *backingStore=typeSelf.backingStore;
    
    NSString *selectorString=NSStringFromSelector(_cmd);
    NSMutableString *key=[selectorString mutableCopy];
    
    [key deleteCharactersInRange:NSMakeRange(key.length - 1, 1)];
    
    [key deleteCharactersInRange:NSMakeRange(0, 3)];
    
    NSString *lowercaseFirstChar=[[key substringToIndex:1] lowercaseString];
    [key replaceCharactersInRange:NSMakeRange(0, 1) withString:lowercaseFirstChar];
    if (value) {
        [backingStore setObject:value forKey:key];
    }else{
        [backingStore removeObjectForKey:key];
    }
}

@end
