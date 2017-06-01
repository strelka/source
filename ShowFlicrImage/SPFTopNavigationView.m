//
//  SPFTopNavigationView.m
//  ShowFlicrImage
//
//  Created by Jullia Sharaeva on 01.06.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "SPFTopNavigationView.h"
#import <Masonry/Masonry.h>

@implementation SPFTopNavigationView{
    UIImageView *avatarImg;
    UILabel *authorLabel;
    UILabel *geoLabel;
    UIImageView *geoImg;
}
- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self addSubview:self.avatarImg];
        [self addSubview:self.authorLabel];
        [self addSubview:self.geoLabel];
        [self addSubview:self.geoImg];
        [self initConstraints];
    }
    return self;
}

- (UIImageView *) avatarImg{
    if (!avatarImg){
        avatarImg = [[UIImageView alloc] init];
        avatarImg.layer.cornerRadius = 16;
        avatarImg.clipsToBounds = YES;
        avatarImg.backgroundColor = [UIColor blueColor];
    }
    return avatarImg;
}

- (UILabel*) authorLabel{
    if (!authorLabel){
        authorLabel = [[UILabel alloc] init];
        authorLabel.font = [UIFont systemFontOfSize:14];
        authorLabel.textColor = [UIColor blackColor];
        authorLabel.textAlignment = NSTextAlignmentLeft;
        authorLabel.text = @"sarahannloreth";
    }
    return authorLabel;
}

- (UILabel*) geoLabel{
    if (!geoLabel){
        geoLabel = [[UILabel alloc] init];
        geoLabel.font = [UIFont systemFontOfSize:13];
        geoLabel.textColor = [UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1];
        geoLabel.textAlignment = NSTextAlignmentLeft;
        geoLabel.text = @"Kauai, Hawaii";
    }
    return geoLabel;
}

- (UIImageView*) geoImg{
    if (!geoImg){
        geoImg = [[UIImageView alloc] init];
        geoImg.image = [UIImage imageNamed:@"fill2800"];
    }
    return geoImg;
}

- (void) initConstraints{
    
    [avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@32);
        make.width.equalTo(@32);
        make.left.equalTo(self.mas_left).with.offset(15);
        make.top.equalTo(self.mas_top);
    }];
    
    [authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@16);
        make.left.equalTo(avatarImg.mas_right).with.offset(16);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
    }];
    
    [geoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@10);
        make.width.equalTo(@8);
        make.left.equalTo(avatarImg.mas_right).with.offset(16);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [geoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@15);
        make.right.equalTo(self.mas_right);
        make.left.equalTo(geoImg.mas_right).with.offset(4);
        make.bottom.equalTo(self.mas_bottom);
    }];

}

@end
