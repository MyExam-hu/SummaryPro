//
//  SecondViewController.m
//  demo
//
//  Created by LUOHao on 16/3/1.
//  Copyright © 2016年 mobiletrain. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webViw;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets=NO;
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    NSString *htmlCode = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [_webViw loadHTMLString:htmlCode baseURL:nil];
    _webViw.delegate = self;
    
//    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [self.webViw loadRequest:request];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSLog(@"%@", title);
    NSString *urlStr = [webView stringByEvaluatingJavaScriptFromString:@"location.href"];
    NSLog(@"%@", urlStr);
    
    
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    [context setExceptionHandler:^(JSContext *ctx, JSValue *value) {
        NSLog(@"error: %@", value);
    }];
    
    context[@"callBackObj"] = self;
    NSString *code =
                   @"var btn = document.getElementById('backButton');"
                    "btn.removeEventListener('click', cb);"
                    "btn.addEventListener('click', function() {"
                    "   callBackObj.letsGoBack();"
                    "});";
    [context evaluateScript:code];
}

- (void) letsGoBack {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
