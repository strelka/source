//
//  FVPVkLoginViewController.m
//  FVPcontacts
//
//  Created by Jullia Sharaeva on 12.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "FVPVkLoginViewController.h"
const NSString *_appID = @"6007858";

@interface FVPVkLoginViewController ()<UIWebViewDelegate>
@property(strong, nonatomic) UIWebView *vkWebView;
@end

@implementation FVPVkLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!_vkWebView){
        self.vkWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _vkWebView.delegate = self;
        _vkWebView.scalesPageToFit = YES;
        [self.view addSubview:_vkWebView];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        NSString*url=@"https://oauth.vk.com/authorize?client_id=5932466&display=page&redirect_uri=https://oauth.vk.com/blank.html&scope=friends&response_type=token&v=5.64&state=123456";
        NSURLRequest *nsurlRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [_vkWebView loadRequest:nsurlRequest];
    }
}

// The completion handler, if provided, will be invoked after the dismissed controller's viewDidDisappear: callback is invoked.

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
        }
        NSLog(@"vkWebView response: %@",[[[webView request] URL] absoluteString]);
        [self dismissViewControllerAnimated:YES completion:nil];

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
