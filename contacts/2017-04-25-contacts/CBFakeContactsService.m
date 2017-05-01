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
        //contact.avatarColor = [self getAvatarColor:firstName AndLastName:lastName];
        
        return contact;
    };
    
    NSArray *contacts =  @[createContact(@"Mivaequi",@"Tiboigee",@"+86469496458",@"Mivaequi.Tiboigee@gmail.com"),
                           createContact(@"phuwohdi",@"quinguos",@"+96896544346",@""),
                           createContact(@"ahpaeshe",@"eekonoog",@"",@"eekonoog@ojohchau.edu"),
                           createContact(@"uphohvak",@"soengaev",@"+29395987342",@"soengaev@ya.ru"),
                           createContact(@"agheepoo",@"kothaeka",@"+84628799628",@"")];
    
    return [[CBContactsList alloc] initWithArray:contacts];
}

-(UIColor*) getAvatarColor:(NSString*) name AndLastName:(NSString*)lastName{
    NSArray* colors = @[[UIColor redColor],
                        [UIColor blueColor],
                        [UIColor greenColor],
                        [UIColor orangeColor],
                        [UIColor magentaColor],
                        [UIColor lightGrayColor],
                        [UIColor yellowColor]
                        ];
    
    
    int asciiCode = [name characterAtIndex:0];
    asciiCode += [lastName characterAtIndex:0];
    int colorIndex = asciiCode % 7;
    
    return colors[colorIndex];
    
}
@end
