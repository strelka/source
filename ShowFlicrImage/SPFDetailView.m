//
//  SPFDetailView.m
//  ShowFlicrImage
//
//  Created by Jullia Sharaeva on 31.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "SPFDetailView.h"
#import <Masonry/Masonry.h>

@interface SPFDetailView()
@property(nonatomic, strong) UIView *descView;
@property(nonatomic, strong) UILabel *descLabel;
@property(nonatomic, strong) UIView *likeView;

@end

@implementation SPFDetailView
{
    UIButton *likeBtn;
    UIImageView  *commentImgView;
    UILabel  *likeLabel;
    UILabel  *commentLabel;
}

- (instancetype) init{
    self = [super init];
    if (self){
        [self addSubview:self.descView];
        
        [_descView addSubview:self.descLabel];
        
        [self addSubview:self.likeView];
        
        [_likeView addSubview:likeBtn];
        [_likeView addSubview:self.likeLabel];
        [_likeView addSubview:self.commentImgView];
        [_likeView addSubview:self.commentLabel];
        
        [self initConstraints];
    }
    return self;
}

- (UIView*) descView{
    if (!_descView){
        _descView = [[UIView alloc] init];
    }
    return _descView;
}

- (UIView*)likeView{
    if (!_likeView){
        _likeView = [[UIView alloc] init];
        UIImage *imgForLikeBtn = [[UIImage imageNamed:@"btnLikeSuggestion"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
        
        likeBtn = [[UIButton alloc] init];
        [likeBtn setImage:imgForLikeBtn forState:UIControlStateNormal];
        
    }
    return _likeView;
}

- (UIImageView*) commentImgView{
    if (!commentImgView){
        commentImgView = [[UIImageView alloc] init];
        UIImage *commentImg = [[UIImage imageNamed:@"fill984"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
        commentImgView.image = commentImg;
    }
    return commentImgView;
}

- (UILabel*)likeLabel{
    if (!likeLabel){
        likeLabel = [[UILabel alloc] init];
        likeLabel.font = [UIFont systemFontOfSize:14];
        likeLabel.textColor = [UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1];
        likeLabel.textAlignment = NSTextAlignmentLeft;
        likeLabel.text = @"123 лайка";
    }
    return likeLabel;
}

- (UILabel*)commentLabel{
    if (!commentLabel){
        commentLabel = [[UILabel alloc] init];
        commentLabel.font = [UIFont systemFontOfSize:14];
        commentLabel.textColor = [UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1];
        commentLabel.textAlignment = NSTextAlignmentLeft;
        commentLabel.text = @"10 комментариев";
    }
    return commentLabel;
}


- (UILabel*)descLabel{
    if (!_descLabel){
        _descLabel = [[UILabel alloc] init];
        _descLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _descLabel.font = [UIFont systemFontOfSize:14];
        _descLabel.textColor = [UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1];
        _descLabel.numberOfLines = 0;
        [_descLabel sizeToFit];
        _descLabel.text = @"Описание или название этой очень крутой фотки снятой в режиме HDR.";
        _descLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _descLabel;
}


- (void)initConstraints{
    [_descView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@62);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
    }];
    
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.left.equalTo(_descView.mas_left).with.offset(16);
        make.right.equalTo(_descView.mas_right).with.offset(-16);
        make.top.equalTo(_descView.mas_top).with.offset(10);
        make.bottom.equalTo(_descView.mas_bottom).with.offset(-12);
    }];
    
    [_likeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@62);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.descView.mas_bottom);
    }];
    
    [likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(16);
        make.right.equalTo(self.mas_right).with.offset(-343.1);
        make.centerY.equalTo(_likeView.mas_centerY);
    }];
    
    [likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(39);
        make.centerY.equalTo(_likeView.mas_centerY);
        make.height.equalTo(@17);
        make.width.equalTo(@67);
    }];
    
    [commentImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(122.3);
        make.centerY.equalTo(_likeView.mas_centerY);
        make.height.equalTo(@15);
        make.width.equalTo(@18);
    }];
    
    [commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(146.3);
        make.centerY.equalTo(_likeView.mas_centerY);
        make.height.equalTo(@17);
        make.width.equalTo(@119);
    }];
    
    
}
@end
