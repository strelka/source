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
#import "MFBAnnotation.h"

#import "MFBMapTableDelegate.h"
#import "MFBCustomAtmCell.h"
@interface MFBTableViewController ()
@property (nonatomic, strong) NSArray* poiArray;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) id service;
@property (nonatomic, strong) dispatch_queue_t queue;

@property (nonatomic, weak) id tableDelegate;
@end

@implementation MFBTableViewController

- (instancetype) initWithDelegate:(id)tableDelegate{
    self = [super init];
    if (self) {
        _tableDelegate = tableDelegate;
    }
    return self;
}


-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    _poiArray = [_tableDelegate poiArray];
    if (self.tableView){
        [self.tableView reloadData];
    }
    
//    dispatch_queue_t queue1 = dispatch_queue_create("ru.js.distance", DISPATCH_QUEUE_CONCURRENT);
//
//    dispatch_async(queue1, ^{
//        [_service getDistanceFromPoint:[_tableDelegate getCurrentUserCoordinate]
//                              ToPoints:_poiArray
//                               andMode:@"driving"
//                         andComplition:^() {
//                             dispatch_async(dispatch_get_main_queue(), ^{
//                                 [_tableView reloadData];
//                             });
//        }];
//    });
//    
//    dispatch_queue_t queue2 = dispatch_queue_create("ru.js.distance", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(queue2, ^{
//        [_service getDistanceFromPoint:[_tableDelegate getCurrentUserCoordinate]
//                              ToPoints:_poiArray
//                               andMode:@"walking"
//                         andComplition:^() {
//                             dispatch_async(dispatch_get_main_queue(), ^{
//                                 [_tableView reloadData];
//                             });
//                         }];
//                 });
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *headerView = [UIView new];
    headerView.backgroundColor = [UIColor lightGrayColor];
    
    _tableView = [UITableView new];
    _tableView.delegate = _tableDelegate;
    _tableView.dataSource = _tableDelegate;
    
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(50);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    _service = [[MFBGetDataFromGoogle alloc] init];
    [_tableView registerClass:[MFBCustomAtmCell class] forCellReuseIdentifier:@"TableItem"];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//


@end
