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
@property (nonatomic, strong) id service;
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
    _service = [SISGetInfoFromItunes new];
    [_service getDataFromItunes:testSearch andComplition:^(NSArray *data){
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

    SISTableViewCell *cell = (SISTableViewCell *)[tableView dequeueReusableCellWithIdentifier: SISCellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[SISTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SISCellIdentifier];
    }
    SISComposition *record = self.records[indexPath.row];
    
    cell.artist.text = record.artistName;
    cell.collection.text = record.collectionName;
    cell.track.text = record.trackName;
    
    cell.imgUrl = record.artworkUrl;
//
    NSURL *imgUrl = record.artworkUrl;
    cell.imageView.image = [UIImage imageNamed:@"default.png"];
    NSMutableDictionary *imgDict = [_records objectAtIndex:[indexPath row]];
    if ([imgDict valueForKey:@"actualImage"]){
        cell.imageView.image = [imgDict valueForKey:@"actualImage"];
    }
    else {
        [_service getImageFromItunes: imgUrl andComplition:^(NSURL *currentUrl, NSData *data) {
            if (cell.imgUrl == currentUrl){
                [imgDict setValue:[UIImage imageWithData:data] forKey:@"actualImage"];
                cell.imageView.image = [imgDict valueForKey:@"actualImage"];
                [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

@end
