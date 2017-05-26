//
//  TRNPlayerViewController.h
//  Trends
//
//  Created by Jullia Sharaeva on 26.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRNPlayerViewController : UIViewController
@property (nonatomic, strong) YTPlayerView *playerView;
@property (nonatomic, strong) NSString* videoId;
@end
