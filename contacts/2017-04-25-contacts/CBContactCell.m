//
//  CBContactCellTableViewCell.m
//  2017-04-25-contacts
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "CBContactCell.h"
#import "CBContact.h"
#import "CBAvatarView.h"
#import <Masonry/Masonry.h>
#import <QuartzCore/QuartzCore.h>


NSString *const CBContactCellIdentifier = @"CBContactCellIdentifier";

@interface CBContactCell ()

@property(nonatomic, strong) UILabel *firstNameLabel;
@property(nonatomic, strong) UILabel *lastNameLabel;
@property(nonatomic, strong) CBAvatarView *avatarView;
@end


@implementation CBContactCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self createSubviewsWithContact];
    }
    return self;
}


- (void)createSubviewsWithContact {
    _firstNameLabel = [UILabel new];
    _lastNameLabel = [UILabel new];
    _avatarView = [CBAvatarView new];
    
    [self addSubview:_firstNameLabel];
    [self addSubview:_lastNameLabel];
    [self addSubview:_avatarView];
    
    [_avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        
        make.width.equalTo(self.mas_height);
        make.height.equalTo(self.mas_height);
        
    }];
    
    [_firstNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatarView.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_centerY);
        
        make.right.equalTo(self.mas_right);
    }];
    
    [_lastNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatarView.mas_right);
        make.top.equalTo(self.mas_centerY);
        make.bottom.equalTo(self.mas_bottom);
        
        make.right.equalTo(self.mas_right);
    }];
}

- (void)addContact:(CBContact *)contact {
    self.firstNameLabel.text = contact.firstName;
    self.lastNameLabel.text = contact.lastName;
    
    NSURL *url = [[NSURL alloc]initWithString:contact.urlImage];
    CIImage* im = [[CIImage alloc] initWithContentsOfURL:url];
    self.avatarView.image = [[UIImage alloc] initWithCIImage:im];
}


+ (CGFloat)heightForCell {
    return 80;
}

@end
