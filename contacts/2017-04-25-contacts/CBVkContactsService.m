//
//  CBVkContactsService.m
//  2017-04-25-contacts
//
//  Created by Jullia Sharaeva on 28.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "CBVkContactsService.h"
#import "VkLoginViewController.h"
#import "CBContact.h"
#import "CBContactsList.h"

@implementation CBVkContactsService

- (CBContactsList *)getContacts {
    NSString* accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"VKAccessToken"];
    NSString* UserId = [[NSUserDefaults standardUserDefaults] objectForKey:@"VKAccessUserId"];
    NSString* url = [[NSString alloc] initWithFormat:@"https://api.vk.com/method/friends.get?user_id=%@&fields=nickname,contacts,photo_100,mobile_phone&%@",
    UserId, accessToken];
    
    NSURLRequest *nsurlRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:nsurlRequest returningResponse:nil error:nil];
    
    
    
    CBContact* (^createContact)(NSDictionary* jsonContact);
    createContact = ^CBContact*(NSDictionary* jsonContact){
        CBContact *contact = [CBContact new];
        contact.firstName = [jsonContact objectForKey:@"first_name"];
        contact.lastName = [jsonContact objectForKey:@"last_name"];
        contact.urlImage = [jsonContact objectForKey:@"photo_100"];
        return contact;
    };
    
    NSMutableArray *resultContacts = [NSMutableArray new];
    
    if (responseData){
        NSError* jsonError;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData
                                                        options:0
                                                          error:&jsonError];
        
        NSDictionary * contacts = [json objectForKey:@"response"];
        
        
        for (NSDictionary* contact in contacts){
            [resultContacts addObject:createContact(contact)];
        
        }
    }
    
    return [[CBContactsList alloc] initWithArray:resultContacts];
}
@end

