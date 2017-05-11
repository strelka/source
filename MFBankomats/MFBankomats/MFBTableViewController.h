//
//  MFBTableViewController.h
//  MFBankomats
//
//  Created by Jullia Sharaeva on 10.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <UIKit/UIKit.h>
@class poiAtmList;
@class MFBAnnotation;

@interface MFBTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) poiAtmList* poiList;
@property(nonatomic, strong) MFBAnnotation* selectedPoi;

@end
