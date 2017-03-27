//
//  SecondViewController.h
//  demo
//
//  Created by LUOHao on 16/3/1.
//  Copyright © 2016年 mobiletrain. All rights reserved.
//

#import "DetailViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@protocol MyProtocol <JSExport>

- (void) letsGoBack;

@end


@interface SecondViewController : DetailViewController <MyProtocol>


@end
