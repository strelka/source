//
//  MFBTableViewController.h
//  MFBankomats
//
//  Created by Jullia Sharaeva on 10.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFBTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) NSArray* poiArray;
@end
