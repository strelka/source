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

//- (void)addBackButtonWithImageName:(NSString *)imageName {
//    // init your custom button, or your custom view
//    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    backButton.frame = CGRectMake(0, 0, 40, 22); // custom frame
//    [backButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
//    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    
////    // set left barButtonItem with custom view
//    self.navigationItem.titleView = [SPFTopNavigationView new];
////}


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
    //_topNavView.backgroundColor = [UIColor magentaColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_topNavView];
    [self initConstraints];
//    NSLog(@"start");
//    [self dumpAllFonts];
//    NSLog(@"end");
    
}

- (void) dumpAllFonts {
    for (NSString *familyName in [UIFont familyNames]) {
        for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
            NSLog(@"%@", fontName);
        }
    }
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
    
//    [_topNavView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(_detailView.mas_right);
//        make.left.equalTo(_detailView.mas_left);
//        make.bottom.equalTo(self.mas_topLayoutGuideBottom);
//        make.top.equalTo(self.mas_topLayoutGuideTop);
//    }];
}

@end
