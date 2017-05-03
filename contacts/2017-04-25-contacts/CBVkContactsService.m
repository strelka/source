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

@interface CBVkContactsService()
@property(nonatomic, copy) void(^successBlock)(NSData*);

@end
@implementation CBVkContactsService


-(void)retrieveURL:(NSURL * )url successBlock:(void(^)(NSData *)) successBlock{
    self.successBlock = successBlock;
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSessionConfiguration *conf = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:conf delegate:self delegateQueue:nil];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request];
    [task resume];

}

-(void) URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSData *data = [NSData dataWithContentsOfURL:location];
    dispatch_async(dispatch_get_main_queue(), ^{self.successBlock(data);
    });
}


//- (instancetype) init {
    
//    self = [super init];
//    
//    CBContact* (^createContact)(NSDictionary* jsonContact);
//    createContact = ^CBContact*(NSDictionary* jsonContact){
//        CBContact *contact = [CBContact new];
//        contact.firstName = [jsonContact objectForKey:@"first_name"];
//        contact.lastName = [jsonContact objectForKey:@"last_name"];
//        contact.urlImage = [jsonContact objectForKey:@"photo_100"];
//        return contact;
//    };
//    
//    NSMutableArray *resultContacts = [NSMutableArray new];
//    
//    NSString* accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"VKAccessToken"];
//    NSString* UserId = [[NSUserDefaults standardUserDefaults] objectForKey:@"VKAccessUserId"];
//    NSString* url = [[NSString alloc] initWithFormat:@"https://api.vk.com/method/friends.get?user_id=%@&fields=nickname,contacts,photo_100,mobile_phone&%@",
//    UserId, accessToken];
//    
//    
//    [self retrieveURL:[NSURL URLWithString:url] successBlock:^(NSData *response){
//        NSError* jsonError;
//        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:response
//                                                             options:0
//                                                               error: &jsonError];
//        NSDictionary* contacts = [json objectForKey:@"response"];
//        for (NSDictionary* contact in contacts){
//            [resultContacts addObject:createContact(contact)];
//        }
//        self.resultContacts = [[CBContactsList alloc] initWithArray:resultContacts];
//        //return [[CBContactsList alloc] initWithArray:resultContacts];
//        
//    }];
//    return self;
//}
    
//    NSURLRequest *nsurlRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
//    
//    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
//    
//    NSURLSessionDownloadTask *task = [session dataTaskWithRequest:nsurlRequest
//                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
//                                                NSError* jsonError;
//                                                NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
//                                                         options:0
//                                                           error: &jsonError];
//                                                NSDictionary* contacts = [json objectForKey:@"response"];
//                                                
//                                                for (NSDictionary* contact in contacts){
//                                                    [resultContacts addObject:createContact(contact)];
//                                                }
//                                            }
//                                  ];
//    [task resume];

@end;
