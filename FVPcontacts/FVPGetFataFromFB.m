//
//  FVPGetFataFromFB.m
//  FVPcontacts
//
//  Created by Jullia Sharaeva on 12.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "FVPGetFataFromFB.h"
#import "FVPContact.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@implementation FVPGetFataFromFB

- (void)getDataAndDoSuccessBlock:(void(^)(NSArray *data)) successBlock{
    
    FVPContact*(^createContact)(NSDictionary *json);
    createContact = ^FVPContact*(NSDictionary *json){
        FVPContact *newContact = [FVPContact new];
        newContact.firstName = json[@"first_name"];
        newContact.lastName = json[@"last_name"];
        
        NSDictionary *urlDic = json[@"picture"];
        NSDictionary *urlDic2 = urlDic[@"data"];
        NSString *url = urlDic2[@"url"];
        newContact.imageUrl = [[NSURL alloc] initWithString:url];
        return newContact;
    };

    
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc]
          initWithGraphPath:@"/me"
          parameters:@{ @"fields": @"id,name,taggable_friends{first_name,last_name,picture}",}
          HTTPMethod:@"GET"] startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            NSMutableArray *resultContacts = [[NSMutableArray alloc] init];
            if (!error) {
                NSDictionary * contacts = [[result objectForKey:@"taggable_friends"] objectForKey:@"data"];
                for (NSDictionary *contact in contacts) {
                    FVPContact *tmpContact = createContact(contact);
                    [resultContacts addObject:tmpContact];
                }
            }
            successBlock(resultContacts);
        }];
    }
}
@end
