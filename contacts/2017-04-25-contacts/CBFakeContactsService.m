//
//  CBFakeContactsService.m
//  2017-04-25-contacts
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "CBFakeContactsService.h"
#import "CBContactsList.h"
#import "CBContact.h"
#import "CBAvatarView.h"


@implementation CBFakeContactsService

- (CBContactsList *)getContacts {
    
    CBContact* (^createContact)(NSString *, NSString *, NSString *, NSString *);
    createContact = ^CBContact*(NSString *firstName,
                               NSString *lastName,
                               NSString *phoneNumber,
                               NSString *email) {
        CBContact *contact = [CBContact new];
        contact.firstName = firstName;
        contact.lastName = lastName;
        contact.phoneNumber = phoneNumber;
        contact.email = email;
        CBAvatarView* avatarView = [[CBAvatarView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        avatarView.name=firstName;
        avatarView.lastName=lastName;
        
        [avatarView fillRect:CGRectMake(0, 0, 100, 100)];
        contact.avatar=[avatarView getImage];
        
        return contact;
    };
    
    NSArray *contacts =  @[createContact(@"Mivaequi",@"Tiboigee",@"+86469496458",@"Mivaequi.Tiboigee@gmail.com"),
                                  createContact(@"phuwohdi",@"quinguos",@"+96896544346",@""),
                                  createContact(@"ahpaeshe",@"eekonoog",@"",@"eekonoog@ojohchau.edu"),
                                  createContact(@"uphohvak",@"soengaev",@"+29395987342",@"soengaev@ya.ru"),
                                  createContact(@"agheepoo",@"kothaeka",@"+84628799628",@"")];
    return [[CBContactsList alloc] initWithArray:contacts];
}

@end
