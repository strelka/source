//
//  SPFCustomCell.m
//  ShowPictureFromFlickr
//
//  Created by Jullia Sharaeva on 20.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "SPFCustomCell.h"
#import "UIImage+CroppingImage.h"
#import "SPFFiltersTableController.h"
#import <Masonry/Masonry.h>

NSString *const SPFCellIdentifier = @"SPFCellIdentifier";

@interface SPFCustomCell()
@property (nonatomic, strong) UIImageView *cellImageView;
@property (nonatomic, strong) UIImageView *cellBorderView;
@property (nonatomic, strong) UISwitch *switchFilter;

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
    _switchFilter = [UISwitch new];
    [_switchFilter setOn:NO];
    
    _progressBar = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    [_progressBar setProgress:0.1];
    
    [self addSubview:_cellImageView];
    [self addSubview:_cellBorderView];
    [self addSubview:_progressBar];
    [self addSubview:_switchFilter];
    
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
    
    [_switchFilter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
}

- (void) setImageToImageView{
    
    UIImage *img = [_cellImage croppingImageByFrame:self.frame];
    self.cellImageView.image = img;
    self.cellImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.cellImageView.clipsToBounds = YES;
}

- (void) prepareForReuse{
    self.cellImageView.image = nil;
    self.accessoryView = nil;
}

- (void) showFiltersMenu{
    SPFFiltersTableController *tabc = [[SPFFiltersTableController alloc] init];
    [tabc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.height.equalTo(self.mas_height);
        make.width.equalTo(@100);
    }];
    

}
@end
