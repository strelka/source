//
//  SPFDetailView.m
//  ShowFlicrImage
//
//  Created by Jullia Sharaeva on 31.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "SPFDetailView.h"
#import "NSFont+SPFAdditions.h"
#import <Masonry/Masonry.h>

@implementation SPFDetailView

- (instancetype) init{
    self = [super init];
    if (self){
        [self createSubViews];
    }
    return self;
}

- (void) createSubViews{
    [self createDescView];
}

- (void)createDescView{
    UIView *descView = [[UIView alloc] init];
    UILabel *descLabel = [[UILabel alloc] init];
    
    descLabel.text = @"Описание или название этой очень крутой фотки снятой в режиме HDR.";
    descLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    UIFont *font = [UIFont spf_textStyleFont];
    
    
    [self addSubview:descView];
    [descView addSubview:descLabel];
    
    [descView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@64);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
    }];
    
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.left.equalTo(descView.mas_left).with.offset(16);
        make.right.equalTo(descView.mas_right).with.offset(-16);
        make.top.equalTo(descView.mas_top).with.offset(12);
        make.bottom.equalTo(descView.mas_bottom).with.offset(-12);
    }];
    
}
@end
