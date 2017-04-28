//
//  VkLoginViewController.h
//  2017-04-25-contacts
//
//  Created by Jullia Sharaeva on 28.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VkLoginViewController : UIViewController<UIWebViewDelegate>
    @property(nonatomic, strong) id delegate;
    @property(nonatomic, strong) UIWebView *vkWebView;
    @property(nonatomic, strong) NSString *appID;

    
@end
