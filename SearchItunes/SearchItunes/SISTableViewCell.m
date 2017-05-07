//
//  SISTableViewCell.m
//  SearchItunes
//
//  Created by Jullia Sharaeva on 05.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "SISTableViewCell.h"
#import <Masonry/Masonry.h>


NSString *const SISCellIdentifier = @"SISCellIdentifier";
@interface SISTableViewCell()

@end

@implementation SISTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self createSubviews];
    }
    return self;
}

-(void) createSubviews{
    _artist = [UILabel new];
    _track = [UILabel new];
    _collection = [UILabel new];
    //_price = [UILabel new];
    _imView = [[UIImageView alloc] init];
    _imView.contentMode = UIViewContentModeScaleAspectFit;
    _imView.clipsToBounds = YES;
    double cellheight = 60;
    
    [self addSubview:_imView];
    [self addSubview:_artist];
    [self addSubview:_track];
    [self addSubview:_collection];
    [self addSubview:_price];
    
//    [_price setFont:[UIFont boldSystemFontOfSize:8]];
//    [_price setTextAlignment:NSTextAlignmentCenter];
//    [_price setTextColor:[UIColor blackColor]];
//    [_price setBackgroundColor:[UIColor lightGrayColor]];
//    [_price setTransform:CGAffineTransformMakeRotation(M_PI_2)];
    
    
    [_track setFont:[UIFont boldSystemFontOfSize:10]];
    [_track setTextColor:[UIColor darkTextColor]];
    
    [_artist setFont:[UIFont boldSystemFontOfSize:8]];
    [_artist setTextColor:[UIColor darkTextColor]];
    
    [_collection setFont:[UIFont boldSystemFontOfSize:8]];
    [_collection setTextColor:[UIColor darkTextColor]];
    
    
//    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.mas_right);
//        make.right.equalTo(self.mas_top);
//        make.left.equalTo(self.mas_bottom);
//        make.height.equalTo(@(cellheight));
//        make.width.equalTo(@(20));
//    }];
//    
    [_imView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.height.equalTo(@60).priorityHigh();
        make.width.equalTo(@60).priorityHigh();
        make.left.equalTo(self.mas_left);
    }];
    
    [_track mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.height.equalTo(@(cellheight/3));
        make.left.equalTo(self.mas_left).with.offset(100);
        make.right.equalTo(self.mas_right);
    }];
    
    [_artist mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_track.mas_bottom);
        make.left.equalTo(self.mas_left).with.offset(100);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@(cellheight/3));
        
    }];
    [_collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_artist.mas_bottom);
        make.height.equalTo(@(cellheight/3));
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left).with.offset(100);
        make.right.equalTo(self.mas_right);
    }];
}
@end
