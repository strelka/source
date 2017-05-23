//
//  SPFCustomCell.h
//  ShowPictureFromFlickr
//
//  Created by Jullia Sharaeva on 20.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SPFCustomCell : UITableViewCell
@property (nonatomic, strong) NSURL *imgURL;
@property (nonatomic, strong) UIProgressView *progressBar;
@property (nonatomic, strong) UIImage *cellImage;

- (void) setImageToImageView;
@end
