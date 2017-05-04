//
//  MainController.m
//  2017-04-25-contacts
//
//  Created by Jullia Sharaeva on 04.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "MainController.h"
#import "CBContactsTableViewController.h"
#import <Masonry/Masonry.h>

@interface MainController ()

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISegmentedControl *sc = [[UISegmentedControl alloc] initWithItems:@[@"vk", @"phone"]];
    UIView* toolbar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    [self.view addSubview:toolbar];
    
    [toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        
    }];
    
    toolbar.backgroundColor = [UIColor whiteColor];//
    
    [toolbar addSubview:sc];
    [sc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(toolbar.mas_left);
        make.right.equalTo(toolbar.mas_right);
        make.top.equalTo(toolbar.mas_top);
        make.bottom.equalTo(toolbar.mas_bottom).with.offset(-3);
    }];
    
    CBContactsTableViewController *ctv = [[CBContactsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    [self.view addSubview:ctv.tableView];
    
    [ctv.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(toolbar.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
