//
//  VkLoginViewController.m
//  2017-04-25-contacts
//
//  Created by Jullia Sharaeva on 28.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "VkLoginViewController.h"
#import "CBContactsTableViewController.h"

const NSString *_appID = @"6007858";
@interface VkLoginViewController ()
{
    BOOL isAuth;

}
@end

@implementation VkLoginViewController

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
    if (!_vkWebView){
        self.vkWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _vkWebView.delegate = self;
        _vkWebView.scalesPageToFit = YES;
        [self.view addSubview:_vkWebView];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

        
        NSString*url=@"https://oauth.vk.com/authorize?client_id=5932466&display=page&redirect_uri=https://oauth.vk.com/blank.html&scope=friends&response_type=token&v=5.63&state=123456";
        NSURLRequest *nsurlRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [_vkWebView loadRequest:nsurlRequest];
        
    }

}

-(BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
                                                 navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = [request URL];
    if ([[url absoluteString] isEqualToString:@"http://api.vk.com/blank.html#error=access_denied&error_reason=user_denied&error_description=User%20denied%20your%20request"]){
        return NO;
    }
    NSLog(@"Request: %@", [url absoluteString]);
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if ([_vkWebView.request.URL.absoluteString rangeOfString:@"access_token"].location != NSNotFound){
        NSString *accessToken = [self stringBetweenString:@"access_token="
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
            [self goToCBContactsTableViewController];
        }
        NSLog(@"vkWebView response: %@",[[[webView request] URL] absoluteString]);
        

    }else if ([_vkWebView.request.URL.absoluteString rangeOfString:@"error"].location != NSNotFound){
        NSLog(@"Error: %@", _vkWebView.request.URL.absoluteString);
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

-(void) goToCBContactsTableViewController{
    CBContactsTableViewController* cbt = [CBContactsTableViewController new];
    [self.navigationController pushViewController:cbt animated:YES];
}

@end
