//
//  AppDelegate.m
//  customCell
//
//  Created by Jullia Sharaeva on 14.04.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    ViewController* vc = [ViewController new];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    
    
    return YES;
}

@end
