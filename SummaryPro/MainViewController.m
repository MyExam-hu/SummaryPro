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
#import "clsEOCPerson.h"
#import <Social/Social.h>
#import "clsDogName.h"
#import "DetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "UIImageView+ImageViewRadius.h"
//#import <objc/objc-runtime.h>

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
@property (nonatomic, copy) NSString *someString;
@property (weak, nonatomic) IBOutlet FEPlaceHolderTextView *myTextView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) clsWebServices *webService;
@property (nonatomic, copy) SportSelectCallBack complite;


@property (nonatomic, strong) dispatch_queue_t syscQueue;
@property (nonatomic, strong) dispatch_semaphore_t semaphore;

@property (nonatomic, strong) clsDogName *dogName;

@property (weak, nonatomic) IBOutlet UILabel *lbDogName;

@end

@implementation MainViewController

@synthesize someString = _someString;

-(void)setMyName:(NSString *)myName{
    _myName=myName;
    NSLog(@"23333");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.创建对象
//    clsDogName *msg = ((clsDogName * (*) (id, SEL)) objc_msgSend)((id)[clsDogName class], @selector(alloc));
    // 2.初始化对象
//    msg = ((clsDogName * (*) (id, SEL)) objc_msgSend)((id) msg, @selector(init));
    // 2.调用无参数无返回值方法
//    ((void *(*)(id, SEL))objc_msgSend)((id)msg, @selector(hello));
    // 3.调用带一个参数但无返回值的方法
//    ((void (*)(id, SEL, NSString *)) objc_msgSend)((id) msg, @selector(hasArguments:), @"调用带一个参数但无返回值的方法");
    // 4.调用带返回值，但是不带参数
//    NSString *retValue = ((NSString * (*) (id, SEL)) objc_msgSend)((id) msg,@selector(noArgumentsButReturnValue));
    // 5.带参数带返回值的消息
//    int returnValue = ((int (*)(id, SEL, NSString *, int)) objc_msgSend)((id) msg, @selector(hasArguments:andReturnValue:), @"参数1", 2016);
    
    // Do any additional setup after loading the view from its nib.
    NSMutableDictionary *myDic=[@{@"22":@"33"} mutableCopy];
//    NSMutableDictionary *otherDic=myDic;
    NSMutableDictionary *otherDic=[myDic mutableCopy];
    [otherDic setValue:@"33" forKey:@"44"];
    
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
//    [self valueForKey:@"loadingDispatch"];
//    [self loadingQueues];
    
//    [self loadingTraverse];
    
//    NSMutableArray *peopleList=[NSMutableArray new];
//    for (int i=0; i<10000; i++) {
//        //引用自动释放池降低内存峰值
//        @autoreleasepool {
//            clsEOCPerson *cls=[[clsEOCPerson alloc] init];
//            [peopleList addObject:cls];
//        }
//    }
    
//    clsEOCPerson *cls=[[clsEOCPerson alloc] init];
    self.dogName=[[clsDogName alloc] init];
    [self.dogName addObserver:self forKeyPath:@"dogNameStr" options:NSKeyValueObservingOptionNew context:nil];
    [self.dogName addObserver:self forKeyPath:@"masterName" options:NSKeyValueObservingOptionNew context:nil];
    self.lbDogName.text=[self.dogName valueForKey:@"dogNameStr"];
    
    NSArray *arrayList = @[@"name", @"w", @"aa", @"jimsa"];
    NSLog(@"%@", [arrayList valueForKeyPath:@"uppercaseString"]);
    
//    NSURL *url=[NSURL URLWithString:@"http://upload-images.jianshu.io/upload_images/2702646-426b7ad3b6d4e3ba.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"];
    //AF
//    [self.imageView setImageWithURL:url];
    //SDWebImage
//    [self.imageView  sd_setImageWithURL:url];
    [self.imageView hwd_loadImageUrlStr:@"http://upload-images.jianshu.io/upload_images/6526-1afe819836f5482d.png?imageView2/2/w/1240/q/100" placeHolderImageName:@"" radius:self.imageView.frame.size.width];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [self.dogName removeObserver:self forKeyPath:@"dogNameStr"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([object isKindOfClass:[clsDogName class]]) {
        if ([keyPath isEqualToString:@"dogNameStr"]) {
            self.lbDogName.text=[change objectForKey:NSKeyValueChangeNewKey];
        }
    }
}

-(void)task_first{
    //当信号总量少于0的时候就会一直等待，否则就可以正常的执行，并让信号总量-1
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"First task starting");
    sleep(1);
    NSLog(@"First task is done");
    //是发送一个信号，自然会让信号总量加1
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

-(void)loadingTraverse{
    NSArray *anArray=@[@1,@2,@3,@4];
//    NSEnumerator *enumerator=[anArray objectEnumerator];
    //反方向遍历
//    NSEnumerator *arrayEnumerator=[anArray reverseObjectEnumerator];
//    id object;
//    while ((object = [arrayEnumerator nextObject]) != nil) {
//        NSLog(@"%@",object);
//    }
    
//    for (id object in [anArray reverseObjectEnumerator]) {
//        NSLog(@"%@",object);
//    }
    
    //NSEnumerationConcurrent表示块里面的任务可以并发执行，NSEnumerationReverse反向遍历
    [anArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj);
    }];
    CFArrayRef aCFArray=(__bridge CFArrayRef)anArray;
    NSLog(@"Size of array =%li",CFArrayGetCount(aCFArray));
    
    NSDictionary *aDictionary=@{@"name":@"xiaohua",@"sex":@"men",@"height":@"180"};
