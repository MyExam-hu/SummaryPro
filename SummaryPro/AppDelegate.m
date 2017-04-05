//
//  AppDelegate.m
//  SummaryPro
//
//  Created by huweidong on 11/11/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "AFNetworkActivityIndicatorManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    MainViewController *vc =[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    UINavigationController * nav=[[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBarHidden=YES;
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    //取消警告
    NSString *foo;
#pragma unused(foo)
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    //四舍五入
    NSLog(@"res: %.f", rintf(3.5)); //result 4
    NSLog(@"res: %.f", round(3.46)); //result 3
    NSLog(@"res: %.f", round(-3.5)); //NB: this one returns -4
    
    //将参数的整数部分通过指针回传, 返回小数部分
    double p;
    NSLog(@"%f,p=%f",modf(3.04, &p),p);
//    NSLog(@"%f,p=%f",p,modf(3.04, &p));
    
    [self loadValueForKeyPathDemo];
    [self loadPredicateTest];
    return YES;
}

-(void)loadValueForKeyPathDemo{
    NSArray * array = [NSArray arrayWithObjects:@0,@50,@9, nil];
    NSInteger max = [[array valueForKeyPath:@"@max.floatValue"] integerValue];
    NSLog(@"%ld",(long)max);
    
    //bug
//    NSArray *arr = @[@(0),@(10),@(40)];
//    NSInteger avg = [[arr valueForKeyPath:@"@avg.self"] integerValue];
//    NSLog(@"---%ld",avg);
    
    NSArray *arr = @[@0,@10,@40];
    CGFloat avg = [[arr valueForKeyPath:@"@avg.floatValue"] floatValue];
    NSLog(@"---%f",avg);
    
//    NSNumber *sum = [array valueForKeyPath:@"@sum.floatValue"];
//    NSNumber *avg = [array valueForKeyPath:@"@avg.floatValue"];
//    NSNumber *max = [array valueForKeyPath:@"@max.floatValue"];
//    NSNumber *min = [array valueForKeyPath:@"@min.floatValue"];
    
    //剔除重复数据
    NSArray *array1 = @[@"name", @"w", @"aa", @"jimsa", @"aa"];
    NSLog(@"%@", [array1 valueForKeyPath:@"@distinctUnionOfObjects.self"]);
    
    //同样可以嵌套使用，先剔除name对应值的重复数据再取值
    NSArray *array2 = @[@{@"name" : @"cookeee",@"code" : @1},
                       @{@"name": @"jim",@"code" : @2},
                       @{@"name": @"jim",@"code" : @1},
                       @{@"name": @"jbos",@"code" : @1}];
    
    NSLog(@"%@", [array2 valueForKeyPath:@"@distinctUnionOfObjects.name"]);
    
}

-(void)loadPredicateTest{
    //把DATETIME相同时间合并排序,然后再过滤掉2016-10-04号前的日期
    NSArray *list=@[@{@"DATETIME":@"2016-10-01"},
                             @{@"DATETIME":@"2016-10-06"},
                             @{@"DATETIME":@"2016-10-05"},
                             @{@"DATETIME":@"2016-10-04"},
                             @{@"DATETIME":@"2016-10-05"},
                             @{@"DATETIME":@"2016-10-03"},
                             @{@"DATETIME":@"2016-10-02"},
                             @{@"DATETIME":@"2016-10-02"}];
    
    //把日期过滤
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"DATETIME >= '2016-10-04'"];//创建谓词筛选器
    NSArray *filtrationList = [list filteredArrayUsingPredicate:predicate];
    //剔除重复数据
    filtrationList=[filtrationList valueForKeyPath:@"@distinctUnionOfObjects.DATETIME"];
    //排序
    NSArray *sortSetArray = [filtrationList sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:nil ascending:NO]]];
    NSLog(@"%@",sortSetArray);
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:5];
}

@end
