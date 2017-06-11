//
//  FVPGetDataFromPhoneBook.m
//  FVPcontacts
//
//  Created by Jullia Sharaeva on 12.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "FVPGetDataFromPhoneBook.h"
#import <Contacts/Contacts.h>
#import "FVPContact.h"

@implementation FVPGetDataFromPhoneBook
- (void)getDataAndDoSuccessBlock:(void(^)(NSArray *data)) successBlock{
    
    FVPContact*(^createContact)(CNContact *contact);
    createContact = ^FVPContact*(CNContact *contact){
        FVPContact *newContact = [FVPContact new];
        newContact.firstName = contact.givenName;
        newContact.lastName = contact.familyName;
        newContact.avatarImg = [[UIImage alloc ] initWithData:contact.imageData];
        return newContact;
    };

    
    CNContactStore *store = [[CNContactStore alloc] init];
    [store requestAccessForEntityType:
     CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
         NSMutableArray *resultRecords = [NSMutableArray new];
         if (granted == YES){
             NSArray *keys = @[CNContactFamilyNameKey,
                               CNContactGivenNameKey,
                               CNContactImageDataKey
                               ];
         NSString *containerId = store.defaultContainerIdentifier;
         NSPredicate *predicate = [CNContact predicateForContactsInContainerWithIdentifier:containerId];
         
         NSError *error;
         NSArray *cnContacts = [store unifiedContactsMatchingPredicate:predicate keysToFetch:keys error:&error];
         
         if (error) {
             NSLog(@"error fetching contacts %@", error);
         } else {
             for (CNContact *contact in cnContacts){
                 [resultRecords addObject:createContact(contact)];
             }
         }
         }
         dispatch_async(dispatch_get_main_queue(), ^{
             successBlock(resultRecords);
         });
     }];


}
@end
