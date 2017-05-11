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
#import "poiAtmList.h"
#import "MFBAnnotation.h"

@interface MFBTabBarController ()<UITabBarControllerDelegate>
@property (nonatomic, strong) poiAtmList* poi;
@property (nonatomic, strong) MFBAnnotation* selectedPoi;
@end

@implementation MFBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    self.poi = [poiAtmList new];
    self.selectedPoi = [MFBAnnotation new];
    
    MFBMapController *mapController = [[MFBMapController alloc] init];
    MFBTableViewController *tableController = [[MFBTableViewController alloc] init];
    
    UINavigationController *nav = [UINavigationController new];
    nav.viewControllers = @[mapController];
    
    NSMutableArray *tabViewControllers = [[NSMutableArray alloc] init];
    
    [tabViewControllers addObject:nav];
    [tabViewControllers addObject:tableController];
    
    [self setViewControllers:tabViewControllers];
        //can't set this until after its added to the tab bar
    
    
    mapController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemTopRated tag:1];
    mapController.poiList = _poi;
    mapController.selectedPoi = _selectedPoi;
    tableController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore tag:2];
    tableController.poiList = _poi;
    tableController.selectedPoi = _selectedPoi;
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0)
{
    NSLog(@"%@", _selectedPoi.title);
    return YES;
}
@end
