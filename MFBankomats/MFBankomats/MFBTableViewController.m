//
//  MFBTableViewController.m
//  MFBankomats
//
//  Created by Jullia Sharaeva on 10.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "MFBTableViewController.h"
#import <Masonry/Masonry.h>

#import "MFBGetDataFromGoogle.h"
#import "poiAtmList.h"
#import "MFBAnnotation.h"

@interface MFBTableViewController ()
@property (nonatomic, strong) NSArray* poiArray;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) id service;
@end

@implementation MFBTableViewController
-(instancetype) initWithLocationManager:(CLLocationManager*)locationManager{
    self = [super init];
    if (self){
        _locationManager = locationManager;
    } 
    return self;
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

    if (self.tableView){
        NSLog(@"-->%lu", (unsigned long)[_poiList countOfPoi]);
        _poiArray  = [[_poiList getPoiSet] allObjects];
        [self.tableView reloadData];
        
        dispatch_queue_t queue = dispatch_queue_create("ru.js.distance", DISPATCH_QUEUE_CONCURRENT);

        dispatch_async(queue, ^{
            [_service getDistanceFromPoint:_locationManager.location ToPoints:_poiArray andComplition:^{
                NSLog(@"reload");
                [_tableView reloadData];
            }];
        });
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _poiArray  = [[NSArray alloc] initWithArray:[[_poiList getPoiSet] allObjects]];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *headerView = [UIView new];
    headerView.backgroundColor = [UIColor lightGrayColor];
    
    _tableView = [UITableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _service  = [MFBGetDataFromGoogle new];

    [self.view addSubview:_tableView];
    
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
    
    cell.textLabel.font = [UIFont systemFontOfSize:8];
    
    NSString *tl = [[NSString alloc] initWithFormat:@"%@[auto: %f][walk: %f]", annotation.title, annotation.carDistance, annotation.walkingDistance];
    cell.textLabel.text = tl;
    
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
@end
