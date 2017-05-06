//
//  SISTableViewCell.m
//  SearchItunes
//
//  Created by Jullia Sharaeva on 05.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "SISTableViewCell.h"
#import "SISComposition.h"
#import <Masonry/Masonry.h>


NSString *const SISCellIdentifier = @"SISCellIdentifier";
@interface SISTableViewCell()

@property(nonatomic, strong) UILabel* artist;
@property(nonatomic, strong) UILabel* track;
@property(nonatomic, strong) UILabel* collection;
@property(nonatomic, copy)   UIImageView* imView;

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
    
    
    double cellheight = self.bounds.size.height;
    
    
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
        make.left.equalTo(_imView.mas_right);
        make.right.equalTo(self.mas_right);
    }];
    
    [_artist mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_track.mas_bottom);
        make.left.equalTo(_imView.mas_right);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@(cellheight/3));
        
    }];
    
    [_collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_artist.mas_bottom);
        make.height.equalTo(@(cellheight/3));
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(_imView.mas_right);
        make.right.equalTo(self.mas_right);
    }];
}

-(void) addRecord:(SISComposition* ) record{
    _artist.text = record.artistName;
    _track.text = record.trackName;
    _collection.text = record.collectionName;
    _imView.image = [UIImage imageWithData:record.artworkUrl];
}

@end
