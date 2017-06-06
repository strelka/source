//
//  SISTableViewCell.h
//  SearchItunes
//
//  Created by Jullia Sharaeva on 05.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

@class SISComposition;
#import <UIKit/UIKit.h>

extern NSString *const SISCellIdentifier;

@interface SISTableViewCell : UITableViewCell

@property(nonatomic, strong) NSURL* imgUrl;
@property(nonatomic, strong) UILabel* artist;
@property(nonatomic, strong) UILabel* track;
@property(nonatomic, strong) UILabel* collection;
@property(nonatomic, strong) UILabel* price;
@end
