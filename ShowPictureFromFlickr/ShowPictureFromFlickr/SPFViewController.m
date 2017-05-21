//
//  SPFViewController.m
//  ShowPictureFromFlickr
//
//  Created by Jullia Sharaeva on 20.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "SPFViewController.h"

#import <Masonry/Masonry.h>
#import "SPFPicture.h"
#import "SPFPendingOperations.h"
#import "SPFGetListOfPicturesFromFlickr.h"

#import "SPFDownloadingPictureOperation.h"
#import "SPFFiltrationPictureOperation.h"


@interface SPFViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (nonatomic, strong) NSArray<SPFPicture*> *records;
@property (nonatomic, strong) SPFPendingOperations *operation;
@property (nonatomic, strong) id service;
@property (nonatomic, strong) UITableView* tableView;
@end

@implementation SPFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _operation = [SPFPendingOperations new];
    
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
    searchBar.placeholder = @"picture";
    [searchView addSubview:searchBar];
    
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchView.mas_left);
        make.right.equalTo(searchView.mas_right);
        make.height.equalTo(@60);
        make.bottom.equalTo(searchView.mas_bottom);
    }];
    [searchBar setBackgroundColor:[UIColor magentaColor]];
    
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchView.mas_left);
        make.right.equalTo(searchView.mas_right);
        make.top.equalTo(searchView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%lu", (unsigned long)[_records count]);
    return [_records count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier: @"CellIdentifier" forIndexPath:indexPath];
    
//    if (cell == nil) {
//        cell = [[SISTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SISCellIdentifier];
//    }
    UIActivityIndicatorView *indicator;
    if (nil == cell.accessoryView){
        indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        cell.accessoryView = indicator;
    }
    
    SPFPicture *photo = _records[indexPath.row];
    cell.imageView.image = photo.image;
    if (photo.recordState == Filtered){
        [indicator stopAnimating];
    }
    else if (photo.recordState ==  Failed){
        [indicator stopAnimating];
    }
    else if ((photo.recordState == New) || (photo.recordState == Downloaded)){
        [indicator startAnimating];
    }
    
    if ((!tableView.isDragging)&&(!tableView.decelerating)){
        [self startOPerationsForPhotoRecord:photo byIndex:indexPath];
        
    }
    return cell;
}

- (void) startOPerationsForPhotoRecord:(SPFPicture*)pic byIndex:(NSIndexPath*)indexPass{
    switch (pic.recordState) {
        case New:
            [self startDownLoadForPhoto:pic byIndex:indexPass];
            break;
        case Downloaded:
            [self startFiltrationForPhoto:pic byIndex:indexPass];
            break;
            
        default:
            NSLog(@"do nothing");
            break;
    }
}

- (void) startDownLoadForPhoto:(SPFPicture*)pic byIndex:(NSIndexPath*)indexPass{
    
    if (_operation.downloadsInProgress[indexPass]){
        return;
    }
    SPFDownloadingPictureOperation *downloader = [[SPFDownloadingPictureOperation alloc] initWithSPFPicture:pic];
    downloader.completionBlock = ^{
        if (downloader.isCancelled) return;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.operation.downloadsInProgress removeObjectForKey:indexPass];
            [self.tableView reloadRowsAtIndexPaths:@[indexPass] withRowAnimation:UITableViewRowAnimationFade];
        });
    };
    
    _operation.downloadsInProgress[indexPass] = downloader;
    [_operation.downloadQueue addOperation:downloader];
}

- (void) startFiltrationForPhoto:(SPFPicture*)pic byIndex:(NSIndexPath*)indexPass{
    
    if (_operation.filtrationInProgress[indexPass]){
        return;
    }
    
    SPFFiltrationPictureOperation *filterer = [[SPFFiltrationPictureOperation alloc] initWithSPFPicture:pic];
    filterer.completionBlock = ^{
        if (filterer.isCancelled) return;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.operation.filtrationInProgress removeObjectForKey:indexPass];
            [self.tableView reloadRowsAtIndexPaths:@[indexPass] withRowAnimation:UITableViewRowAnimationFade];
        });
    };
    
    _operation.filtrationInProgress[indexPass] = filterer;
    [_operation.filtrationQueue addOperation:filterer];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.tableView.bounds.size.height/3;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *searchText = searchBar.text;
    searchText = [searchText stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    _service = [SPFGetListOfPicturesFromFlickr new];
    [_service getPicturesListByName:@"Cat" WithComplitionBlock:^(NSArray *data) {
        _records = data;
        [_tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
