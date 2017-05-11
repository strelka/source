//
//  MainTabBarController.m
//  MFBankomats
//
//  Created by Jullia Sharaeva on 10.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "MFBTabBarController.h"
#import "MFBMapController.h"
#import "MFBTableViewController.h"


@interface MFBTabBarController ()
@end

@implementation MFBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MFBMapController *mapController = [[MFBMapController alloc] init];
    MFBTableViewController *poiList = [[MFBTableViewController alloc] init];
    
    NSMutableArray *tabViewControllers = [[NSMutableArray alloc] init];
    [tabViewControllers addObject:mapController];
    [tabViewControllers addObject:poiList];
        
    [self setViewControllers:tabViewControllers];
        //can't set this until after its added to the tab bar
    
    mapController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemTopRated tag:1];
    poiList.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore tag:2];
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
