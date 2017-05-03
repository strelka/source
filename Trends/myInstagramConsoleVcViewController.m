//
//  VkLoginViewController.m
//  2017-04-25-contacts
//
//  Created by Jullia Sharaeva on 28.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "myInstagramConsoleVcViewController.h"

const NSString *_clientID = @"66a3969d6d154790ac556d6a8967e06e";
const NSString *_clientSecret = @"193e1deb23a24d93b05dfa1dbf6e27fd";
const NSString *redirectURL = @"https://trends.com";

@interface myInstagramConsoleVcViewController ()
{
    BOOL isAuth;
    
}
@end

@implementation myInstagramConsoleVcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated{
    if (isAuth==YES){
        [self dismissViewControllerAnimated:NO completion:nil];
    }else {
        [self showSignInWebView];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showSignInWebView{
    if (!_instWebView){
        _instWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _instWebView.delegate = self;
        _instWebView.scalesPageToFit = YES;
        
        [self.view addSubview:_instWebView];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        NSString*url=[[NSString alloc] initWithFormat: @"https://api.instagram.com/oauth/authorize/?client_id=%@&redirect_uri=%@&response_type=code", _clientID, redirectURL];
        
        NSURLRequest *nsurlRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [_instWebView loadRequest:nsurlRequest];
        
    }
    
}

//-(BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
// navigationType:(UIWebViewNavigationType)navigationType
//{
//    NSURL *url = [request URL];
//    if ([[url absoluteString] isEqualToString:@"http://api.vk.com/blank.html#error=access_denied&error_reason=user_denied&error_description=User%20denied%20your%20request"]){
//        return NO;
//    }
//    NSLog(@"Request: %@", [url absoluteString]);
//    return YES;
//}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if ([_instWebView.request.URL.absoluteString rangeOfString:@"code"].location != NSNotFound){
        NSString *accessToken = [self stringBetweenString:@"code="
                                                andString:@"&"
                                              innerString:[[[webView request] URL] absoluteString]];
        
        NSString *user_id = [self stringBetweenString:@"user_id="
                                            andString:@"&"
                                          innerString:[[[webView request] URL] absoluteString]];
        
        if (user_id){
            [[NSUserDefaults standardUserDefaults] setObject:user_id forKey:@"VKAccessUserId"];
        }
        if (accessToken){
            [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:@"VKAccessToken"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"VKAccessTokenDate"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            //[self goToCBContactsTableViewController];
        }
        NSLog(@"vkWebView response: %@",[[[webView request] URL] absoluteString]);
        
        
    }else if ([_instWebView.request.URL.absoluteString rangeOfString:@"error"].location != NSNotFound){
        NSLog(@"Error: %@", _instWebView.request.URL.absoluteString);
    }
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"vkWebView Error: %@", [error localizedDescription]);
}

-(NSString*)stringBetweenString:(NSString*)start
                      andString:(NSString*)end
                    innerString:(NSString*)str
{
    NSScanner* scanner = [NSScanner scannerWithString:str];
    [scanner setCharactersToBeSkipped:nil];
    [scanner scanUpToString:start intoString:NULL];
    if ([scanner scanString:start intoString:NULL]){
        NSString* result = nil;
        if ([scanner scanUpToString:end intoString:&result]){
            return result;
        }
        
    }
    return nil;
}

//-(void) goToCBContactsTableViewController{
//    CBContactsTableViewController* cbt = [CBContactsTableViewController new];
//    [self.navigationController pushViewController:cbt animated:YES];


@end
