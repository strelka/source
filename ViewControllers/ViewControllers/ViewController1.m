//
//  ViewController1.m
//  ViewControllers
//
//  Created by Jullia Sharaeva on 12.04.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "ViewController1.h"
#import "randomColor.h"

@interface ViewController1 () <UITableViewDataSource, UITableViewDelegate>
//struct rand_color_struct{    float red;
//    float green;
//float blue;
//};
@end

@implementation ViewController1
{
    NSMutableArray* colors;
//    struct rand_color_struct rands_color;


}

-(instancetype)init{
    self = [super init];
    if (self){
        colors = [[NSMutableArray alloc]init];
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
    
    tableView.frame = CGRectMake(0 , 0, root_width, root_hight);
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.bounds.size.height/10;

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    randomColor *rcolor = [[randomColor alloc] init];
    
    [colors addObject:rcolor];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    
    cell.textLabel.text = [rcolor print];
    cell.textLabel.textColor=[UIColor blackColor];
    cell.backgroundColor = [UIColor colorWithRed:rcolor.red green:rcolor.green blue:rcolor.blue alpha:1];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //UIViewController *vc = [UIViewController new];
    //vc.view.backgroundColor = UIColor.redColor;
    //vc.navigationItem.title =[NSString stringWithFormat:@"%ld", (long)indexPath.row];
    //[self.navigationController pushViewController:vc animated:YES];

    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = [UIViewController new];
    randomColor *coloritem = colors[indexPath.row];
    
    vc.view.backgroundColor = [UIColor colorWithRed:coloritem.red green:coloritem.green blue:coloritem.blue alpha:1];
    vc.navigationItem.title = [coloritem print];
    [self.navigationController pushViewController:vc animated:YES];
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
