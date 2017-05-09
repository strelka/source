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

-(instancetype) initWithName:(NSString*)name andCoordinate:(CLLocationCoordinate2D)cord andOpen:(int)isOpen{
    self = [super init];
    if (self){
        _coordinate = cord;
        _title = name;
        
        if (isOpen == 0)  _isOpen = [UIColor grayColor];
        if (isOpen == -1) _isOpen = [UIColor redColor];
        if (isOpen == 1) _isOpen = [UIColor greenColor];
        
    }
    return self;
}

-(MKPinAnnotationView *)annotationView
{
    MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"MyAnnotation"];
    
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
    
    //annotationView.pinTintColor = self.isOpen;
    //annotationView.image = [UIImage imageNamed:@"ico"];
//    if (self.isOpen == 0)
//        annotationView.pinTintColor = [UIColor grayColor];
//    else if (self.isOpen == 1)
//        annotationView.pinTintColor = [UIColor greenColor];
//    else
//        annotationView.pinTintColor = [UIColor redColor];
        
    return annotationView;
}
@end
