//
//  SPFDetailViewController.m
//  ShowFlicrImage
//
//  Created by Jullia Sharaeva on 31.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "SPFDetailViewController.h"
#import "SPFPinchViewController.h"
#import "SPFPicture.h"
#import "SPFComment.h"
#import "SPFUser.h"

#import "SPFCommentCell.h"

#import <Masonry/Masonry.h>

#import "SPFDetailView.h"
#import "SPFTopNavigationView.h"
#import "NSURL+Caching.h"

#import "SPFGetCommentsOperation.h"
#import "SPFGetDetailsOperation.h"
#import "SPFPendingOperations.h"
#import "SPFDownloadingPictureOperation.h"

@interface SPFDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) SPFPicture *picture;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) SPFDetailView *detailView;
@property (nonatomic, strong) SPFTopNavigationView *topNavView;
@property (nonatomic, strong) SPFGetCommentsOperation *getComments;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) SPFPendingOperations *operations;
@property (nonatomic, strong) NSArray<SPFComment*> *comments;

@end

@implementation SPFDetailViewController

- (instancetype) initWithPicture:(SPFPicture*)pic{
    self = [super init];
    if (self){
        _picture = pic;
        _comments = [[NSArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _imgView = [[UIImageView alloc] init];
    _imgView.image = [_picture.imgURL  getImageFromCache];
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    _imgView.clipsToBounds = YES;
    
    _imgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showModalController)];
    [_imgView addGestureRecognizer:singleTap];
    
    _detailView = [[SPFDetailView alloc] init];
    _tableView = _detailView.commentTableView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerClass:[SPFCommentCell class] forCellReuseIdentifier:@"SPFCellCommentIdentifier"];
    
    _topNavView = [[SPFTopNavigationView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 32)];
    
    //self.navigationController.navigationBar.backItem.b
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_topNavView];
//    
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:
                                              @"" style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.navigationItem.leftItemsSupplementBackButton = YES;
    
    [self.view addSubview:_imgView];
    [self.view addSubview:_detailView];
    [self getCommentsForImage];
    [self getDetailsForImage];
    [self initConstraints];
}

- (void) initConstraints{
    [_detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@350);
        make.bottom.equalTo(self.mas_bottomLayoutGuideBottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_detailView.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
    }];
}

- (void) getDetailsForImage{
    _operations = [[SPFPendingOperations alloc] init];
    
    SPFGetDetailsOperation *getDetailsOperation = [[SPFGetDetailsOperation alloc] initDetailsForImage:_picture AndComplition:^(){
         dispatch_async(dispatch_get_main_queue(), ^{
             [_topNavView setAuthor:_picture.owner.userName AndLocation:_picture.owner.userLocation];
             _detailView.descLabel.text = _picture.desc;
             _detailView.likeLabel.text = [[NSString alloc] initWithFormat:@"%ld", _picture.countViews];
             _detailView.commentLabel.text = [[NSString alloc] initWithFormat:@"%d", _picture.countComments];
            
             if (nil == _picture.owner.avatarImgUrl){
                [_topNavView setAvatarImage:[UIImage imageNamed:@"flickr-logo"]];
             } else {
                NSData * imageData = [[NSData alloc] initWithContentsOfURL: _picture.owner.avatarImgUrl];
                [_topNavView setAvatarImage:[UIImage imageWithData:imageData]];
             }
         });
    }];
    [_operations.downloadQueue addOperation:getDetailsOperation];
    
//    SPFDownloadingPictureOperation *downloader = [[SPFDownloadingPictureOperation alloc] initWithUrl:_picture.owner.avatarImgUrl andComplition:^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [_topNavView setAvatarImage:[_picture.owner.avatarImgUrl getImageFromCache]];
//        });
//    }];
//    
//    [downloader addDependency:getDetailsOperation];
//    [_operations.downloadQueue addOperation:downloader];


}
- (void) getCommentsForImage {
    _operations = [[SPFPendingOperations alloc] init];
    
    SPFGetCommentsOperation *getCommentOperation = [[SPFGetCommentsOperation alloc] initCommentForImageId:_picture.idImg AndComplition:^(NSArray<SPFComment*>* data){
        dispatch_async(dispatch_get_main_queue(), ^{
            _comments = data;
            [_tableView reloadData];
        });
    }];
    [_operations.downloadQueue addOperation:getCommentOperation];
}

- (void) getAvatarForCommentWithURL:(NSURL*)url byIndex:(NSIndexPath*) indexPath{
    _operations = [[SPFPendingOperations alloc] init];
    
    SPFDownloadingPictureOperation *getAvatarForComment = [[SPFDownloadingPictureOperation alloc] initWithUrl:url andComplition:^(){
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        });
    }];
    [_operations.downloadQueue addOperation:getAvatarForComment];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = (SPFCommentCell*)[tableView dequeueReusableCellWithIdentifier:@"SPFCellCommentIdentifier" forIndexPath:indexPath];
    
    if (cell == nil){
        cell = [[SPFCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SPFCellCommentIdentifier"];
    }
    SPFComment *comment = _comments[indexPath.row];
    
    [(SPFCommentCell*)cell commentLabel].text = comment.content;
    [(SPFCommentCell*)cell authorLabel].text = comment.author.userName;
    
    
    UIImage *tmpImage = [comment.author.avatarImgUrl getImageFromCache];
    
    [(SPFCommentCell*)cell imageView].image = tmpImage;
    [(SPFCommentCell*)cell imageView].layer.cornerRadius = 24;
    [(SPFCommentCell*)cell imageView].layer.masksToBounds = YES;
    [(SPFCommentCell*)cell imageView].contentMode = UIViewContentModeScaleAspectFill;
    [(SPFCommentCell*)cell imageView].clipsToBounds = YES;
        
     if (nil == [(SPFCommentCell*)cell imageView].image){
         if (nil == comment.author.avatarImgUrl){
             cell.imageView.image = [UIImage imageNamed:@"flickr-logo"];
         } else {
             [self getAvatarForCommentWithURL:comment.author.avatarImgUrl byIndex:indexPath];
         }
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return MIN(3, [_comments count]);
}

- (void) showModalController{
    
    SPFPinchViewController *modalViewController = [[SPFPinchViewController alloc] initWithImage:[_picture.imgURL getImageFromCache]];

    modalViewController.providesPresentationContextTransitionStyle = YES;
        modalViewController.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0  alpha:0.5];
    modalViewController.view.opaque = YES;
    modalViewController.definesPresentationContext = YES;
    [modalViewController setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    
    [self.navigationController presentViewController:modalViewController animated:NO completion:nil];
}

@end
