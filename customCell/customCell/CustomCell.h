//
//  CustomCell.h
//  customCell
//
//  Created by Jullia Sharaeva on 14.04.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell {
    UILabel *primaryLabel;
    UILabel *secondaryLabel;
    UIImageView *myImageView;
}
@property(nonatomic,retain)UILabel *primaryLabel;
@property(nonatomic,retain)UILabel *secondaryLabel;
@property(nonatomic,retain)UIImageView *myImageView;
@end
