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

#import "UIImage+CroppingImage.h"

@interface SISViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (nonatomic, strong) NSArray* records;
@property (nonatomic, strong) id service;
@property (nonatomic, strong) UITableView* tableView;
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
    searchBar.delegate = self;
    searchBar.placeholder = @"song";
    [searchView addSubview:searchBar];
    
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchView.mas_left);
        make.right.equalTo(searchView.mas_right);
        make.height.equalTo(@60);
        make.bottom.equalTo(searchView.mas_bottom);
    }];
    
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(searchView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    [_tableView registerClass:[SISTableViewCell class] forCellReuseIdentifier:SISCellIdentifier];
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
    cell.collection.text = record.collectionCensoredName;
    cell.track.text = record.trackName;
    //cell.price.text = record.trackPrice;
    
    cell.imgUrl = record.artworkUrl;
    NSURL *imgUrl = record.artworkUrl;
    
    NSMutableDictionary *imgDict = [_records objectAtIndex:[indexPath row]];
    UIImage *tmpImg = [imgDict valueForKey:@"actualImage"];
    
    if (nil == tmpImg){
        [_service getImageFromItunes: imgUrl andComplition:^(NSURL *currentUrl, NSData *data) {
            if (cell.imgUrl == currentUrl){
                [imgDict setValue:[UIImage imageWithData:data] forKey:@"actualImage"];
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
    } else {
    
        tmpImg = [tmpImg cropBySqrSize];
        CGSize imgViewSize = cell.imgView.bounds.size;
        
        UIGraphicsBeginImageContext(CGSizeMake( imgViewSize.width, imgViewSize.height));
        [tmpImg drawInRect: CGRectMake(0, 0, imgViewSize.width, imgViewSize.height)];
        UIImage *small = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        cell.imgView.image = small;
        cell.backgroundColor = [UIColor whiteColor];
        cell.clipsToBounds = YES;
        }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *searchText = searchBar.text;
    searchText = [searchText stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    _service = [SISGetInfoFromItunes new];
    [_service getDataFromItunes:searchText andComplition:^(NSArray *data){
        _records = data;
        NSLog(@"reloadData");
        [_tableView reloadData];
    }];
}

@end
