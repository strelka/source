//
//  TRNPageViewController.m
//  Trends
//
//  Created by Jullia Sharaeva on 16.06.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//
#import "TRNPagesManager.h"
#import "TRNPageViewController.h"

#import "TRNYouTubeController.h"
#import "TRNFlicrController.h"
#import "TRNTwitterController.h"


@interface TRNPageViewController ()<UIPageViewControllerDataSource>
@property (nonatomic, copy) NSArray *pages;
@property (nonatomic, strong) TRNPagesManager *manager;
@end

@implementation TRNPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIPageControl *pc = [UIPageControl appearance];
    pc.pageIndicatorTintColor = [UIColor lightGrayColor];
    pc.currentPageIndicatorTintColor = [UIColor blackColor];
    pc.backgroundColor = [UIColor whiteColor];

    self.dataSource = self;
    
    _manager = [TRNPagesManager new];
    [self createPages];
    _pages = [_manager pages];

    [self setViewControllers:@[_pages[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) createPages{
    if (_manager){
        TRNTwitterController *twc = [TRNTwitterController new];
        TRNYouTubeController *ytb = [TRNYouTubeController new];
        TRNFlicrController *fkc = [TRNFlicrController new];
    
        [_manager addPage:twc];
        [_manager addPage:ytb];
        [_manager addPage:fkc];
    }
}

- (UIViewController *) pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    id <TRNChildProtocol> vc = (id <TRNChildProtocol>)viewController;
    return (UIViewController*)[_manager getViewControllerBeforeViewControllerWithIndex:[vc pageIndex]];
}

- (UIViewController *) pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    id <TRNChildProtocol> vc = (id <TRNChildProtocol>)viewController;
    return (UIViewController*)[_manager getViewControllerAfterViewControllerWithIndex:[vc pageIndex]];
    
}


- (NSInteger) presentationCountForPageViewController:(UIPageViewController *)pageViewController{
    return [_pages count];
}
//
- (NSInteger) presentationIndexForPageViewController:(UIPageViewController *)pageViewController{
    return 0;
}
@end
