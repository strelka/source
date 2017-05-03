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
#import "CBContact.h"

@interface CBContactsTableViewController ()

@property (nonatomic, strong) CBContactsList *contacts;
@property (nonatomic, strong) id<CBContactManager> contactManager;

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
    
    //self.contactManager = [CBVkContactsService new];
    //self.contacts = [self.contactManager getContacts];
    [self getContacts];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[CBContactCell class] forCellReuseIdentifier:CBContactCellIdentifier];
}

-(void) getContacts{
    
    CBVkContactsService *http = [[CBVkContactsService alloc] init];
    
    CBContact* (^createContact)(NSDictionary* jsonContact);
    createContact = ^CBContact*(NSDictionary* jsonContact){
        CBContact *contact = [CBContact new];
        contact.firstName = [jsonContact objectForKey:@"first_name"];
        contact.lastName = [jsonContact objectForKey:@"last_name"];
        contact.urlImage = [jsonContact objectForKey:@"photo_100"];
    return contact;
    };

    NSMutableArray *resultContacts = [NSMutableArray new];

    NSString* accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"VKAccessToken"];
    NSString* UserId = [[NSUserDefaults standardUserDefaults] objectForKey:@"VKAccessUserId"];
    NSString* url = [[NSString alloc] initWithFormat:@"https://api.vk.com/method/friends.get?user_id=%@&fields=nickname,contacts,photo_100,mobile_phone&%@",
                 UserId, accessToken];

    [http retrieveURL:[NSURL URLWithString:url] successBlock:^(NSData *response){
        NSError* jsonError;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:response
                                                             options:0
                                                               error: &jsonError];
        NSDictionary* contacts = [json objectForKey:@"response"];
        for (NSDictionary* contact in contacts){
            [resultContacts addObject:createContact(contact)];
        }
        self.contacts = [[CBContactsList alloc] initWithArray:resultContacts];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    //return [[CBContactsList alloc] initWithArray:resultContacts];
    
    }];
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
