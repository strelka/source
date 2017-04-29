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

@implementation CBVkContactsService

- (CBContactsList *)getContacts {
    NSString* accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"VKAccessToken"];
    NSString* UserId = [[NSUserDefaults standardUserDefaults] objectForKey:@"VKAccessUserId"];
    NSString* url = [[NSString alloc] initWithFormat:@"https://api.vk.com/method/friends.get?user_id=%@&fields=nickname,contacts,photo_100&%@",
    UserId, accessToken];
    
    NSURLRequest *nsurlRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:nsurlRequest returningResponse:nil error:nil];
    
    if (responseData){
        NSError* jsonError;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData
                                                        options:0
                                                          error:&jsonError];
        
        NSDictionary * contacts = [json objectForKey:@"response"];
        

    }
    
    return @"f";
//    CBContact* (^createContact)(NSString *, NSString *, NSString *, NSString *);
//    createContact = ^CBContact*(NSString *firstName,
//                                NSString *lastName,
//                                NSString *phoneNumber,
//                                NSString *email) {
//        CBContact *contact = [CBContact new];
//        contact.firstName = firstName;
//        contact.lastName = lastName;
//        contact.phoneNumber = phoneNumber;
//        contact.email = email;
//        contact.avatarColor = [self getAvatarColor:firstName AndLastName:lastName];
//        
//        return contact;
//    };
//    
//    NSArray *contacts =  @[createContact(@"Mivaequi",@"Tiboigee",@"+86469496458",@"Mivaequi.Tiboigee@gmail.com"),
//                           createContact(@"phuwohdi",@"quinguos",@"+96896544346",@""),
//                           createContact(@"ahpaeshe",@"eekonoog",@"",@"eekonoog@ojohchau.edu"),
//                           createContact(@"uphohvak",@"soengaev",@"+29395987342",@"soengaev@ya.ru"),
//                           createContact(@"agheepoo",@"kothaeka",@"+84628799628",@"")];
//    
//    return [[CBContactsList alloc] initWithArray:contacts];
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
