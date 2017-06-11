//
//  FVPViewControllerDetails.m
//  FVPcontacts
//
//  Created by Jullia Sharaeva on 11.06.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "FVPDetailsViewController.h"
#import "FVPContact.h"
#import "FVPDetailView.h"

#import <Masonry/Masonry.h>

@interface FVPDetailsViewController ()
@property (nonatomic, strong) FVPContact *contact;
@end

@implementation FVPDetailsViewController

- (instancetype)initWith:(FVPContact*) contact{
    self = [super init];
    if (self){
        _contact = contact;
    }
    return self;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    FVPDetailView *detailView = [[FVPDetailView alloc] init];
    detailView.familyLabel.text = _contact.lastName;
    detailView.nameLabel.text = _contact.firstName;
    detailView.imgView.image = _contact.avatarImg;
    [self.view addSubview:detailView];
    
    [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);

        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
