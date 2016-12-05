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

@property (nonatomic, copy) NSString *someString;

@property (nonatomic, strong) dispatch_queue_t syscQueue;
@property (nonatomic, strong) dispatch_semaphore_t semaphore;

@end



@implementation MainViewController

@synthesize someString = _someString;

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
    [self.webService forgetPassword:@"142145645@qq.com" :^(NSString *result) {
        NSLog(@"%@", result);
    } :^(NSError *error) {
        NSLog(@"%@", error.userInfo);
    }];
    
    [self.webService forgetPassword:@"142145645@qq.com" :^(NSData *result, NSError *error) {
        if (error) {
            //Handle failure
        }else{
            //Handle success
        }
    }];
    
    self.complite=^(NSString *str,NSString *name){};
    
    //块的语法结构 return_type (^block_name)(parameters)
    __weak __typeof(&*self)weakSelf = self;
    NSArray *array=@[@0,@1,@2,@3,@4,@5];
    __block NSInteger count=0;
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSNumber *number=obj;
        if ([number compare:@2] == NSOrderedAscending) {
            count++;
        }
        weakSelf.myName=@"echo";
    }];
    NSLog(@"%ld", (long)count);
    
    void (^block)();
    if (count==1) {
        block=[^{
            NSLog(@"Block A");
        } copy];
    }else{
        block=[^{
            NSLog(@"Block B");
        } copy];
    }
    
    self.syscQueue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.someString=@"2333";
    NSString *str=@"444";
    str=self.someString;
    NSLog(@"str=%@",str);
    
    [self loadingDispatch];
    [self loadingQueues];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)task_first{
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"First task starting");
    sleep(1);
    NSLog(@"First task is done");
    dispatch_semaphore_signal(self.semaphore);
}

-(void)task_second{
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"Second task starting");
    sleep(1);
    NSLog(@"Second task is done");
    dispatch_semaphore_signal(self.semaphore);
}

-(void)task_third{
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"Thrid task starting");
    sleep(1);
    NSLog(@"Thrid task is done");
    dispatch_semaphore_signal(self.semaphore);
}

-(void)downLoadTask1 :(dispatch_group_t)group :(dispatch_queue_t)queue{
    dispatch_group_async(group, queue, ^{
        sleep(3);
        NSLog(@"Task1 is done");
    });
}

-(void)downLoadTask2 :(dispatch_group_t)group :(dispatch_queue_t)queue{
    dispatch_group_async(group, queue, ^{
        sleep(3);
        NSLog(@"Task2 is done");
    });
}

-(void)downLoadTask3 :(dispatch_group_t)group :(dispatch_queue_t)queue{
    dispatch_group_async(group, queue, ^{
        sleep(3);
        NSLog(@"Task3 is done");
    });
}

