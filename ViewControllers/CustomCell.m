//
//  CustomCell.m
//  ViewControllers
//
//  Created by Jullia Sharaeva on 14.04.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
@synthesize primaryLabel, secondaryLabel;

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        primaryLabel = [UILabel new];
        secondaryLabel=[UILabel new];
        [self.contentView addSubview:primaryLabel];
        [self.contentView addSubview:secondaryLabel];
    }
    return self;
}


-(void) layoutSubviews{
    [super layoutSubviews];
    CGRect contentRect = self.contentView.bounds;
    double root_height = contentRect.size.height;
    double root_width = contentRect.size.width;
    
    primaryLabel.frame = CGRectMake(0, 0, root_width/4, root_height);
    secondaryLabel.frame=CGRectMake(root_width/4, 0, root_width-root_width/4, root_height);
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
