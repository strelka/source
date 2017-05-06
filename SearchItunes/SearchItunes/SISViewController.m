//
//  SISUIViewController.m
//  SearchItunes
//
//  Created by Jullia Sharaeva on 05.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "SISViewController.h"
#import <Masonry/Masonry.h>
#import "SISGetInfoFromItunes.h"
#import "SISTableViewCell.h"
#import "SISComposition.h"

@interface SISViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray* records;
@end

@implementation SISViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *searchView = [[UIView alloc] init];
    [self.view addSubview:searchView];
    
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.height.equalTo(@100); }];
    
    [searchView setBackgroundColor:[UIColor magentaColor]];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    [searchView addSubview:searchBar];
    
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchView.mas_left);
        make.right.equalTo(searchView.mas_right);
        make.height.equalTo(@60);
        make.bottom.equalTo(searchView.mas_bottom);
    }];
    [searchBar setBackgroundColor:[UIColor magentaColor]];
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchView.mas_left);
        make.right.equalTo(searchView.mas_right);
        make.top.equalTo(searchView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    NSString *testSearch = @"jack+johnson";
    SISGetInfoFromItunes *service = [SISGetInfoFromItunes new];
    [service getDataFromItunes:testSearch andComplition:^(NSArray *data) {
        _records = data;
        [tableView reloadData];
    }];
    
    [tableView registerClass:[SISTableViewCell class] forCellReuseIdentifier:SISCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%lu", (unsigned long)[_records count]);
    return [_records count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = (SISTableViewCell *)[tableView dequeueReusableCellWithIdentifier: SISCellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[SISTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SISCellIdentifier];
    }
    SISComposition *record = self.records[indexPath.row];
    [(SISTableViewCell*) cell addRecord:record];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

@end
