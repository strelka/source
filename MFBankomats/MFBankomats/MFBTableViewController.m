//
//  MFBTableViewController.m
//  MFBankomats
//
//  Created by Jullia Sharaeva on 10.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "MFBTableViewController.h"
#import <Masonry/Masonry.h>
#import "poiAtmList.h"
#import "MFBAnnotation.h"

@interface MFBTableViewController ()
@property (nonatomic, strong) NSArray* poiArray;
@property (nonatomic, strong) UITableView* tableView;
@end

@implementation MFBTableViewController

//-(void)viewWillAppear:(BOOL)animated{
//    [self viewWillAppear:YES];
//    _poiArray = [_poiList.poi allObjects];
//}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

    if (self.tableView){
        NSLog(@"-->%lu", (unsigned long)[_poiList countOfPoi]);
        _poiArray  = [[_poiList getPoiSet] allObjects];
        [self.tableView reloadData];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _poiArray  = [[NSArray alloc] initWithArray:[[_poiList getPoiSet] allObjects]];

    self.view.backgroundColor = [UIColor whiteColor];
    UIView *headerView = [UIView new];
    headerView.backgroundColor = [UIColor lightGrayColor];
    
    //UILabel *title = [UILabel new];
    //title.text = @"@%", [poiAtm count];
    
    _tableView = [UITableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
//    [headerView addSubview:title];
//    [self.view addSubview:headerView];
    [self.view addSubview:_tableView];
    
//    [title mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(headerView.mas_centerX);
//        make.centerY.equalTo(headerView.mas_centerY);
//    }];
//    
//    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top);
//        make.left.equalTo(self.view.mas_left);
//        make.right.equalTo(self.view.mas_right);
//        make.height.equalTo(@100);
//    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(50);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TableItem"];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_poiArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *TableIdentifier = @"TableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableIdentifier forIndexPath:indexPath];
    MFBAnnotation *annotation = _poiArray[indexPath.row];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableIdentifier];
    }
    
    cell.textLabel.text = annotation.title;
    
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MFBAnnotation *tmppoi = _poiArray[indexPath.row];
    _selectedPoi.coordinate = tmppoi.coordinate;
    _selectedPoi.title = tmppoi.title;
    _selectedPoi.color = [UIColor magentaColor];
    [self.tabBarController setSelectedIndex:0];

}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
