//
//  SPFViewController.m
//  ShowPictureFromFlickr
//
//  Created by Jullia Sharaeva on 20.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//
#import <Masonry/Masonry.h>

#import "SPFPicture.h"
#import "SPFViewController.h"
#import "SPFPendingOperations.h"
#import "SPFGetListOfPicturesFromFlickr.h"
#import "SPFDownloadingPictureOperation.h"
#import "SPFFiltrationPictureOperation.h"
#import "SPFCustomCell.h"


@interface SPFViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (nonatomic, strong) NSMutableDictionary *searchObject;
@property (nonatomic, strong) NSArray<SPFPicture*> *records;
@property (nonatomic, strong) SPFPendingOperations *operation;
@property (nonatomic, strong) id service;
@property (nonatomic, strong) UITableView* tableView;
@end

@implementation SPFViewController
{
    BOOL loadingNewPage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _searchObject = [[NSMutableDictionary alloc] initWithObjects:@[@1, @""] forKeys:@[@"page", @"textForSearch"]];
    loadingNewPage = NO;
    
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
    
    [_tableView registerClass:[SPFCustomCell class] forCellReuseIdentifier:@"SPFCellIdentifier"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // NSLog(@"%lu", (unsigned long)[_records count]);
    return [_records count];
}

//- (UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath:(NSIndexPath *){
//    
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = (SPFCustomCell *)[tableView dequeueReusableCellWithIdentifier: @"SPFCellIdentifier" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[SPFCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SPFCellIdentifier"];
    }
    UIActivityIndicatorView *indicator;
    if (nil == cell.accessoryView){
        indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        cell.accessoryView = indicator;
    }
    
    SPFPicture *photo = _records[indexPath.row];
    
    if (!(_operation.downloadsInProgress[indexPath]||_operation.filtrationInProgress[indexPath])){
        [photo correctPictureState];
    
        if (photo.imageState == Filtered){
            [(SPFCustomCell*)cell setCellImage:[photo getFilteredImageFromCacheByUrl]];
            [[(SPFCustomCell*)cell progressBar ] setProgress:1];
        }
        if (photo.imageState == Downloaded){
            [(SPFCustomCell*)cell setCellImage:[photo getImageFromCacheByUrl]];
            [[(SPFCustomCell*)cell progressBar ] setProgress:1];
        }
        if (photo.imageState == New){
            [(SPFCustomCell*)cell setCellImage:nil];
            [[(SPFCustomCell*)cell progressBar ] setProgress:0];
        }
    }
    
    [(SPFCustomCell*) cell setImageToImageView];
    
    if (photo.imageState == Filtered){
        [indicator stopAnimating];
    }
    else if (photo.imageState ==  Failed){
        [indicator stopAnimating];
    }
    else if ((photo.imageState == New) || (photo.imageState == Downloaded)){
        [indicator startAnimating];
    }
    
    [self startOPerationsForPhotoRecord:photo byIndex:indexPath];

    return cell;
}

- (void) startOPerationsForPhotoRecord:(SPFPicture*)pic byIndex:(NSIndexPath*)indexPass{
    switch (pic.imageState) {
        case New:
            [self startDownLoadForPhoto:pic byIndex:indexPass];
            break;
        case Downloaded:
            [self startFiltrationForPhoto:pic byIndex:indexPass];
            break;
        default:
            break;
    }
}

- (void) startDownLoadForPhoto:(SPFPicture*)pic byIndex:(NSIndexPath*)indexPass{
    
    if (_operation.downloadsInProgress[indexPass]){
        return;
    }
    
    if (New != pic.imageState){
        return;
    }
    
    SPFDownloadingPictureOperation *downloader = [[SPFDownloadingPictureOperation alloc] initWithSPFPicture:pic andComplition:^(){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.operation.downloadsInProgress removeObjectForKey:indexPass];
            [self.tableView reloadRowsAtIndexPaths:@[indexPass] withRowAnimation:UITableViewRowAnimationFade];
        });
    }];
    
    downloader.updateProgressBarBlock = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[[self.tableView cellForRowAtIndexPath:indexPass] progressBar] setProgress:pic.loadedPart];
        });
    };
    
    
    _operation.downloadsInProgress[indexPass] = downloader;
    [_operation.downloadQueue addOperation:downloader];
    //downloader.cancelled
}

- (void) startFiltrationForPhoto:(SPFPicture*)pic byIndex:(NSIndexPath*)indexPass{
    
    if (_operation.filtrationInProgress[indexPass]){
        return;
    }
    
    [pic correctPictureState];
    if (Downloaded != pic.imageState){
        return;
    }
    SPFFiltrationPictureOperation *filterer = [[SPFFiltrationPictureOperation alloc] initWithSPFPicture:pic];
    __weak SPFFiltrationPictureOperation *weakFilterer = filterer;
    filterer.completionBlock = ^{
        __strong SPFFiltrationPictureOperation *strongFilterer = weakFilterer;
        if (strongFilterer.isCancelled) return;
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
    return 400;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self.view endEditing:YES];
    NSString *searchText = searchBar.text;
    searchText = [searchText stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [_searchObject setValue:searchText forKey:@"textForSearch"];
    _service = [SPFGetListOfPicturesFromFlickr new];
    [_service getPicturesListByParam:_searchObject WithComplitionBlock:^(NSArray *data) {
        _records = data;
        [_tableView reloadData];
    }];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (!loadingNewPage){
        CGPoint offset = scrollView.contentOffset;
        CGRect bounds = scrollView.bounds;
        CGSize size = scrollView.contentSize;
        UIEdgeInsets inset = scrollView.contentInset;
        float y = offset.y + bounds.size.height - inset.bottom;
        float h = size.height;
        
        float reload_distance = 40;
        if(y > h + reload_distance) {
            loadingNewPage = YES;
            long currentPage = [_searchObject[@"page"] integerValue];
            [_searchObject setValue:@(currentPage + 1) forKey:@"page"];
            [_service getPicturesListByParam:_searchObject WithComplitionBlock:^(NSArray *data) {
                NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithArray:_records];
                [tmpArray addObjectsFromArray:data];
                _records = [tmpArray copy];
                tmpArray = nil;
                loadingNewPage = NO;
                [_tableView reloadData];
            }];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"scrollViewDidEndDragging");
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidEndDecelerating");
    
    NSArray *visCells = [_tableView indexPathsForVisibleRows];
    [_operation.downloadsInProgress[visCells[0]] cancel];
    NSLog(@"ff");
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
