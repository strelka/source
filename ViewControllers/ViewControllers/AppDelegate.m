//
//  AppDelegate.m
//  ViewControllers
//
//  Created by Jullia Sharaeva on 12.04.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "MyNavController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UITabBarController *tabbar = [[UITabBarController alloc] init];
    
    
    ViewController1* firstVC = [ViewController1 new];
    ViewController2* secondVC = [ViewController2 new];
    MyNavController* thirdVC = [MyNavController new];
    
    UINavigationController* nav1 = [[UINavigationController alloc] initWithRootViewController:firstVC];
    
    UINavigationController* nav2 = [[UINavigationController alloc] initWithRootViewController:secondVC];
    UINavigationController* nav3 = [[UINavigationController alloc] initWithRootViewController:thirdVC];
    nav1.tabBarItem.title = @"TableView";
    nav2.tabBarItem.title = @"VC2";
    nav3.tabBarItem.title = @"VC3";
    
    
    NSArray* controllers = @[nav1, nav2, nav3];
    
    tabbar.viewControllers = controllers;
    self.window.rootViewController = tabbar;
    
    self.window.backgroundColor = [UIColor lightGrayColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
