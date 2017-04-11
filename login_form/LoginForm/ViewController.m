//
//  ViewController.m
//  LoginForm
//
//  Created by Jullia Sharaeva on 08.04.17.
//  Copyright © 2017 Jullia Sharaeva. All rights reserved.
//

#import "ViewController.h"
#import "LoginClass.h"

@interface ViewController ()


@end

@implementation ViewController{
    UITextField *tlogin;
    UITextField *tpass;
    UILabel *result;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view1 = [UIView new];
    CGRect bounds = UIScreen.mainScreen.bounds;
    view1.frame = CGRectMake(0,0, bounds.size.width, bounds.size.height);
    view1.backgroundColor = UIColor.lightGrayColor;
    [self.view addSubview:view1];
    
    double rootWidth = bounds.size.width;
    double rootHeight = bounds.size.height;
    double stepHeight = 30;
    double stepWidth = rootWidth/10;
    
    tlogin = [UITextField new];
    tlogin.frame = CGRectMake(stepWidth, rootHeight/2 - 4 * stepHeight, rootWidth - 2 * stepWidth, stepHeight);
    tlogin.backgroundColor = UIColor.whiteColor;
    tlogin.borderStyle = UITextBorderStyleRoundedRect;
    tlogin.layer.borderColor = [[UIColor darkGrayColor]CGColor];
    tlogin.layer.borderWidth = 2.0f;
    tlogin.placeholder = @"LOGIN";
    
    [view1 addSubview:tlogin];
    
    tpass = [UITextField new];
    tpass.frame = CGRectMake(stepWidth, rootHeight/2 - 2 * stepHeight, rootWidth - 2 * stepWidth, stepHeight);
    tpass.backgroundColor = UIColor.whiteColor;
    tpass.borderStyle = UITextBorderStyleRoundedRect;
    tpass.layer.borderColor = [[UIColor darkGrayColor]CGColor];
    tpass.layer.borderWidth = 2.0f;
    
    tpass.placeholder = @"PASSWORD";
    tpass.secureTextEntry = YES;
    [view1 addSubview:tpass];
    
    UIButton *baccept = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    baccept.frame = CGRectMake(rootWidth/2-2 * stepWidth, rootHeight/2, stepWidth * 4, stepHeight);
    [baccept setTitle:@"Login" forState:(UIControlStateNormal)];
    baccept.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    baccept.backgroundColor = UIColor.darkGrayColor;
    baccept.tintColor = UIColor.lightGrayColor;
    
    [baccept addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [view1 addSubview:baccept];
    [tlogin becomeFirstResponder];
    
    result = [UILabel new];
    result.frame = CGRectMake(stepWidth, rootHeight/2 + 2 * stepHeight, rootWidth - 2 * stepWidth, stepHeight);
    result.textAlignment = NSTextAlignmentCenter;
    
    result.textColor = UIColor.darkGrayColor;
    [view1 addSubview:result];
    
}

- (void)btnClicked:(UIButton *)sender {
    
    NSString *restxt = [NSString stringWithFormat:@"login [%@] pass [%@]", tlogin.text, tpass.text];
    
    NSLog(@"%@",restxt);
    
    result.text = restxt;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
