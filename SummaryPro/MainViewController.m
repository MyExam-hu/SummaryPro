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
//#import "NSString+EOCMyAdditions.h"
#import <objc/runtime.h>
#import "clsWebServices.h"

/*
 oc是可以调用swift的设置方法如下
 　　1、确保将框架 target 的 Build Settings > Packaging > Defines Module 设置为 Yes
 　　2、再修改在 build setting 中的 Product Module Name 即可。
 　　之后的项目会自动生成swift的头文件头文件名称为Product Module Name-Swift.h
 　　所有的swift都会在这个头文件里
 */
#import <SummaryPro-Swift.h>

static void *EOCMYAlertViewKey=@"EOCMYAlertViewKey";

typedef void(^SportSelectCallBack)(NSString *str,NSString *name);

@interface MainViewController ()<clsWebServiceDelegate>

@property (nonatomic, readwrite, copy) NSString *myName;
@property (weak, nonatomic) IBOutlet FEPlaceHolderTextView *myTextView;

@property (strong, nonatomic) clsWebServices *webService;

@property (nonatomic, copy) SportSelectCallBack complite;

@end

@implementation MainViewController

-(void)setMyName:(NSString *)myName{
    _myName=myName;
    NSLog(@"23333");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.myTextView.placeholder=@"點擊進行描述備註";
    self.myTextView.placeholderColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    self.myTextView.textContainerInset = UIEdgeInsetsMake(18, 10, 0, 0);
    
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
    NSLog(@"cls2=%@",cls2);
    
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
    
    clsExam *oclExam=[[clsExam alloc] init];
    oclExam.youName=@"4444";
    clsExam *copyExam=[oclExam copy];
    copyExam.youName=@"5555";
    NSLog(@"%@",oclExam.youName);
    
    self.webService=[[clsWebServices alloc] init];
    self.webService.delegate=self;
    
    [self.webService forgetPassword:@"142145645@qq.com"];
    
    self.complite=^(NSString *str,NSString *name){};
    
    __weak __typeof(&*self)weakSelf = self;
    NSArray *array=@[@0,@1,@2,@3,@4,@5];
    __block NSInteger count=0;
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSNumber *number=obj;
        if ([number compare:@2] == NSOrderedAscending) {
            count++;
        }
    }];
    NSLog(@"%ld", (long)count);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//如果UIViewController里面有此私有方法则会重写，所以应该加前缀_
-(void)_resetViewController{
    NSLog(@"4444444");
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

#pragma mark - clsWebServiceDelegate
- (void)WebService_Success:(int)pserviceType :(NSString *)result;{
    NSLog(@"%@", result);
}

- (void)WebService_Fail:(int)pserviceType{
}

@end
