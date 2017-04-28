//
//  VkLoginViewController.m
//  2017-04-25-contacts
//
//  Created by Jullia Sharaeva on 28.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "VkLoginViewController.h"
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
        
        NSString *authLink = [NSString stringWithFormat:@"http://api.vk.com/oauth/authorize?client_id=%@&scope=friends&redirect_uri=http://api.vk.com/blank.html&display=touch&response_type=token", _appID];
        NSURL *url = [NSURL URLWithString:authLink];
        [_vkWebView loadRequest:[NSURLRequest requestWithURL:url]];
        
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
    if ([_vkWebView.request.URL.absoluteString rangeOfString:@"access_token"].location != NSNotFound){
        NSString *accessToken = [self stringBetweenString:@"access_token="
                                                andString:@"&"
                                              innerString:[[[webView request] URL] absoluteString]];
        
        NSArray *userAr = [[[[webView request]URL]absoluteString]componentsSeparatedByString:@"&user_id="];
        NSString *user_id = [userAr lastObject];
        NSLog(@"User id:%@", user_id);
        if (user_id){
            [[NSUserDefaults standardUserDefaults] setObject:user_id forKey:@"VKAccessUserId"];
        }
        if (accessToken){
            [[NSUserDefaults standardUserDefaults]setObject:accessToken forKey:@"VKAccessTokenDate"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"VKAccessTokenDate"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        NSLog(@"vkWebView response: %@",[[[webView request] URL] absoluteString]);
        isAuth = YES;
        [self dismissViewControllerAnimated:NO completion:nil];
        
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


@end
