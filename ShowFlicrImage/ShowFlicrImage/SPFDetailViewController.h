//
//  SPFDetailViewController.h
//  ShowFlicrImage
//
//  Created by Jullia Sharaeva on 31.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SPFPicture;

@interface SPFDetailViewController : UIViewController
- (instancetype) initWithPicture:(SPFPicture*)pic;

@end