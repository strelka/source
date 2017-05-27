//
//  SecondViewController.m
//  ShowFlicrImage
//
//  Created by Jullia Sharaeva on 27.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (instancetype) init{
    self = [super init];
    if (self){
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Избранное"
                                                        image:[[UIImage imageNamed:@"icLikes"] imageWithRenderingMode:UIImageRenderingModeAutomatic]
                                                selectedImage:[[UIImage imageNamed:@"icLikes"] imageWithRenderingMode:UIImageRenderingModeAutomatic]];
        
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
