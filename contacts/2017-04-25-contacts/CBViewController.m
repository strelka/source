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

#import <Masonry/Masonry.h>

@implementation CBViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view  setBackgroundColor:[UIColor lightGrayColor]];
    UISegmentedControl * sc= [[UISegmentedControl alloc] initWithItems:@[@"vk", @"phoneBook"]];
    
    self.navigationItem.titleView = sc;
    [self.view addSubview:sc];
    [sc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.navigationBar.mas_left);
        make.right.equalTo(self.navigationBar.mas_right);
        make.bottom.equalTo(self.navigationBar.mas_bottom);

    }];
    
    [sc setSelectedSegmentIndex:0];
    [sc addTarget:self action:@selector(segmentedControlHasChangedValue:)
             forControlEvents:UIControlEventValueChanged];
    
    // CBContactsTableViewController *tableViewController = [[CBContactsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    //VkLoginViewController *vkc = [[VkLoginViewController alloc] init];
    //[self.navigationController pushViewController:vkc animated:YES];
    //self.viewControllers = @[vkc];
    
    //self.contactManager = [CBVkContactsService new];
    //CBContactsList* clist = [self.contactManager getContacts];
    
    
    //CBContactsTableViewController *tbl = [[CBContactsTableViewController alloc] initWithStyle:UITableViewStylePlain andContacts:clist];
 }

-(IBAction)segmentedControlHasChangedValue:(UISegmentedControl*)sender{
    VkLoginViewController *vkc = [[VkLoginViewController alloc] init];
    self.viewControllers = @[vkc];
}



@end
