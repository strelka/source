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
#import "SPFGetListOfPicturesOperation.h"
#import "SPFDispetcherOperation.h"

#import "SPFCustomCell.h"

#import "PinterestLayout.h"

#define CELL_INENTIFIER = @"cell"

@interface SPFViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, SPFPinterestLayoutDelegate>

@property (nonatomic, strong) NSMutableDictionary *searchObject;
@property (nonatomic, strong) NSArray<SPFPicture*> *records;
@property (nonatomic, strong) SPFPendingOperations *operation;
@property (nonatomic, strong) id service;
@property (nonatomic, strong) UICollectionView* collectionView;

@property (nonatomic, strong) PinterestLayout *layout;
@property (nonatomic) CGSize size;


@property (nonatomic, strong) NSArray *cellSizes;
@property (nonatomic, strong) NSArray *colors;

@property(nonatomic, strong) NSString *searchText;

@end

@implementation SPFViewController
{
    BOOL loadingNewPage;
}

- (instancetype) init{
    self = [super init];
    if (self){
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Лента"
                                                        image:[[UIImage imageNamed:@"icFeed"] imageWithRenderingMode:UIImageRenderingModeAutomatic]
                                                selectedImage:[[UIImage imageNamed:@"icFeed"] imageWithRenderingMode:UIImageRenderingModeAutomatic]];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _size = self.view.bounds.size;
    _searchObject = [[NSMutableDictionary alloc] initWithObjects:@[@1, @""] forKeys:@[@"page", @"textForSearch"]];
    loadingNewPage = NO;
    
    _operation = [SPFPendingOperations new];
    
    _layout = [[PinterestLayout alloc] init];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:_layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [_collectionView registerClass:[SPFCustomCell class]
        forCellWithReuseIdentifier:@"SPFCellIdentifier"];
    
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.delegate = self;
    searchBar.placeholder = @"Поиск";
    [searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"rectangle121"] forState:UIControlStateNormal];
    
    UIButton *settings = [[UIButton alloc] init];
    [settings setImage:[UIImage imageNamed:@"icSettings"] forState:UIControlStateNormal];
    
    self.navigationItem.titleView = searchBar;
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icSettings"] style:UIBarButtonItemStyleDone target:self action:nil];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

- (NSArray *)cellSizes {
    if (!_cellSizes) {
        double widthStep = self.view.bounds.size.width/3;
        _cellSizes = @[
                       [NSValue valueWithCGSize:CGSizeMake(widthStep*2, widthStep*2)],
                       [NSValue valueWithCGSize:CGSizeMake(widthStep, widthStep)],
                       [NSValue valueWithCGSize:CGSizeMake(widthStep, widthStep)],
                       [NSValue valueWithCGSize:CGSizeMake(widthStep, widthStep)]
                       ];
    }
    return _cellSizes;
}

