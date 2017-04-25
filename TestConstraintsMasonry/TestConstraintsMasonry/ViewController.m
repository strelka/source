//
//  ViewController.m
//  TestConstraintsMasonry
//
//  Created by Jullia Sharaeva on 24.04.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UILabel* l1 = [UILabel new];
    UILabel* l2 = [UILabel new];
    UILabel* l3 = [UILabel new];
    UILabel* l4 = [UILabel new];
    
    l1.backgroundColor = [UIColor blueColor];
    l2.backgroundColor = [UIColor yellowColor];
    l3.backgroundColor = [UIColor redColor];
    l4.backgroundColor = [UIColor whiteColor];
    
    
    [self.view addSubview:l2];
    [self.view addSubview:l3];
    [self.view addSubview:l4];
    [self.view addSubview:l1];
    
    
    UILabel* l01 = [UILabel new];
    UILabel* l02 = [UILabel new];
    UILabel* l03 = [UILabel new];
    UILabel* l04 = [UILabel new];
    
    l01.backgroundColor = self.view.backgroundColor;
    l02.backgroundColor = self.view.backgroundColor;
    l03.backgroundColor = self.view.backgroundColor;
    l04.backgroundColor = self.view.backgroundColor;
    
    
    [self.view addSubview:l01];
    [self.view addSubview:l02];
    [self.view addSubview:l03];
    [self.view addSubview:l04];
    
    UILabel* l11 = [UILabel new];
    UILabel* l12 = [UILabel new];
    UILabel* l13 = [UILabel new];
    UILabel* l14 = [UILabel new];
    
    l11.backgroundColor = [UIColor blueColor];
    l12.backgroundColor = [UIColor yellowColor];
    l13.backgroundColor = [UIColor redColor];
    l14.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:l11];
    [self.view addSubview:l12];
    [self.view addSubview:l13];
    [self.view addSubview:l14];
    
    NSNumber *width_step = @(self.view.bounds.size.width/11);
    //--_--_--_--
    
    [l1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.lessThanOrEqualTo(self.view.mas_top).priorityHigh();
        
        make.width.greaterThanOrEqualTo(@([width_step doubleValue] * 2));
        make.height.equalTo(l1.mas_width);
    }];
    
    [l2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(l1.mas_right).with.offset([width_step doubleValue]);
        make.top.lessThanOrEqualTo(self.view.mas_top).priorityHigh();
        
        make.width.equalTo(l1.mas_width);
        make.height.equalTo(l1.mas_width);
    }];
    
    [l3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.lessThanOrEqualTo(self.view.mas_top).priorityHigh();
        make.left.equalTo(l2.mas_right).with.offset([width_step doubleValue]);
        
        make.width.equalTo(l1.mas_width);
        make.height.equalTo(l1.mas_width);
    }];
    
    [l4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.lessThanOrEqualTo(self.view.mas_top).priorityHigh();
        
        make.left.equalTo(l3.mas_right).with.offset([width_step doubleValue]);
        make.right.equalTo(self.view.mas_right).priorityHigh();
        
        make.width.equalTo(l1.mas_width);
        make.height.equalTo(l1.mas_width);
    }];
    
    
    
    
    //NSNumber *width_step1 = @(self.view.bounds.size.width/5);;
    //NSNumber *height_step1 = @(self.view.bounds.size.height/3);
    
    //--|--|--|--
    
    [l01 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.greaterThanOrEqualTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.width.equalTo(@100);
        make.height.equalTo(@100);
    }];
    [l02 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.greaterThanOrEqualTo(self.view.mas_bottom);
        make.left.equalTo(l01.mas_right);
        make.width.equalTo(l01.mas_width);
        make.height.equalTo(@100);

    }];
    [l03 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.greaterThanOrEqualTo(self.view.mas_bottom);
        make.left.equalTo(l02.mas_right);
        make.width.equalTo(l01.mas_width);
        make.height.equalTo(@100);

    }];
    [l04 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.greaterThanOrEqualTo(self.view.mas_bottom);
        make.left.equalTo(l03.mas_right);
        make.right.equalTo(self.view.mas_right);
        make.width.equalTo(l01.mas_width);
        make.height.equalTo(@100);

    }];
    
    [l11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(l01.mas_centerX);
        make.centerY.equalTo(l01.mas_centerY);
        
        make.width.equalTo(@(50));
        make.height.equalTo(l11.mas_width);
    }];
    
    [l12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(l02.mas_centerX);
        make.centerY.equalTo(l02.mas_centerY);
        
        make.width.equalTo(@(50)).priorityHigh();
        make.height.equalTo(l11.mas_width).priorityHigh();
    }];

    [l13 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(l03.mas_centerX);
        make.centerY.equalTo(l03.mas_centerY);
        
        make.width.equalTo(@(50)).priorityHigh();
        make.height.equalTo(l11.mas_width).priorityHigh();
    }];

    [l14 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(l04.mas_centerX);
        make.centerY.equalTo(l04.mas_centerY);
        
        make.width.equalTo(@(50)).priorityHigh();
        make.height.equalTo(l11.mas_width).priorityHigh();
    }];

    
    
