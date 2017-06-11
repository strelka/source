//
//  FVPContactCell.h
//  FVPcontacts
//
//  Created by Jullia Sharaeva on 12.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface FVPContactCell : UITableViewCell
@property (nonatomic, strong) UILabel *fioLabel;
@property (nonatomic, strong) UIImageView *imgView;

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
