//
//  ViewController1.m
//  ViewControllers
//
//  Created by Jullia Sharaeva on 12.04.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "ViewController1.h"
#import "randomColor.h"
#import "CustomCell.h"

@interface ViewController1 () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView* tableView;
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
        colors = [self generate_colors];
    }

    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [UITableView new];
    CGRect bounds = self.view.bounds;
    double root_width = bounds.size.width;
    double root_hight = bounds.size.height;
    
    self.tableView.frame = CGRectMake(0, 0, root_width, root_hight);
    
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    
    self.tableView.tableFooterView=[UIView new];
    self.tableView.allowsSelectionDuringEditing=NO;
    
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    UIBarButtonItem *edit = [[UIBarButtonItem alloc]
                             initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                             target:self
                             action:@selector(editing)];
    self.navigationItem.rightBarButtonItem = edit;
    
    
    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view.
}

-(void)editing{
    [self.tableView setEditing:!self.tableView.editing animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(BOOL) tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(UITableViewCellEditingStyle) tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return UITableViewCellEditingStyleInsert;
    } else{
        return UITableViewCellEditingStyleDelete;
        
    }
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        [colors removeObjectAtIndex:indexPath.row];
        [colors insertObject:[[randomColor alloc] init]
                     atIndex:indexPath.row];
        //[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
        //                 withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle==UITableViewCellEditingStyleInsert){
        [colors insertObject:[[randomColor alloc]init] atIndex:0];
        //[tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:
        //                                   UITableViewRowAnimationFade];
        [colors removeLastObject];
        //[tableView deleteRowsAt:[NSArray arrayWithObject:]
        //                 withRowAnimation:UITableViewRowAnimationFade];
    }
    [self.tableView reloadData];
    

}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [colors exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [colors count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.bounds.size.height/14;

}

-(NSMutableArray* )generate_colors{
    
    NSMutableArray* colorArray = [NSMutableArray new];
    int color_count = arc4random_uniform(12) + 2;
    for (int i = 0; i < color_count; i++){
        colorArray[i] = [[randomColor alloc]init];
    }
    
    return colorArray;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    CustomCell* cell = [[CustomCell alloc] initWithFrame:CGRectZero];
    
    randomColor* rcolor = colors[indexPath.row];
    
    cell.primaryLabel.backgroundColor = [UIColor colorWithRed:rcolor.red green:rcolor.green blue:rcolor.blue alpha:1];
    ;
    cell.secondaryLabel.text = [NSString stringWithFormat:@"%ld - %@", (long)indexPath.row,
                                [rcolor print]];
    
    cell.secondaryLabel.textColor=[UIColor blackColor];
    
    //cell.textLabel.text = [NSString stringWithFormat:@"%ld - %@", (long)indexPath.row,
    //                                                               [rcolor print]];
    //
    //cell.textLabel.textColor=[UIColor blackColor];
    //cell.backgroundColor = [UIColor colorWithRed:rcolor.red green:rcolor.green blue:rcolor.blue alpha:1];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = [UIViewController new];
    randomColor *coloritem = colors[indexPath.row];
    
    vc.view.backgroundColor = [UIColor colorWithRed:coloritem.red green:coloritem.green blue:coloritem.blue alpha:1];
    vc.navigationItem.title = [coloritem print];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
