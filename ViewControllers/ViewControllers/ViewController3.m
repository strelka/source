//
//  ViewController3.m
//  ViewControllers
//
//  Created by Jullia Sharaeva on 12.04.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "ViewController3.h"

@interface ViewController3 ()

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    
    CGRect bounds = self.view.bounds;
    double root_width = bounds.size.width;
    double root_hight = bounds.size.height;
    double step_width = bounds.size.width/10;
    double step_hight = 20;
    
    UIButton* btn = [UIButton new];
    btn.frame = CGRectMake(root_width/2 - 3*step_width, root_hight/2 - step_hight, 6*step_width, 2*step_hight);
    btn.backgroundColor = [UIColor colorWithRed:90/255.0f green:200/255.0f blue:250/255.0f alpha:1];
    [btn setTitle:@"First Screen" forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    btn.layer.borderColor = [UIColor brownColor].CGColor;
    btn.layer.borderWidth = 1;
    btn.layer.cornerRadius = 10.0f;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void) buttonClick:(UIButton*)button{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
