//
//  FVPVkLoginViewController.m
//  FVPcontacts
//
//  Created by Jullia Sharaeva on 12.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "FVPLoginViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

const NSString *vk_appID = @"6007858";


const 
@interface FVPLoginViewController ()<UIWebViewDelegate, FBSDKLoginButtonDelegate>
@property(strong, nonatomic) UIWebView *vkWebView;

@property(strong, nonatomic) NSString *url;
@end

@implementation FVPLoginViewController
- (instancetype) initWithConnectingString:(NSString*)connUrl{
    self = [super init];
    if (self){
        _url = connUrl;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([_url  isEqual: @"fbAuth"]){
        if (![FBSDKAccessToken currentAccessToken]) {
            self.view.backgroundColor = [UIColor whiteColor];
            FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
            loginButton.center = self.view.center;
            loginButton.delegate = self;
            loginButton.readPermissions = @[@"user_relationships", @"read_custom_friendlists", @"user_friends"];
            
            [self.view addSubview:loginButton];
        } else {
        [self dismissViewControllerAnimated:YES completion:nil];
        }
    } else {
        if (!_vkWebView){
            self.vkWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
            _vkWebView.delegate = self;
            _vkWebView.scalesPageToFit = YES;
            [self.view addSubview:_vkWebView];
        
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
            NSURLRequest *nsurlRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
            [_vkWebView loadRequest:nsurlRequest];
        }
    }
}

- (void)loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
                error:(NSError *)error{
    [self dismissViewControllerAnimated:YES completion:nil];
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
