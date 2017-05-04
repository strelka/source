//
//  CBViewController.m
//  2017-04-25-contacts
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "CBViewController.h"
#import "CBContactsTableViewController.h"
#import "VkLoginViewController.h"
#import "CBContactManager.h"
#import "CBVkContactsService.h"
#import "CBContactsList.h"

#import "MainController.h"
#import <Masonry/Masonry.h>

@implementation CBViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //self.viewControllers = @[ctv];
    
    //CBContactsTableViewController *tableViewController = [[CBContactsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    MainController *mc = [MainController new];
    [self.view addSubview:mc.view];
    
    [mc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationBar.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
    
    self.viewControllers = @[mc];
    
    //self.contactManager = [CBVkContactsService new];
    //CBContactsList* clist = [self.contactManager getContacts];
    
    
    //CBContactsTableViewController *tbl = [[CBContactsTableViewController alloc] initWithStyle:UITableViewStylePlain andContacts:clist];
 }




@end
