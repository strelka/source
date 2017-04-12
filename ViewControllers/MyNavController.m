//
//  MyNavController.m
//  ViewControllers
//
//  Created by Jullia Sharaeva on 12.04.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "MyNavController.h"
#import "ViewController1.h"

@interface MyNavController ()

@end

@implementation MyNavController
@synthesize count = _count;

-(instancetype)init:(int)count{
    self = [super init];
    if (self){
        _count = count;
    }

    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    CGRect bounds = self.view.bounds;
    double root_width = bounds.size.width;
    double root_hight = bounds.size.height;
    double step_width = root_width/10;
    double step_hight = 20;
    
    UIButton* btn = [UIButton new];
    btn.frame = CGRectMake(root_width/2 - 3*step_width, root_hight/2 - step_hight, 6*step_width, 2*step_hight);
    btn.backgroundColor = [self generateColor];
    [btn setTitle:@"Next screen" forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor brownColor] forState:UIControlStateHighlighted];
    btn.layer.borderColor = [UIColor brownColor].CGColor;
    btn.layer.borderWidth = 1;
    btn.layer.cornerRadius = 10.0f;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if (_count >= 2) {
        UIButton* btn_back = [UIButton new];
        btn_back.frame = CGRectMake(root_width/2 - 3*step_width, root_hight/2 + 2* step_hight, 6*step_width, 2*step_hight);
        btn_back.backgroundColor = [UIColor lightGrayColor];
        [btn_back setTitle:@"root screen" forState:UIControlStateNormal];
    
        [btn_back setTitleColor:[UIColor brownColor] forState:UIControlStateHighlighted];
        btn_back.layer.borderColor = [UIColor darkGrayColor].CGColor;
        btn_back.layer.borderWidth = 1;
        btn_back.layer.cornerRadius = 10.0f;
        [self.view addSubview:btn_back];
        [btn_back addTarget:self action:@selector(backbutton:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(UIColor*) generateColor{
    
    UIColor * color = [UIColor colorWithRed:arc4random_uniform(255)/255.0f
                                      green:arc4random_uniform(255)/255.0f
                                       blue:arc4random_uniform(255)/255.0f
                                      alpha:(1)];
    
    return color;
}
-(void)backbutton: (UIButton*)button{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void) buttonClick:(UIButton*)button{
    _count = [[self.navigationController viewControllers]count];
    _count++;
    MyNavController *vc1 = [[MyNavController alloc]init:_count];
    vc1.view.backgroundColor = [vc1 generateColor];
    [self.navigationController pushViewController:vc1 animated:YES];
    
    // Do any additional setup after loading the view.
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
