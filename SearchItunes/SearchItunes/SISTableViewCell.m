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
//@property(nonatomic, copy) UIImageView* imageView;


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
    //_ima = [[UIImageView alloc] init];
    
    [self addSubview:_artist];
    [self addSubview:_track];
    [self addSubview:_collection];
    
    [_track mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    
    [_track mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    
    

}


@end
