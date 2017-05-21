//
//  SPFCustomCell.h
//  ShowPictureFromFlickr
//
//  Created by Jullia Sharaeva on 20.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPFCustomCell : UITableViewCell
@property (nonatomic, strong) UIProgressView *progressBar;

- (void) setImgOnImgView:(UIImage*)img;
- (void) setProgressInProgressBar:(float)progress;
@end
