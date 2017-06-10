//
//  CustomAtmCell.h
//  MFBankomats
//
//  Created by Jullia Sharaeva on 08.06.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFBCustomAtmCell : UITableViewCell
@property (nonatomic, strong) UILabel *address;
@property (nonatomic, strong) UILabel *autoDistance;
@property (nonatomic, strong) UILabel *walkDistance;

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void) setAtmIcoFor:(int)openStatus;
@end
