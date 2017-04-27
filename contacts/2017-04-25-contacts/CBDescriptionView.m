//
//  CBDescriptionView.m
//  2017-04-25-contacts
//
//  Created by Jullia Sharaeva on 26.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "CBDescriptionView.h"
#import <Masonry/Masonry.h>
#import "CBAvatarView.h"

@implementation CBDescriptionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self createSubviewsWithContact];
    }
    return self;
}

-(void)createSubviewsWithContact{
    
    _name = [UILabel new];
    _lastName = [UILabel new];
    _phone = [UILabel new];
    _email = [UILabel new];
    _avatar = [UIImageView new];
    
    UIView *contactInfo = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:contactInfo];
    
    [contactInfo addSubview:_name];
    [contactInfo addSubview:_lastName];
    [contactInfo addSubview:_phone];
    [contactInfo addSubview:_email];
    [contactInfo addSubview:_avatar];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 10, 10);

    [contactInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(padding);
    }];
    
    double hightStep = 40;
    [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contactInfo.mas_top);
        make.left.equalTo(contactInfo.mas_left);
        make.height.equalTo(@(hightStep*2));
        make.width.equalTo(@(hightStep*2));
        
    }];
    
    _avatar.backgroundColor= [UIColor whiteColor];
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_avatar.mas_top);
        make.left.equalTo(_avatar.mas_right);
        make.right.equalTo(contactInfo.mas_right);
        make.bottom.equalTo(_avatar.mas_centerY);
        
    }];
    
    [_lastName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_avatar.mas_centerY);
        make.left.equalTo(_avatar.mas_right);
        make.right.equalTo(contactInfo.mas_right);
        make.bottom.equalTo(_avatar.mas_bottom);
        
    }];
    
    [_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lastName.mas_bottom);
        make.left.equalTo(_avatar.mas_right);
        make.right.equalTo(contactInfo.mas_right);
        
        make.height.equalTo(@(hightStep));

        
    }];
    
    [_email mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phone.mas_bottom);
        make.left.equalTo(_avatar.mas_right);
        make.right.equalTo(contactInfo.mas_right);
        
        make.height.equalTo(@(hightStep));
    }];


    
}

@end
