//
//  CustomAtmCell.m
//  MFBankomats
//
//  Created by Jullia Sharaeva on 08.06.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "MFBCustomAtmCell.h"
#import <Masonry/Masonry.h>
NSString *const MFBCellIdentifier = @"MFBCellIdentifier";
@interface MFBCustomAtmCell()
@property (nonatomic, strong) UIImageView *atmIco;

@property (nonatomic, strong) UIImageView *walkIco;
@property (nonatomic, strong) UIImageView *autoIco;

@end

@implementation MFBCustomAtmCell
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self createSubviews];
        
    }
    return self;
}

- (void) createSubviews{
    _atmIco = [[UIImageView alloc] init];
    _walkIco = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"walkIco"]];
    _autoIco = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"autoIco"]];
    
    [self addSubview:self.atmIco];
    [self addSubview:self.address];
    [self addSubview:self.walkIco];
    [self addSubview:self.autoIco];
    [self addSubview:self.autoDistance];
    [self addSubview:self.walkDistance];
    
    
    [self initConstraints];
}

- (UILabel*)address{
    if (!_address){
        _address = [UILabel new];
        _address.lineBreakMode = NSLineBreakByWordWrapping;
        _address.font = [UIFont systemFontOfSize:14];
        _address.textColor = [UIColor darkGrayColor];
        _address.numberOfLines = 0;
        [_address sizeToFit];
        _address.textAlignment = NSTextAlignmentLeft;
    }
    return _address;
}

- (UILabel*)autoDistance{
    if (!_autoDistance){
        _autoDistance = [UILabel new];
        _autoDistance.font = [UIFont systemFontOfSize:8];
        _autoDistance.textAlignment = NSTextAlignmentLeft;
    }
    return _autoDistance;
}

- (UILabel*)walkDistance{
    if (!_walkDistance){
        _walkDistance = [UILabel new];
        _walkDistance.font = [UIFont systemFontOfSize:8];
        _walkDistance.textAlignment = NSTextAlignmentLeft;
    }
    return _walkDistance;
}


- (void) setAtmIcoFor:(int)openStatus{
    UIImage *atmImg;
    
    if (openStatus == -1) atmImg = [UIImage imageNamed:@"unknAtm"];
    if (openStatus ==  1) atmImg = [UIImage imageNamed:@"openAtm"];
    if (openStatus ==  0) atmImg = [UIImage imageNamed:@"closeAtm"];

    _atmIco.image = atmImg;
}


- (void) initConstraints{
    [_atmIco mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.height.equalTo(@30);
        make.width.equalTo(@30);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [_address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(35);
        make.right.equalTo(self.mas_right).with.offset(-60);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [_autoIco mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-40);
        make.bottom.equalTo(self.mas_centerY);
        make.height.equalTo(@15);
        make.width.equalTo(@15);
    }];
    
    [_autoDistance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_autoIco.mas_right);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_centerY);
        make.height.equalTo(@15);
    }];
    
    [_walkIco mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-40);
        make.top.equalTo(self.mas_centerY);
        make.height.equalTo(@15);
        make.width.equalTo(@15);
    }];
    
    [_walkDistance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_walkIco.mas_right);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_centerY);
        make.height.equalTo(@15);
    }];
}


@end
