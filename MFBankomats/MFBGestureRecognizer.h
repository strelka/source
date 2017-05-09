//
//  MFBGestureRecognizer.h
//  MFBankomats
//
//  Created by Jullia Sharaeva on 09.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^TouchesEventBlock)(NSSet * touches, UIEvent * event);

@interface MFBGestureRecognizer : UIGestureRecognizer{
    TouchesEventBlock touchesEndCallback;
}
@property(copy) TouchesEventBlock touchesEndCallback;

@end