//    [l11 mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.equalTo(self.view.mas_left);
//        
//        make.leading.equalTo(self.view.mas_leading).with.offset(20).priorityLow();
//        make.trailing.equalTo(l12.mas_leading).with.offset(-20).priorityMedium();
//        
//        make.bottom.greaterThanOrEqualTo(self.view.mas_bottom);
//        make.width.equalTo(@(50)).priorityHigh();
//        make.height.equalTo(l11.mas_width).priorityHigh();
//    }];
//    
//    [l12 mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.leading.equalTo(l11.mas_trailing).with.offset(20).priorityLow();
//        make.trailing.equalTo(l13.mas_leading).with.offset(-20).priorityMedium();
//        
//        make.trailing.equalTo(self.view.mas_centerX).with.offset(20).priorityMedium();
//        
//        
//        make.bottom.greaterThanOrEqualTo(self.view.mas_bottom);
//        make.width.equalTo(l11.mas_width).priorityHigh();
//        make.height.equalTo(l11.mas_width).priorityHigh();
//    }];
//    
//    
//    [l13 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(l12.mas_trailing).with.offset(20).priorityLow();
//        make.trailing.equalTo(l14.mas_leading).with.offset(-20).priorityMedium();
//        
//        make.leading.equalTo(self.view.mas_centerX).with.offset(20).priorityMedium();
//        
//        make.bottom.greaterThanOrEqualTo(self.view.mas_bottom);
//        make.width.equalTo(l11.mas_width).priorityHigh();
//        make.height.equalTo(l11.mas_width).priorityHigh();
//    }];
////
//    [l14 mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.right.equalTo(self.view.mas_right);
//        
//        make.leading.equalTo(l13.mas_trailing).with.offset(20).priorityLow();
//        make.trailing.equalTo(self.view.mas_leading).with.offset(-20).priorityMedium();
//        
//        
//        make.bottom.greaterThanOrEqualTo(self.view.mas_bottom);
//        make.width.equalTo(l11.mas_width).priorityHigh();
//        make.height.equalTo(l11.mas_width).priorityHigh();
//    }];
////
//    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.trailingMargin.equalTo(l14.mas_trailing).with.offset(20).priorityLow();
//    }];
//
//    [l14 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.trailing.equalTo(self.view.mas_trailing).with.offset(20).priorityLow();
//    }];
//    
//    [l13 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.trailing.equalTo(l14.mas_trailing).with.offset(20).priorityLow();
//    }];
//    
//    [l12 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.trailing.equalTo(l13.mas_trailing).with.offset(20).priorityLow();
//    }];
//    
//    [l11 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.trailing.equalTo(l12.mas_trailing).with.offset(20).priorityLow();
//    }];
//    
//    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(l11.mas_trailing).with.offset(20).priorityLow();
//    }];
//    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
