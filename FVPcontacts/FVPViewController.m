//
//  FVPViewController.m
//  FVPcontacts
//
//  Created by Jullia Sharaeva on 12.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "FVPViewController.h"
#import "FVPDetailsViewController.h"

#import "FVPGetDataFromVK.h"
#import "FVPGetFataFromFB.h"
#import "FVPGetDataFromPhoneBook.h"

#import "FVPContact.h"
#import "FVPContactCell.h"
#import "FVPLoginViewController.h"
#import <Masonry/Masonry.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "FVPPendingOperation.h"
#import "FVPGetImageByURL.h"


@interface FVPViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UIView *footerView;
@property (strong, nonatomic) UISegmentedControl *segmentControl;

@property (strong, nonatomic) NSArray *contacts;
@property (strong, nonatomic) FVPPendingOperation *operations;

@property (strong, nonatomic) id service;
@end

@implementation FVPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *backgroundColor = [[UIColor alloc] initWithRed:255.0/255.0 green:204.0/255.0 blue:229.0/255.0 alpha:1];
    UIColor *buttonColor = [[UIColor alloc] initWithRed:255.0/255.0 green:102.0/255.0 blue:178.0/255.0 alpha:1];
    
    _headerView = [UIView new];
    _tableView = [UITableView new];
    _footerView = [UIView new];
    _segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"VK", @"FB", @"Phone"]];
    [_segmentControl addTarget:self action:@selector(serviceChange:) forControlEvents:UIControlEventValueChanged];
    [_segmentControl setSelectedSegmentIndex:0];
    
    [self.view addSubview:_headerView];
    [self.view addSubview:_tableView];
    [self.view addSubview:_footerView];
    [_headerView addSubview:_segmentControl];
    
    _headerView.backgroundColor = backgroundColor;
    _tableView.backgroundColor = [UIColor whiteColor];
    _footerView.backgroundColor = backgroundColor;
    _segmentControl.tintColor = buttonColor;
    
    [self initConstraint];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _contacts = [[NSArray alloc] init];
    
    _operations = [[FVPPendingOperation alloc] init];
    [_tableView registerClass:[FVPContactCell class] forCellReuseIdentifier:@"tableCell"];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    _contacts = @[];
    [_tableView reloadData];
    
    if (_segmentControl.selectedSegmentIndex == 0) {
        [self loadVkData];
    }
    if (_segmentControl.selectedSegmentIndex == 1){
        [self loadFBData];
    }
    if (_segmentControl.selectedSegmentIndex == 2){
        [self loadPhoneData];
    }
}

- (void) initConstraint{
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@60);
    }];
    
    [_segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(_headerView.mas_top);
        make.bottom.equalTo(_headerView.mas_bottom);
    }];
    
    [_footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@60);
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom).with.offset(60);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop).with.offset(-60);
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_contacts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = (FVPContactCell*)[tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
    
    if (cell == nil){
        cell = [[FVPContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableCell"];
    }
    
    FVPContact *contact = _contacts[indexPath.row];
    FVPContactCell *fvpCell = (FVPContactCell*)cell;
    
    fvpCell.fioLabel.text = [[NSString alloc] initWithFormat:@"%@ %@", contact.firstName, contact.lastName];

    UIImage *imgAvt = contact.avatarImg;
    if (nil == imgAvt){
        [self startDownLoadForPhoto:contact byIndex:indexPath];
    } else {
        fvpCell.imgView.image = imgAvt;
        fvpCell.imgView.layer.cornerRadius = 15;
        fvpCell.imgView.layer.masksToBounds = YES;
        fvpCell.imgView.contentMode = UIViewContentModeScaleAspectFill;
        fvpCell.imgView.clipsToBounds = YES;
    }
    return fvpCell;
}

- (void) startDownLoadForPhoto:(FVPContact*)contact byIndex:(NSIndexPath*)indexPass{
    
    if (_operations.downloadsInProgress[indexPass]){
        return;
    }
    
    FVPGetImageByURL *downloader = [[FVPGetImageByURL alloc] initWithUrl:contact.imageUrl andComplitionBlock:^(NSData *data) {
        dispatch_async(dispatch_get_main_queue(), ^{
            contact.avatarImg = [UIImage imageWithData:data];
            [self.operations.downloadsInProgress removeObjectForKey:indexPass];
            [self.tableView reloadRowsAtIndexPaths:@[indexPass]
                                  withRowAnimation:UITableViewRowAnimationFade];
        });
    }];
    _operations.downloadsInProgress[indexPass] = downloader;
    [_operations.downloadQueue addOperation:downloader];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FVPContact *contact = _contacts[indexPath.row];
    FVPDetailsViewController *vcd = [[FVPDetailsViewController alloc] initWith:contact];
    [self.navigationController pushViewController:vcd animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)serviceChange:(UISegmentedControl *)segment{
    if (segment.selectedSegmentIndex == 0) {
        [self loadVkData];
    } else if (segment.selectedSegmentIndex == 1){
        [self loadFBData];
    } else if (segment.selectedSegmentIndex == 2){
        [self loadPhoneData];
    }
}

- (void) loadFBData{
    if (![FBSDKAccessToken currentAccessToken]) {
        FVPLoginViewController *loginVk = [[FVPLoginViewController alloc] initWithConnectingString: @"fbAuth"];
        [self presentViewController:loginVk animated:YES completion:nil];
    }
    _service = [FVPGetFataFromFB new];
    [_service getDataAndDoSuccessBlock:^(NSArray *data){
        _contacts = data;
        [_tableView reloadData];
    }];
    
}

- (void) loadPhoneData{
//    if (![FBSDKAccessToken currentAccessToken]) {
//        FVPLoginViewController *loginVk = [[FVPLoginViewController alloc] initWithConnectingString: @"fbAuth"];
//        [self presentViewController:loginVk animated:YES completion:nil];
//    }
    _service = [FVPGetDataFromPhoneBook new];
    [_service getDataAndDoSuccessBlock:^(NSArray *data){
        _contacts = data;
        [_tableView reloadData];
    }];
    
}

- (void) loadVkData{
    if (nil == [[NSUserDefaults standardUserDefaults] objectForKey:@"VKAccessToken"]){
        NSString *vkAuth = @"https://oauth.vk.com/authorize?client_id=5932466&display=page&redirect_uri=https://oauth.vk.com/blank.html&scope=friends&response_type=token&v=5.64&state=123456";

        FVPLoginViewController *loginVk = [[FVPLoginViewController alloc] initWithConnectingString: vkAuth];
        [self presentViewController:loginVk animated:YES completion:nil];
    }
    _service = [FVPGetDataFromVK new];
    [_service getDataAndDoSuccessBlock:^(NSArray *data){
        _contacts = data;
        [_tableView reloadData];
    }];
}


@end