//    NSEnumerator *dicEnumerator=[aDictionary keyEnumerator];
//    id key;
//    while ((key = [dicEnumerator nextObject]) != nil) {
//        id value=aDictionary[key];
//        NSLog(@"%@",value);
//    }
    
//    for (id key in aDictionary) {
//        id value=aDictionary[key];
//        NSLog(@"%@",value);
//    }
    
    [aDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@:%@",key,obj);
    }];
    
    NSSet *aSet=[[NSSet alloc] initWithArray:@[@1,@2,@3,@4]];
    NSEnumerator *setEnumerator=[aSet objectEnumerator];
    id setObject;
    while ((setObject = [setEnumerator nextObject]) != nil) {
        NSLog(@"%@",setObject);
    }
    
    //数组里面的每个对象都执行一遍length方法，然后返回执行length方法后的对象
    NSArray *strList=@[@"22",@"33",@"5555555"];
    NSLog(@"%@",[strList valueForKey:@"length"]);
    //KVO
    [self setValue:@"aaaaa" forKey:@"someString"];
    NSLog(@"%@",self.someString);
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
//并行队列  队列里面的东西运行时串行的   队列之间是并行运行的
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
    
    
    
    //死锁案例一(http://ios.jobbole.com/82622/) 控制台输出：1
//    NSLog(@"1"); // 任务1
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"2"); // 任务2
//    });
//    NSLog(@"3"); // 任务3
    
    //阻塞 控制台输出：1 2 3
//    NSLog(@"1"); // 任务1
//    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        NSLog(@"2"); // 任务2
//    });
//    NSLog(@"3"); // 任务3
    
    //死锁案例二 控制台输出：1 5 2 ,5和2的顺序不一定
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
    
    //死锁案例三  控制台输出：1 4 ,1和4的顺序不一定
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
    
    //不要使用获取当前线程dispatch_get_current_queue()
    
//    dispatch_sync(dispatch_queue_create("com.zxd.hwd", DISPATCH_QUEUE_CONCURRENT), ^{
//        NSLog(@"1");
//        sleep(1);
//        NSLog(@"3");
//    });
//    NSLog(@"2");
    
//    __weak __typeof__(self) weakSelf = self;
//    NSLock *lock=[[NSLock alloc] init];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        //防止self提前释放
//        __typeof__(self) strongSelf = weakSelf;
//        [lock lock];
//        [strongSelf printfLog :@"2333"];
//        sleep(10);
//        [lock unlock];
//    });
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        sleep(1);
//        [lock lock];
//        [weakSelf printfLog :@"555555"];
//        [lock unlock];
//    });
    
}

//如果UIViewController里面有此私有方法则会重写，所以应该加前缀_,前缀_为苹果官方使用的前缀,尽量不要这样做
-(void)_resetViewController{
    NSLog(@"4444444");
}

-(void)printfLog :(NSString *)str{
    NSLog(@"%@",str);
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

- (IBAction)shareClick:(id)sender {
    // 1.判断平台是否可用
    if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
        NSLog(@"查看您是否设置了新浪微博帐号,设置界面-->新浪微博-->配置帐号");
    }
    // 2.创建SLComposeViewController
    SLComposeViewController *composeVc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
    
    // 2.1.添加分享文字
    [composeVc setInitialText:@"做咸鱼如果没有梦想,跟有人什么区别"];
    
    // 2.2.添加分享图片
    [composeVc addImage:[UIImage imageNamed:@"xingxing"]];
    
    // 3.弹出分享界面
    [self presentViewController:composeVc animated:YES completion:nil];
    
    
    // 4.设置block属性
    composeVc.completionHandler = ^ (SLComposeViewControllerResult result) {
        if (result == SLComposeViewControllerResultCancelled) {
            NSLog(@"用户点击了取消");
        } else {
            NSLog(@"用户点击了发送");
        }
    };
    self.dogName.masterName=@"2233";
}

- (IBAction)goClick:(UIButton *)sender {
    DetailViewController *vc=[[DetailViewController alloc] init];
    vc.ocl=self.dogName;
    [self.navigationController pushViewController:vc animated:YES];
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
