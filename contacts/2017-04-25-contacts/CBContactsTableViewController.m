//
//  CBContactsTableViewController.m
//  2017-04-25-contacts
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "CBContactsTableViewController.h"
#import "CBContactsList.h"
#import "CBContactCell.h"
#import "CBFakeContactsService.h"
#import "CBVkContactsService.h"
#import "CBDescriptController.h"
#import "VkLoginViewController.h"

@interface CBContactsTableViewController ()

@property (nonatomic, strong) CBContactsList *contacts;

@end

@implementation CBContactsTableViewController

-(instancetype)initWithStyle:(UITableViewStyle*)style andContacts:(CBContactsList*) contacts{
    self = [super initWithStyle:*style];
    if (self){
        _contacts = contacts;
    }
    return self;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Contacts";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[CBContactCell class] forCellReuseIdentifier:CBContactCellIdentifier];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contacts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = (CBContactCell *)[tableView dequeueReusableCellWithIdentifier:CBContactCellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[CBContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CBContactCellIdentifier];
    }
    
    [(CBContactCell *)cell addContact:[self.contacts objectAtIndexedSubscript:indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CBContactCell heightForCell];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CBDescriptController *dc = [CBDescriptController new];
    dc.contact = [self.contacts objectAtIndexedSubscript:indexPath.row];
    
    [self.navigationController pushViewController:dc animated:YES];
    
}

@end
