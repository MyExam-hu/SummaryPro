//
//  MainViewController.m
//  SummaryPro
//
//  Created by huweidong on 11/11/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "MainViewController.h"
#import "clsExam.h"
#import "EOCAutoDictionary.h"
#import "NSString+EOCMyAdditions.h"
#import <objc/runtime.h>

static void *EOCMYAlertViewKey=@"EOCMYAlertViewKey";

@interface MainViewController ()

@property (nonatomic, readwrite, copy) NSString *myName;

@end

@implementation MainViewController

-(void)setMyName:(NSString *)myName{
    _myName=myName;
    NSLog(@"23333");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.myName=@"233333";
    //不会调用set方法，慎用
    //    _myName=@"233333";
    
    NSString *foo=@"2333";
    NSString *bar=[NSString stringWithFormat:@"233%@",@"3"];
    BOOL equalA=(foo == bar);
    BOOL equalB=[foo isEqualToString:bar];
    BOOL equalC=[foo isEqual:bar];
    NSLog(@"equalA=%d,equalB=%d,equalC=%d",equalA,equalB,equalC);
    
    clsExam *cls1=[[clsExam alloc] init];
    cls1.youName=@"233";
    clsExam *cls2=[[clsExam alloc] init];
    cls2.youName=@"233";
    NSLog(@"%d",[cls1 isEqual:cls2]);
    
    NSMutableSet *set=[NSMutableSet new];
    NSMutableArray *arrayA=[@[@1,@2] mutableCopy];
    [set addObject:arrayA];
    NSLog(@"set=%@",set);
    
    NSMutableArray *arrayB=[@[@1,@2] mutableCopy];
    [set addObject:arrayB];
    NSLog(@"set=%@",set);
    
    NSMutableArray *arrayC=[@[@1] mutableCopy];
    //    [set addObject:[arrayC copy]];
    [set addObject:arrayC];
    NSLog(@"set=%@",set);
    
    [arrayC addObject:@2];
    NSLog(@"set=%@",set);
    
    NSSet *setB=[set copy];
    NSLog(@"setB=%@",setB);
    
    //关联对象的使用,慎用,需要注意循环引用环
    [self loadAlertView];
    
    //用C写实现OC的Get方法和Set方法
    EOCAutoDictionary *dict=[EOCAutoDictionary new];
    dict.date=[NSDate dateWithTimeIntervalSince1970:475372800];
    NSLog(@"dict.date=%@",dict.date);
    
    //替换两个方法的实现达到输出测试结果的目的(作用范围,整个运行期)
//    Method originalMethod=class_getInstanceMethod([NSString class], @selector(lowercaseString));
//    Method swappedMethod=class_getInstanceMethod([NSString class], @selector(eoc_myLowercaseString));
//    method_exchangeImplementations(originalMethod, swappedMethod);
    
    NSString *string=@"TTTTHJKjhkjhk";
    [string lowercaseString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadAlertView{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Question" message:@"2333" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Submit", nil];
    void (^block)(NSInteger) = ^(NSInteger btnIndex){
        if (btnIndex==0) {
            NSLog(@"0000");
        }else{
            NSLog(@"other");
        }
    };
    objc_setAssociatedObject(alert, EOCMYAlertViewKey, block, OBJC_ASSOCIATION_COPY);
    [alert show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0){
    void (^block)(NSInteger)=objc_getAssociatedObject(alertView, EOCMYAlertViewKey);
    block(buttonIndex);
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