- (NSArray *)colors {
    if (!_colors) {
        _colors = @[[UIColor redColor], [UIColor blueColor], [UIColor grayColor], [UIColor magentaColor]];
    }
    return _colors;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return [_records count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SPFCustomCell *cell = (SPFCustomCell *)[collectionView dequeueReusableCellWithReuseIdentifier: @"SPFCellIdentifier" forIndexPath:indexPath];
    cell.label.text = [[NSString alloc] initWithFormat:@"%d",_records[indexPath.item].countLikes];
    
    SPFPicture *photo = _records[indexPath.item];
    cell.imageView.image = [photo getImageFromCacheByUrl];
    
    if (!(_operation.downloadsInProgress[indexPath])){
        [photo correctPictureState];
    }
        
    [self startOPerationsForPhotoRecord:photo byIndex:indexPath];
        
        
//    if ((photo.imageState == New){
//        [indicator startAnimating];
//    }
//    else if (photo.imageState == Downloaded){
//        [indicator startAnimating];
//        }
//    }
        

        
    //        if (photo.imageState == Downloaded){
    //            [(SPFCustomCell*)cell setCellImage:[photo getImageFromCacheByUrl]];
    //        //[[(SPFCustomCell*)cell progressBar ] setProgress:1];
    //        }
    //        if (photo.imageState == New){
    //            [(SPFCustomCell*)cell setCellImage:nil];
    //            //[[(SPFCustomCell*)cell progressBar ] setProgress:0];
    //        }
    //    }
    
    //    [(SPFCustomCell*) cell setImageToImageView];
    //
    //    if (photo.imageState == Filtered){
    //        [indicator stopAnimating];
    //    }
    //    else if (photo.imageState ==  Failed){
    //        [indicator stopAnimating];
    //    }
    //    else if ((photo.imageState == New) || (photo.imageState == Downloaded)){
    //        [indicator startAnimating];
    //    }
    //    [self startOPerationsForPhotoRecord:photo byIndex:indexPath];
    //    //    }
    //    return cell;
    return cell;
}

- (BOOL) isLargeItemInIndexPath:(NSIndexPath*)index{

    if (_records[index.item].countLikes >=100){
        return YES;
    }
    else return NO;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size;
    double width_step = self.collectionView.bounds.size.width/3;
    if (_records[indexPath.item].countLikes >=100){
        size = CGSizeMake(width_step*2, width_step*2);
    } else{
        size = CGSizeMake(width_step, width_step);
    }
    return size;
}


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    
//    UITableViewCell *cell = (SPFCustomCell *)[tableView dequeueReusableCellWithIdentifier: @"SPFCellIdentifier" forIndexPath:indexPath];
//    
//    if (cell == nil) {
//        cell = [[SPFCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SPFCellIdentifier"];
//    }
//    UIActivityIndicatorView *indicator;
//    if (nil == cell.accessoryView){
//        indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        cell.accessoryView = indicator;
//    }
//    
//    SPFPicture *photo = _records[indexPath.row];
//    [(SPFCustomCell*)cell setCellImage:[photo getFilteredImageFromCacheByUrl]];
//

//    if (!(_operation.downloadsInProgress[indexPath]||_operation.filtrationInProgress[indexPath])){
//        [photo correctPictureState];
//    
//        if (photo.imageState == Filtered){
//            [(SPFCustomCell*)cell setCellImage:[photo getFilteredImageFromCacheByUrl]];
//        //[[(SPFCustomCell*)cell progressBar ] setProgress:1];
//
//        }
//        if (photo.imageState == Downloaded){
//            [(SPFCustomCell*)cell setCellImage:[photo getImageFromCacheByUrl]];
//        //[[(SPFCustomCell*)cell progressBar ] setProgress:1];
//        }
//        if (photo.imageState == New){
//            [(SPFCustomCell*)cell setCellImage:nil];
//            //[[(SPFCustomCell*)cell progressBar ] setProgress:0];
//        }
//    }
    
//    [(SPFCustomCell*) cell setImageToImageView];
//    
//    if (photo.imageState == Filtered){
//        [indicator stopAnimating];
//    }
//    else if (photo.imageState ==  Failed){
//        [indicator stopAnimating];
//    }
//    else if ((photo.imageState == New) || (photo.imageState == Downloaded)){
//        [indicator startAnimating];
//    }
//    [self startOPerationsForPhotoRecord:photo byIndex:indexPath];
//    //    }
//    return cell;
//}

- (void) startOPerationsForPhotoRecord:(SPFPicture*)pic byIndex:(NSIndexPath*)indexPass{
    switch (pic.imageState) {
        case New:
            [self startDownLoadForPhoto:pic byIndex:indexPass];
            break;
        default:
           // NSLog(@"do nothing");
            break;
    }
}

- (void) startDownLoadForPhoto:(SPFPicture*)pic byIndex:(NSIndexPath*)indexPass{
    
    if (_operation.downloadsInProgress[indexPass]){
        return;
    }
    SPFDownloadingPictureOperation *downloader = [[SPFDownloadingPictureOperation alloc] initWithSPFPicture:pic andComplition:^(){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.operation.downloadsInProgress removeObjectForKey:indexPass];
            [self.collectionView reloadItemsAtIndexPaths:@[indexPass]];
        });
    }];
    
    _operation.downloadsInProgress[indexPass] = downloader;
    [_operation.downloadQueue addOperation:downloader];
}
//
//- (void) startFiltrationForPhoto:(SPFPicture*)pic byIndex:(NSIndexPath*)indexPass{
//    
//    if (_operation.filtrationInProgress[indexPass]){
//        return;
//    }
//    
//    [pic correctPictureState];
//    if (Downloaded != pic.imageState){
//        return;
//    }
//    SPFFiltrationPictureOperation *filterer = [[SPFFiltrationPictureOperation alloc] initWithSPFPicture:pic];
//    __weak SPFFiltrationPictureOperation *weakFilterer = filterer;
//    filterer.completionBlock = ^{
//        __strong SPFFiltrationPictureOperation *strongFilterer = weakFilterer;
//        if (strongFilterer.isCancelled) return;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.operation.filtrationInProgress removeObjectForKey:indexPass];
//            [self.tableView reloadRowsAtIndexPaths:@[indexPass] withRowAnimation:UITableViewRowAnimationFade];
//        });
//    };
//    
//    _operation.filtrationInProgress[indexPass] = filterer;
//    [_operation.filtrationQueue addOperation:filterer];
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return self.tableView.bounds.size.height/3;
//}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    NSLog(@"searchBarSearchButtonClicked");
    NSString *newText = searchBar.text;
    
    if(![self.searchText isEqualToString:newText]){
        self.searchText = [[NSString alloc] initWithString:newText];
        [self.view endEditing:YES];
        newText = [newText stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [self startGetListOfPictures:newText andPage:1];
    }
}

- (void) startGetListOfPictures:(NSString*)searchText andPage:(int)page{
    NSLog(@"startGetList %@", searchText);
    
    SPFGetListOfPicturesOperation *downloader = [[SPFGetListOfPicturesOperation alloc] initWithSearch:searchText andPage:1];
//    
    downloader.pictures = [[NSMutableArray alloc] init];
    [_operation.downloadQueue addOperation:downloader];
////    
    SPFDispetcherOperation *dispetcher = [[SPFDispetcherOperation alloc] initWithPictures:downloader.pictures];
    dispetcher.completionBlock = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            _records = downloader.pictures;
            [_collectionView reloadData];
        });
    };
    
    [dispetcher addDependency:downloader];
    [_operation.downloadQueue addOperation:dispetcher];
}

//- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    if (!loadingNewPage){
//        CGPoint offset = scrollView.contentOffset;
//        CGRect bounds = scrollView.bounds;
//        CGSize size = scrollView.contentSize;
//        UIEdgeInsets inset = scrollView.contentInset;
//        float y = offset.y + bounds.size.height - inset.bottom;
//        float h = size.height;
//        
//        float reload_distance = 40;
//        if(y > h + reload_distance) {
//            loadingNewPage = YES;
//            long currentPage = [_searchObject[@"page"] integerValue];
//            [_searchObject setValue:@(currentPage + 1) forKey:@"page"];
//            [_service getPicturesListByParam:_searchObject WithComplitionBlock:^(NSArray *data) {
//                NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithArray:_records];
//                [tmpArray addObjectsFromArray:data];
//                _records = [tmpArray copy];
//                tmpArray = nil;
//                loadingNewPage = NO;
//                [_tableView reloadData];
//            }];
//        }
//    }
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
