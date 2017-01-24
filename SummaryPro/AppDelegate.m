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
    
    NSArray * arr = [NSArray arrayWithObjects:@10,@50,@9, nil];
    NSInteger max = [[arr valueForKeyPath:@"@max.intValue"] integerValue];
    NSLog(@"%ld",(long)max);
    
    return YES;
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
