//
//  TRNTwitterController.h
//  Trends
//
//  Created by Jullia Sharaeva on 16.06.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRNChildProtocol.h"

@interface TRNTwitterController : UIViewController<TRNChildProtocol>

@property (nonatomic) NSInteger pageIndex;
@end
