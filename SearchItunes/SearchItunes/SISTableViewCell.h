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

-(void) addRecord:(SISComposition* ) record;

@end
