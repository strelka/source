//
//  FVPContactCell.m
//  FVPcontacts
//
//  Created by Jullia Sharaeva on 12.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "FVPContactCell.h"
#import <Masonry/Masonry.h>
@implementation FVPContactCell
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self addSubview:self.imgView];
        [self addSubview:self.fioLabel];
        [self initConstraints];
    }
    return self;

}

- (UILabel*) fioLabel{
    if (!_fioLabel){
        _fioLabel = [[UILabel alloc] init];
    }
    return _fioLabel;
}

- (UIImageView*)imgView{
    if (!_imgView){
        _imgView = [[UIImageView alloc] init];
        
    }
    return _imgView;
}

- (void) initConstraints{
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.width.equalTo(@30);
        make.left.equalTo(self.mas_left);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [_fioLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgView.mas_right);
        make.right.equalTo(self.mas_right);
    }];
}

- (void) prepareForReuse{
    self.imgView.image = nil;
    self.fioLabel.text = @"";
}
@end
