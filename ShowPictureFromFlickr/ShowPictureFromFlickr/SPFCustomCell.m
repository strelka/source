//
//  SPFCustomCell.m
//  ShowPictureFromFlickr
//
//  Created by Jullia Sharaeva on 20.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "SPFCustomCell.h"
#import "UIImage+CroppingImage.h"
#import <Masonry/Masonry.h>

NSString *const SPFCellIdentifier = @"SPFCellIdentifier";

@interface SPFCustomCell()
@property (nonatomic, strong) UIImageView *cellImageView;
@property (nonatomic, strong) UIImageView *cellBorderView;

@end

@implementation SPFCustomCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self){
        [self createSubviews];
    }
    return self;
}

- (void) createSubviews{
    
    _cellImageView = [UIImageView new];
    _cellImage = [UIImage new];
    
    //_cellBorderView.image = [UIImage imageNamed:@"vintagePhotoFrame"];
    
    _progressBar = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    [_progressBar setProgress:0.1];
    
    [self addSubview:_cellImageView];
    [self addSubview:_cellBorderView];
    [self addSubview:_progressBar];
    
    [_cellImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [_progressBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    
}

- (void) setImageToImageView{
    
    UIImage *img = [_cellImage croppingImageByFrame:self.frame];
    self.cellImageView.image = img;
    self.cellImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.cellImageView.clipsToBounds = YES;
}
@end
