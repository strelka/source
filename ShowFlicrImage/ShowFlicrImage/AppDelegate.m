//
//  AppDelegate.m
//  ShowFlicrImage
//
//  Created by Jullia Sharaeva on 27.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "AppDelegate.h"
#import "SPFViewController.h"
#import "SecondViewController.h"
#import "SPFDetailViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    UITabBarController *tab = [[UITabBarController alloc] init];
    
    //SPFDetailViewController *fc = [SPFDetailViewController new];
    
    SPFViewController *fc = [SPFViewController new];

    
    UINavigationController *nav = [UINavigationController new];
    //rgba 250 250 250, 0.9
    nav.view.backgroundColor = [[UIColor alloc] initWithRed:250.0f/255.0f green:250.0f/255.0f blue:250.0f/255.0f alpha:0.9];
    fc.view.backgroundColor = [[UIColor alloc] initWithRed:250.0f/255.0f green:250.0f/255.0f blue:250.0f/255.0f alpha:0.9];
    
    nav.viewControllers = @[fc];
    SecondViewController *sc = [SecondViewController new];
    sc.view.backgroundColor = [[UIColor alloc] initWithRed:250.0f/255.0f green:250.0f/255.0f blue:250.0f/255.0f alpha:0.9];
    tab.viewControllers = @[nav, sc];
    
    tab.tabBar.backgroundColor = [UIColor greenColor];
 
    window.rootViewController = tab;
    self.window = window;
    [window makeKeyAndVisible];
    // Override point for customization after application launch.
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


@end
