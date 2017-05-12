//
//  FVPViewController.m
//  FVPcontacts
//
//  Created by Jullia Sharaeva on 12.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "FVPViewController.h"
#import <Masonry/Masonry.h>

@interface FVPViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UIView *footerView;
@property (strong, nonatomic) UISegmentedControl *segmentControl;
@end

@implementation FVPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *backgroundColor = [[UIColor alloc] initWithRed:255.0/255.0 green:204.0/255.0 blue:229.0/255.0 alpha:1];
    UIColor *buttonColor = [[UIColor alloc] initWithRed:255.0/255.0 green:102.0/255.0 blue:178.0/255.0 alpha:1];
    
    _headerView = [UIView new];
    _tableView = [UITableView new];
    _footerView = [UIView new];
    _segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"VK", @"FB", @"Phone"]];
    
    [self.view addSubview:_headerView];
    [self.view addSubview:_tableView];
    [self.view addSubview:_footerView];
    [_headerView addSubview:_segmentControl];
    
    _headerView.backgroundColor = backgroundColor;
    _tableView.backgroundColor = [UIColor whiteColor];
    _footerView.backgroundColor = backgroundColor;
    _segmentControl.tintColor = buttonColor;
    
    [self initConstraint];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
}


- (void) initConstraint{
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@60);
    }];
    
    [_segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(_headerView.mas_top);
        make.bottom.equalTo(_headerView.mas_bottom);
    }];
    
    [_footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@60);
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom).with.offset(60);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop).with.offset(-60);
    }];

    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
