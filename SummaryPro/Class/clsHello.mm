//
//  clsHello.m
//  SummaryPro
//
//  Created by huweidong on 30/11/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "clsHello.h"

@implementation clsHello

@end

class Hello {
private:
    id greeting_text;  // holds an NSString
public:
    Hello() {
        greeting_text = @"Hello, world!";
    }
    Hello(const char* initial_greeting_text) {
        greeting_text = [[NSString alloc] initWithUTF8String:initial_greeting_text];
    }
    void say_hello() {
        printf("%s\n", [greeting_text UTF8String]);
    }
};

@interface Greeting : NSObject {
@private
    Hello *hello;
}
- (id)init;
- (void)dealloc;
- (void)sayGreeting;
- (void)sayGreeting:(Hello*)greeting;
@end
@implementation Greeting
- (id)init {
    if (self = [super init]) {
        hello = new Hello();
    }
    return self;
}
- (void)dealloc {
    delete hello;
//    [super dealloc];
}
- (void)sayGreeting {
    hello->say_hello();
}
- (void)sayGreeting:(Hello*)greeting {
    greeting->say_hello();
}
@end

//int main() {
////    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
//    
//    Greeting *greeting = [[Greeting alloc] init];
//    [greeting sayGreeting];                         // > Hello,  world!
//    
//    Hello *hello = new Hello("Bonjour, monde!");
//    [greeting sayGreeting:hello];                   // > Bonjour,  monde!
//    
//    delete hello;
////    [greeting release];
////    [pool release];
//    return 0;
//}