-(void)loadingQueues{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^(){
        NSLog(@"执行第1次操作，线程：%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^(){
        NSLog(@"执行第2次操作，线程：%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^(){
        NSLog(@"执行第3次操作，线程：%@", [NSThread currentThread]);
    }];
    
    // 設置operation2依赖于operation1
    [operation2 addDependency:operation1];
    
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    [queue addOperation:operation3];
    //队列的最大并发操作数量，意思是队列中最多同时运行几条线程
    queue.maxConcurrentOperationCount=2;
    
    // 取消单个操作
//    [operation2 cancel];
    
    // 取消queue中所有的操作
//    [queue cancelAllOperations];
    
    // 会阻塞当前线程，等到某个operation执行完毕
//    [operation2 waitUntilFinished];
    // 阻塞当前线程，等待queue的所有操作执行完毕
//    [queue waitUntilAllOperationsAreFinished];
    
    // 暂停queue
//    [queue setSuspended:YES];
    
    // 继续queue
//    [queue setSuspended:NO];
}

-(void)loadingDispatch{
//并行队列
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        for (int i=0; i<5; i++) {
//            NSLog(@"并行First task %d",i);
//            sleep(1);
//        }
//    });
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        for (int j=0; j<5; j++) {
//            NSLog(@"并行Second task %d",j);
//            sleep(1);
//        }
//    });
//    NSLog(@"并行dispatch is over");

//串行队列
//    dispatch_queue_t serialQueue=dispatch_queue_create("com.zxd.hwd", DISPATCH_QUEUE_SERIAL);
//    dispatch_async(serialQueue, ^{
//        for (int i=0; i<5; i++) {
//            NSLog(@"串行First task %d",i);
//            sleep(1);
//        }
//    });
//
//    dispatch_async(serialQueue, ^{
//        for (int j=0; j<5; j++) {
//            NSLog(@"串行Second task %d",j);
//            sleep(1);
//        }
//    });
//    NSLog(@"串行dispatch is over");

//延迟一段时间把一项任务提交到队列中执行
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSLog(@"延迟");
//    });

//dispatch_apply
//功能：把一项任务提交到队列中多次执行，具体是并行执行还是串行执行由队列本身决定.注意，dispatch_apply不会立刻返回，在执行完毕后才会返回，是同步的调用。
//    NSArray *list=@[@"hello",@"hwd",@"hello world"];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        dispatch_apply(3, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
//            //相对主队列(主线程)是异步的，在global队列中是并行执行的
//            NSString *str=list[index];
//            NSLog(@"%lu",(unsigned long)str.length);
//        });
//        NSLog(@"Dispatch_after in global queue is over");
//    });
//    NSLog(@"Dispatch_after in main queue is over");
//
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        //保证在APP运行期间，block中的代码只执行一次的代碼
//    });

//创建group
//    dispatch_group_t hwdGroup=dispatch_group_create();
//    //全局队列，这个队列为并行队列
//    dispatch_queue_t globalQueueDefault=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    //创建一个用户队列，这个队列为串行队列
//    dispatch_queue_t userCreateQueue=dispatch_queue_create("com.test.helloHwc",DISPATCH_QUEUE_SERIAL);
//    [self downLoadTask1:hwdGroup :globalQueueDefault];
//    [self downLoadTask2:hwdGroup :userCreateQueue];
//    [self downLoadTask3:hwdGroup :userCreateQueue];
//
////    BOOL letresult=dispatch_group_wait(hwdGroup, DISPATCH_TIME_FOREVER);//等待直到完成
//
//    dispatch_group_notify(hwdGroup, dispatch_get_main_queue(), ^{
//        NSLog(@"Group tasks are done");
//    });
//    NSLog(@"Now viewDidLoad is done");
    
//创建一个信号量dispatch_semaphore_create
//提高信号量dispatch_semaphore_signal
//等待降低信号量dispatch_semaphore_wait
//    self.semaphore=dispatch_semaphore_create(1);
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self task_first];
//    });
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self task_second];
//    });
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self task_third];
//    });
    
    //死锁案例一(http://ios.jobbole.com/82622/)
//    NSLog(@"1"); // 任务1
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"2"); // 任务2
//    });
//    NSLog(@"3"); // 任务3
    
    //阻塞
//    NSLog(@"1"); // 任务1
//    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        NSLog(@"2"); // 任务2
//    });
//    NSLog(@"3"); // 任务3
    
    //死锁案例二
//    dispatch_queue_t queue = dispatch_queue_create("com.demo.serialQueue", DISPATCH_QUEUE_SERIAL);
//    NSLog(@"1"); // 任务1
    //把任务加入到队列queue最后面
//    dispatch_async(queue, ^{
//        NSLog(@"2"); // 任务2
//        dispatch_sync(queue, ^{
//            NSLog(@"3"); // 任务3
//        });
//        NSLog(@"4"); // 任务4
//    });
//    NSLog(@"5"); // 任务5
    
    //1最先执行；2和5顺序不一定；4一定在3后面
//    NSLog(@"1"); // 任务1
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"2"); // 任务2
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            NSLog(@"3"); // 任务3
//        });
//        NSLog(@"4"); // 任务4
//    });
//    NSLog(@"5"); // 任务5
    
    //死锁案例三
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"1"); // 任务1
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            NSLog(@"2"); // 任务2
//        });
//        NSLog(@"3"); // 任务3
//    });
//    NSLog(@"4"); // 任务4
//    while (1) {
//    }
//    NSLog(@"5"); // 任务5
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

-(NSString *)someString{
    __block NSString *localSomeString;
    dispatch_sync(self.syscQueue, ^{
        sleep(1);
        localSomeString=_someString;
    });
    return localSomeString;
}

-(void)setSomeString:(NSString *)psomeString{
//    dispatch_async(self.syscQueue, ^{
//        sleep(2);
//        _someString=psomeString;
//    });
    
    //栅栏块保证写入操作单独执行,在进程管理中起到一个栅栏的作用,它等待所有位于barrier函数之前的操作执行完毕后执行,并且在barrier函数执行之后,barrier函数之后的操作才会得到执行
    dispatch_barrier_async(self.syscQueue, ^{
        sleep(2);
        _someString=psomeString;
    });
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
