//
//  SPFCustomCell.m
//  ShowPictureFromFlickr
//
//  Created by Jullia Sharaeva on 20.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "SPFCustomCell.h"

NSString *const SPFCellIdentifier = @"SPFCellIdentifier";

@implementation SPFCustomCell

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        //_imageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _imageView;
}

- (UILabel*) label{
    if (!_label){
        _label = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        _label.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _label.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.label];
    }
    return _label;

}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

-(void)prepareForReuse {
    [super prepareForReuse];
    self.imageView.image = nil; //and etc.
}

@end
