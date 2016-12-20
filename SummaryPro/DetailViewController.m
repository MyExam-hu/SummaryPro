//
//  DetailViewController.m
//  SummaryPro
//
//  Created by huweidong on 12/12/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "DetailViewController.h"
#import "clsDogName.h"

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
    NSLog(@"index=%lu",(unsigned long)index);
//    [self loadBarrier];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        sleep(2);
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
