//
//  FVPDetailView.m
//  FVPcontacts
//
//  Created by Jullia Sharaeva on 11.06.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "FVPDetailView.h"
#import <Masonry/Masonry.h>

@implementation FVPDetailView

- (instancetype) init{
    self = [super init];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.familyLabel];
        [self addSubview:self.nameLabel];
        [self addSubview:self.imgView];
        [self initConstraints];
    }
    return self;
}

- (UILabel*) familyLabel{
    if (!_familyLabel){
        _familyLabel = [UILabel new];
        _familyLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _familyLabel;
}

- (UILabel*) nameLabel{
    if (!_nameLabel){
        _nameLabel = [UILabel new];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}

- (UIImageView*) imgView{
    if (!_imgView){
        _imgView = [UIImageView new];
    }
    return _imgView;
}

- (void) initConstraints{

    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@100);
        make.width.equalTo(@100);
        make.left.equalTo(self.mas_left).with.offset(20);
        make.top.equalTo(self.mas_top).with.offset(20);
    }];
    
    [_familyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgView.mas_right).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(10);
        make.centerY.equalTo(_imgView.mas_centerY);
        make.height.equalTo(@30);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgView.mas_right).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(10);
        make.height.equalTo(@30);
        make.bottom.equalTo(_imgView.mas_bottom);
    }];
    
    
}
@end

