//
//  SPFDetailViewController.m
//  ShowFlicrImage
//
//  Created by Jullia Sharaeva on 31.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "SPFDetailViewController.h"
#import "SPFPicture.h"
#import "SPFComment.h"

#import "SPFCommentCell.h"

#import <Masonry/Masonry.h>

#import "SPFDetailView.h"
#import "SPFTopNavigationView.h"
#import "NSURL+Caching.h"

#import "SPFGetCommentsOperation.h"
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
    
    
    _detailView = [[SPFDetailView alloc] init];
    _tableView = _detailView.commentTableView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerClass:[SPFCommentCell class] forCellReuseIdentifier:@"SPFCellCommentIdentifier"];
    
    _topNavView = [[SPFTopNavigationView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 32)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_topNavView];
    self.navigationItem.leftItemsSupplementBackButton = YES;
    
    [self.view addSubview:_imgView];
    [self.view addSubview:_detailView];
    [self getCommentsForImage];
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
    [(SPFCommentCell*)cell authorLabel].text = comment.authorName;
    
    
    UIImage *tmpImage = [comment.avatarUrl getImageFromCache]; //[UIImage imageNamed:@"defaultAv"];

    [(SPFCommentCell*)cell imageView].image = tmpImage;
    //[(SPFCommentCell*)cell imageView].contentMode = UIViewContentModeScaleAspectFill;
    [(SPFCommentCell*)cell imageView].layer.cornerRadius = 24;
    [(SPFCommentCell*)cell imageView].layer.masksToBounds = YES;
    [(SPFCommentCell*)cell imageView].contentMode = UIViewContentModeScaleAspectFill;
    [(SPFCommentCell*)cell imageView].clipsToBounds = YES;
        
     if (nil == cell.imageView.image){
        [self getAvatarForCommentWithURL:comment.avatarUrl byIndex:indexPath];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return MIN(3, [_comments count]);
}


@end
