//
//  ViewController.m
//  Trends
//
//  Created by Jullia Sharaeva on 19.04.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "ViewController.h"
#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect bounds = self.view.bounds;
    double root_width = bounds.size.width;
    double root_height = bounds.size.height;
    double step_width = root_width/10;
    double step_height = root_height/20;
    
    UILabel* label = [UILabel new];
    label.frame = CGRectMake(step_width,
                             root_height/2 - step_height,
                             root_width-2*step_width,
                             step_height);
    
    [self.view addSubview:label];
    label.backgroundColor = [UIColor whiteColor];
    
    [self getTwitterTrends];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void) getTwitterTrends{
    [Fabric with:@[[Twitter class]]];
    TWTRAPIClient *client = [[TWTRAPIClient alloc] init];
    NSString *trendsShow = @"https://api.twitter.com/1.1/trends/current.json";
    NSDictionary *params = @{@"id":@"20"};
    NSError *clientError;
    
    NSURLRequest *request = [client URLRequestWithMethod:@"GET"
                                                     URL:trendsShow
                                              parameters:params
                                                   error:&clientError];
    if (request){
        [client sendTwitterRequest:request completion:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            if (data) {
            NSError* jsonError;
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:0
                                                                   error:&jsonError];
                NSArray* results = json[@"trends"];
                NSLog(@"%@", json);
                
        }
         else {
             NSLog(@"Error: %@", connectionError);
         
         }
         
         }];
    
    }
    else {
        NSLog(@"Error: %@", clientError);
    }
}

    
    
//    NSURL *feedURL = [NSURL URLWithString:@"https://api.twitter.com/1.1/trends/current.json"];
//    SLRequest *twitterFeed = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:feedURL parameters:nil];
//    [twitterFeed performRequestWithHandler:^(NSData *responseData,
//                                             NSHTTPURLResponse *urlResponse,
//                                             NSError *error) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (responseData){
//                NSError* error = nil;
//                NSDictionary *TWData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
//                NSArray* results = TWData[@"trends"];
//            }
//        
//        });
//    }];

    
                      //                                          requestForServiceType:SLServiceTypeTwitter
                      //                                          requestMethod:SLRequestMethodGET
                      //                                          URL:feedURL parameters:nil];
                      //
                      //                twitterFeed.account = twitterAccount;
                      //                [twitterFeed performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                      //
                      //                    dispatch_async(dispatch_get_main_queue(), ^{
                      //                         if (responseData){
                      //                             NSError *error = nil;
                      //                             NSDictionary *TWData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
                      //                             NSArray* results = TWData[@"trends"];
                      //                             
                      //                         }
                      //                     
                      //                     });

    
//    NSURLSession *urlSession;
//    NSURLSessionDataTask *dataTask;
//    NSURL *twitterURL = [NSURL URLWithString:@"https://api.twitter.com/1.1/trends/current.json"];
//    
//    urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    dataTask = [urlSession
//                dataTaskWithURL:twitterURL
//                completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//                    
//                    // add error checking here
//                    NSLog(@"Got %lu bytes of data from twitter", (unsigned long)[data length]);
//                    
//                }];
//    [dataTask resume];
//    
//    }

//    ACAccountStore *account = [[ACAccountStore alloc] init];
//    ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:
//                                  ACAccountTypeIdentifierTwitter];
//
//[account requestAccessToAccountsWithType:accountType options:nil
//                                  completion:^(BOOL granted, NSError *error)
//    {
//        if (granted == YES)
//        {
//            NSArray *arrayOfAccounts = [account
//                                        accountsWithAccountType:accountType];
//            
//            if ([arrayOfAccounts count] > 0)
//            {
//                ACAccount *twitterAccount = [arrayOfAccounts lastObject];
//                NSURL *feedURL = [NSURL
//                                     URLWithString:@"https://api.twitter.com/1.1/trends/current.json"];
//                
//                SLRequest *twitterFeed = [SLRequest
//                                          requestForServiceType:SLServiceTypeTwitter
//                                          requestMethod:SLRequestMethodGET
//                                          URL:feedURL parameters:nil];
//                
//                twitterFeed.account = twitterAccount;
//                [twitterFeed performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
//                    
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                         if (responseData){
//                             NSError *error = nil;
//                             NSDictionary *TWData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
//                             NSArray* results = TWData[@"trends"];
//                             
//                         }
//                     
//                     });
//                 
//                 }
//                 
//            }
//        }
//    }
//    
//}]


//NSURL *feedURL = [NSURL URLWithString:@"http://api.twitter.com/1/trends/current.json"];
//
//// 2. Create TWRequest, with parameters, URL & specify GET method
//SLRequest *twitterFeed = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:feedURL parameters:nil];
//twitterFeed.account = _twitterAccount;
//// Making the request
//[twitterFeed performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        // Check if we reached the reate limit
//        if (responseData) {
//            
//            NSError *error = nil;
//            NSDictionary *TWData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
//            NSArray* results = TWData [@"trends"];
//        }
//    });
//}];
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//

@end
