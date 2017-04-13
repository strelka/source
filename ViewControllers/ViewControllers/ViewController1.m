//
//  ViewController1.m
//  ViewControllers
//
//  Created by Jullia Sharaeva on 12.04.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "ViewController1.h"

@interface ViewController1 () <UITableViewDataSource, UITableViewDelegate>
struct rand_color_struct{
    float red;
    float green;
    float blue;
};
@end

@implementation ViewController1
{
    NSMutableArray* colors;
    struct rand_color_struct rands_color;


}

-(instancetype)init{
    
    if (self){
        self.tabBarItem.title = @"TableView";
    }

    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *tableView = [UITableView new];
    CGRect bounds = self.view.bounds;
    double root_width = bounds.size.width;
    double root_hight = bounds.size.height;
    double step_width = bounds.size.width/10;
    double step_hight = 20;
    
    tableView.frame = CGRectMake(step_width, step_hight, root_width-2*step_width, root_hight/2);
    tableView.layer.borderColor = [UIColor brownColor].CGColor;
    tableView.layer.borderWidth = 1;
    tableView.layer.cornerRadius = 10.0f;
    
    tableView.dataSource=self;
    tableView.delegate=self;
    
    tableView.tableFooterView=[UIView new];
    [self.view addSubview:tableView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIColor* color = [UIColor colorWithRed:rands_color.red
                                     green:rands_color.green
                                      blue:rands_color.blue alpha:1];
    
    [colors addObject:color];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:nil];
    cell.textLabel.text = [NSString stringWithFormat:@"(%.2f, %.2f, %.2f)", rands_color.red,
                                                                            rands_color.green,
                                                                            rands_color.blue];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = colors[indexPath.row];
    
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
