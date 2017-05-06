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
    _imView = [[UIImageView alloc] init];
    _imView.contentMode = UIViewContentModeScaleAspectFit;
    _imView.clipsToBounds = YES;
    double cellheight = 60;
    
    [self addSubview:_imView];
    [self addSubview:_artist];
    [self addSubview:_track];
    [self addSubview:_collection];
    
    
    [_imView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.height.equalTo(@(cellheight));
        make.width.equalTo(@(cellheight));
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
