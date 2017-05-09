//
//  MFBAnnotation.m
//  MFBankomats
//
//  Created by Jullia Sharaeva on 08.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "MFBAnnotation.h"

@implementation MFBAnnotation
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate{
    _coordinate = newCoordinate;
}

-(MKPinAnnotationView *)annotationView
{
    MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"MyAnnotation"];
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
    //annotationView.image = [UIImage imageNamed:@"ico"];
    if (self.isOpen == 0)
        annotationView.pinTintColor = [UIColor grayColor];
    else if (self.isOpen == 1)
        annotationView.pinTintColor = [UIColor greenColor];
    else
        annotationView.pinTintColor = [UIColor redColor];
        
    return annotationView;
}
@end
