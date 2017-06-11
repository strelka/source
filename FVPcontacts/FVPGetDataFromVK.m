//
//  FVPGetDataFromVK.m
//  FVPcontacts
//
//  Created by Jullia Sharaeva on 12.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "FVPGetDataFromVK.h"
#import "FVPContact.h"

@implementation FVPGetDataFromVK

- (void)getDataAndDoSuccessBlock:(void(^)(NSArray *data)) successBlock{
    
    FVPContact*(^createContact)(NSDictionary *json);
    createContact = ^FVPContact*(NSDictionary *json){
        FVPContact *newContact = [FVPContact new];
        newContact.firstName = json[@"first_name"];
        newContact.lastName = json[@"last_name"];
        newContact.imageUrl = [NSURL URLWithString:json[@"photo_100"]];
        return newContact;
    };

    
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"VKAccessToken"];
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"VKAccessUserId"];
    NSString *urlString = @"https://api.vk.com/method/friends.get?";
    NSString *urlParametres = [[NSString alloc] initWithFormat:@"user_id=%@&fields=nickname,contacts,photo_100,phone&%@", userId, accessToken];
    urlParametres = [urlParametres stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString* webStringURL = [urlString stringByAppendingString:urlParametres];
    NSURL* urlData = [NSURL URLWithString:webStringURL];
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    
    [[session dataTaskWithURL:urlData completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError* jsonError;
        NSMutableArray *_resultRecords = [NSMutableArray new];
        if (data){
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSDictionary *jsonResults = [json objectForKey:@"response"];
            if (jsonResults){
                for (NSDictionary* resultItem in jsonResults){
                    [_resultRecords addObject:createContact(resultItem)];
                }
            }
        }
        NSArray *result = [[NSArray alloc] initWithArray:_resultRecords];
        dispatch_async(dispatch_get_main_queue(), ^{
            successBlock(result);
        });
        
        
    }] resume];
    
}

@end
