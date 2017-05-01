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


@implementation CBViewController


- (void)viewDidLoad {
    [super viewDidLoad];

   // CBContactsTableViewController *tableViewController = [[CBContactsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    VkLoginViewController *vkc = [[VkLoginViewController alloc] init];
    //[self.navigationController pushViewController:vkc animated:YES];
    self.viewControllers = @[vkc];
    
    NSLog(@"rrrty");
    NSLog(@"ddd");
    //self.contactManager = [CBVkContactsService new];
    //CBContactsList* clist = [self.contactManager getContacts];
    
    
    //CBContactsTableViewController *tbl = [[CBContactsTableViewController alloc] initWithStyle:UITableViewStylePlain andContacts:clist];
    
    
}



@end
