//
//  DetailViewController.m
//  SummaryPro
//
//  Created by huweidong on 12/12/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "DetailViewController.h"
#import "clsDogName.h"
#import <objc/runtime.h>

@interface DetailViewController ()

@property (readwrite, nonatomic, assign) NSInteger activityCount;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _activityCount++;
    _activityCount = MAX(_activityCount - 1, 0);
    
    //快速遍历查找某个下标，如果返回YES，则index为当前下标
    NSArray *list=@[@"22",@"33",@"2233"];
    NSUInteger index=[list indexOfObjectPassingTest:^BOOL(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return [obj isEqualToString:@"2233"];
    }];
    [self loadExam];
    NSLog(@"index=%lu",(unsigned long)index);
//    [self loadBarrier];
    [self runtimeLearn];
//    [self loadReadFile];
    
    //iOS 中，关于网络请求的接口自下至上有如下几层:
    //1、CFSocket
    //2、CFNetwork       ->ASIHttpRequest
    //3、NSURLConnection ->AFNetworking
    //4、NSURLSession    ->AFNetworking2, Alamofire
    
    //用到scrollView时定时器创建方法
//        self.tempTimer = [NSTimer timerWithTimeInterval:timeoutValue target:self selector:@selector(timeout) userInfo:nil repeats:NO];
//        [[NSRunLoop mainRunLoop] addTimer:self.tempTimer forMode:NSRunLoopCommonModes];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)loadReadFile{
//    pipe_q = dispatch_queue_create("PipeQ", NULL);
//    pipe_channel = dispatch_io_create(DISPATCH_IO_STREAM, fd, pipe_q, ^(int err){
//        close(fd);
//    });
//    
//    *out_fd = fdpair[1];
//    
//    dispatch_io_set_low_water(pipe_channel, SIZE_MAX);
//    
//    dispatch_io_read(pipe_channel, 0, SIZE_MAX, pipe_q, ^(bool done, dispatch_data_t pipedata, int err){
//        if (err == 0)
//        {
//            size_t len = dispatch_data_get_size(pipedata);
//            if (len > 0)
//            {
//                const char *bytes = NULL;
//                char *encoded;
//                dispatch_data_t md = dispatch_data_create_map(pipedata, (const void **)&bytes, &len);
//                encoded = asl_core_encode_buffer(bytes, len);
//                asl_set((aslmsg)merged_msg, ASL_KEY_AUX_DATA, encoded);
//                free(encoded);
//                _asl_send_message(NULL, merged_msg, -1, NULL);
//                asl_msg_release(merged_msg);
//                dispatch_release(md);
//            }
//        }
//        
//        if (done)
//        {
//            dispatch_semaphore_signal(sem);
//            dispatch_release(pipe_channel);
//            dispatch_release(pipe_q);
//        }
//    });
//}

-(void)loadExam{
    dispatch_queue_t queue=dispatch_queue_create("thread1", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        NSLog(@"55555555");
        return;
    });
    NSLog(@"66666666");
}

-(void)loadBarrier{
    dispatch_queue_t queue=dispatch_queue_create("thread", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"test1");
    });
    dispatch_async(queue, ^{
        NSLog(@"test2");
    });
    dispatch_async(queue, ^{
        NSLog(@"test3");
    });
    //相当于阻塞线程,要前面的任务执行完后才会执行后面的任务
    //栅栏
    dispatch_barrier_sync(queue, ^{
        for (int i=0; i<=500000000; i++) {
            if (5000==i) {
                NSLog(@"point1");
            }else if (6000==i){
                NSLog(@"point2");
            }else if (7000==i){
                NSLog(@"point3");
            }
        }
    });
    
    NSLog(@"aaa");
    dispatch_async(queue, ^{
        NSLog(@"test4");
    });
    NSLog(@"bbb");
    dispatch_async(queue, ^{
        NSLog(@"test5");
    });
    dispatch_async(queue, ^{
        NSLog(@"test6");
    });
    
    //tableview切换动画
//    CATransition *animation = [CATransition animation];
//    animation.duration = 0.3;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    animation.type = kCATransitionPush;
//    if (sender.tag==self.btnTrending.tag) {
//        self.btnTrending.selected=YES;
//        self.btnNearBy.selected=NO;
//        animation.subtype = kCATransitionFromRight;
//    }else{
//        self.btnTrending.selected=NO;
//        self.btnNearBy.selected=YES;
//        animation.subtype = kCATransitionFromLeft;
//    }
//    [self.homeTableView.layer addAnimation:animation forKey:@"Animation"];
//    [self.homeTableView setContentOffset:CGPointZero animated:NO];
}

-(void)runtimeLearn{
    unsigned int count;
    //获取属性列表
    objc_property_t *propertyList = class_copyPropertyList([clsDogName class], &count);
    for (unsigned int i=0; i<count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSLog(@"property---->%@", [NSString stringWithUTF8String:propertyName]);
    }
    
    //获取方法列表
    Method *methodList = class_copyMethodList([clsDogName class], &count);
    for (unsigned int i; i<count; i++) {
        Method method = methodList[i];
        NSLog(@"method---->%@", NSStringFromSelector(method_getName(method)));
    }
    
    //获取成员变量列表
    Ivar *ivarList = class_copyIvarList([clsDogName class], &count);
    for (unsigned int i; i<count; i++) {
        Ivar myIvar = ivarList[i];
        const char *ivarName = ivar_getName(myIvar);
        NSLog(@"Ivar---->%@", [NSString stringWithUTF8String:ivarName]);
    }
    
    //获取协议列表
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([clsDogName class], &count);
    for (unsigned int i; i<count; i++) {
        Protocol *myProtocal = protocolList[i];
        const char *protocolName = protocol_getName(myProtocal);
        NSLog(@"protocol---->%@", [NSString stringWithUTF8String:protocolName]);
    }
}

- (IBAction)saveClick:(UIButton *)sender {
//    [self.ocl setDogNameStr:@"blue"];
    self.ocl.dogNameStr=@"blue";
    [self.navigationController popViewControllerAnimated:YES];
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
