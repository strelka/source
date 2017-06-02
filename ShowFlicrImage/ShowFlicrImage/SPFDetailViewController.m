//
//  SPFDetailViewController.m
//  ShowFlicrImage
//
//  Created by Jullia Sharaeva on 31.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "SPFDetailViewController.h"
#import "SPFPicture.h"
#import <Masonry/Masonry.h>

#import "SPFDetailView.h"
#import "SPFTopNavigationView.h"

@interface SPFDetailViewController ()
@property (nonatomic, strong) SPFPicture *picture;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) SPFDetailView *detailView;
@property (nonatomic, strong) SPFTopNavigationView *topNavView;


@end

@implementation SPFDetailViewController

- (instancetype) initWithPicture:(SPFPicture*)pic{
    self = [super init];
    if (self){
        _picture = pic;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _imgView = [[UIImageView alloc] init];
    _detailView = [[SPFDetailView alloc] init];
    _imgView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_imgView];
    [self.view addSubview:_detailView];
    
    _topNavView = [[SPFTopNavigationView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 32)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_topNavView];

    self.navigationItem.leftItemsSupplementBackButton = YES;
    
    _imgView.image = [_picture  getImageFromCacheByUrl];
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

@end
