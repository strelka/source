//
//  FirstViewController.m
//  ShowFlicrImage
//
//  Created by Jullia Sharaeva on 27.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (instancetype) init{
    self = [super init];
    if (self){
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Лента"
                                                        image:[[UIImage imageNamed:@"icFeed"] imageWithRenderingMode:UIImageRenderingModeAutomatic]
                                                selectedImage:[[UIImage imageNamed:@"icFeed"] imageWithRenderingMode:UIImageRenderingModeAutomatic]];
                           
    
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
