//
//  FVPViewControllerDetails.h
//  FVPcontacts
//
//  Created by Jullia Sharaeva on 11.06.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FVPContact;

@interface FVPDetailsViewController : UIViewController
- (instancetype)initWith:(FVPContact*) contact;
@end
