//
//  myInstagramConsoleVcViewController.m
//  Trends
//
//  Created by Jullia Sharaeva on 22.04.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "myInstagramConsoleVcViewController.h"

@interface myInstagramConsoleVcViewController ()
@property(nonatomic, strong) NSString* fullURL;
@end

@implementation myInstagramConsoleVcViewController

#define KAUTHURL @"https://api.instagram.com/oauth/authorize/"
#define kAPIURl @"https://api.instagram.com/v1/users/"
#define KCLIENTID @"66a3969d6d154790ac556d6a8967e06e"
#define KCLIENTSERCRET @"193e1deb23a24d93b05dfa1dbf6e27fd"
#define kREDIRECTURI @"google.com"
#define KACCESS_TOKEN @"access_token"


-(instancetype) init{
    self = [super init];
    if (self){
        _fullURL = [NSString stringWithFormat:@"%@%@&redirect_uri=%@&response_type=token",
                    kAPIURl,
                    KCLIENTID,
                    kREDIRECTURI];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadURL];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)loadURL{
    NSURL *url = [NSURL URLWithString:_fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url]; [mywebview loadRequest:requestObj];
    mywebview.delegate = self;
    [self.view addSubview:mywebview];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString* urlString = [[request URL] absoluteString];
    NSLog(@"URL STRING : %@ ",urlString);
    NSArray *UrlParts = [urlString componentsSeparatedByString:[NSString stringWithFormat:@"%@/", kREDIRECTURI]];
    if ([UrlParts count] > 1) {
        // do any of the following here
        urlString = [UrlParts objectAtIndex:1];
        NSRange accessToken = [urlString rangeOfString: @"#access_token="];
        if (accessToken.location != NSNotFound) {
            NSString* strAccessToken = [urlString substringFromIndex: NSMaxRange(accessToken)];
            // Save access token to user defaults for later use.
            // Add contant key #define KACCESS_TOKEN @”access_token” in contant //class
            [[NSUserDefaults standardUserDefaults] setValue:strAccessToken forKey: KACCESS_TOKEN];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSLog(@"AccessToken = %@ ",strAccessToken);
            [self loadRequestForMediaData];
        }
        return NO;
    }
    return YES;
}

-(void)loadRequestForMediaData {
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@users/3/media/recent/?access_token=%@",kAPIURl,[[ NSUserDefaults standardUserDefaults] valueForKey:KACCESS_TOKEN]]]];
    // Here you can handle response as well
    NSDictionary *dictResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"Response : %@",dictResponse); 
}

@end;
