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

#import "MFBMapTableController.h"

#import "poiAtmList.h"
#import "MFBAnnotation.h"

@interface MFBTabBarController ()<UITabBarControllerDelegate>
@property (nonatomic, strong) MFBMapTableController *mapTableDelegate;
@property (nonatomic, strong) UINavigationController *navController;
@end

@implementation MFBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _navController = [UINavigationController new];
    
    self.delegate = self;
    _mapTableDelegate = [[MFBMapTableController alloc] initWithNavigationController:_navController];
    
//    _poiList = [NSArray new];
//    self.selectedPoi = [MFBAnnotation new];
    
    MFBMapController *mapController = [[MFBMapController alloc] initWithDelegate:_mapTableDelegate];
    MFBTableViewController *tableController = [[MFBTableViewController alloc] initWithDelegate:_mapTableDelegate];
    
    _navController.viewControllers = @[mapController];
    
    [self setViewControllers:@[_navController, tableController]];
    
    mapController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Карта"
                                                    image:[[UIImage imageNamed:@"map"] imageWithRenderingMode:UIImageRenderingModeAutomatic]
                                            selectedImage:[[UIImage imageNamed:@"map"] imageWithRenderingMode: UIImageRenderingModeAutomatic]];
//    mapController.tabBarItem.tag = 1;
//    
//    mapController.poiList = _poiList;
//    mapController.selectedPoi = _selectedPoi;
//    
    //tableController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore tag:2];
    tableController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Список"
                                                             image:[[UIImage imageNamed:@"atm"] imageWithRenderingMode:UIImageRenderingModeAutomatic]
                                                     selectedImage:[[UIImage imageNamed:@"atm"] imageWithRenderingMode: UIImageRenderingModeAutomatic]];
    tableController.tabBarItem.tag = 2;
    
    
//    tableController.poiList = _poiList;
//    tableController.selectedPoi = _selectedPoi;
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0)
{
    //NSLog(@"%@", _selectedPoi.title);
    return YES;
}
@end
