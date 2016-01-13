//
//  AppDelegate.m
//  LPHTuanChe
//
//  Created by 千锋 on 15/12/31.
//  Copyright (c) 2015年 李鹏辉. All rights reserved.
//

#import "AppDelegate.h"
#import "LPHOneViewController.h"
#import "LPHTwoViewController.h"
#import "LPHThreeViewController.h"
#import "LPHFouthViewController.h"
#import "LPHFiveViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor blackColor];
    [_window makeKeyAndVisible];
    [self createUITabBarController];
    
    [self UITabBarItem];
    return YES;
}
-(void)createUITabBarController
{
    LPHOneViewController *one = [[LPHOneViewController alloc]init];
    LPHTwoViewController *two = [[LPHTwoViewController alloc]init];
    LPHThreeViewController *three = [[LPHThreeViewController alloc]init];
    
    LPHFouthViewController *four = [[LPHFouthViewController alloc]init];
    LPHFiveViewController *five = [[LPHFiveViewController alloc]init];
    NSArray *array = @[one,two,three,four,five];
    UITabBarController *tab = [[UITabBarController alloc]init];
    tab.viewControllers = array;
    self.window.rootViewController = tab;
}

-(void)UITabBarItem
{
    UITabBarController *tab = (id)self.window.rootViewController;
    LPHOneViewController *one = tab.viewControllers[0];
    one.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"action_icon1_nor"] selectedImage:[UIImage imageNamed:@"action_icon1_sel"]];
    LPHTwoViewController *two = tab.viewControllers[1];
    two.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"订单" image:[UIImage imageNamed:@"action_icon2_nor"] selectedImage:[UIImage imageNamed:@"action_icon2_sel"]];
    LPHThreeViewController *three = tab.viewControllers[2];
    three.tabBarItem = [[UITabBarItem alloc]initWithTitle:nil image:[UIImage imageNamed:@"action_icon5_sel"] selectedImage:[UIImage imageNamed:nil]];
    LPHFouthViewController *four = tab.viewControllers[3];
    four.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"客服" image:[UIImage imageNamed:@"action_icon3_nor"] selectedImage:[UIImage imageNamed:@"action_icon3_sel"]];
    LPHFiveViewController *five = tab.viewControllers[4];
    five.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"action_icon4_nor"] selectedImage:[UIImage imageNamed:@"action_icon4_sel"]];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
