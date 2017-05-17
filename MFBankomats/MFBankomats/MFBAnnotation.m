//
//  MFBAnnotation.m
//  MFBankomats
//
//  Created by Jullia Sharaeva on 08.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "MFBAnnotation.h"
#import "MFBRouteViewController.h"

@implementation MFBAnnotation

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate{
    _coordinate = newCoordinate;
}

-(instancetype) initWithName:(NSString*)name andCoordinate:(CLLocationCoordinate2D)cord andisOpen:(int)isOpen{
    self = [super init];
    if (self){
        _coordinate = cord;
        _title = name;
        if (isOpen == -1) _color = [UIColor lightGrayColor];
        if (isOpen == 1) _color = [UIColor greenColor];
        if (isOpen == 0) _color = [UIColor redColor];
        
    }
    return self;
}


-(instancetype) initWithName:(NSString*)name andCoordinate:(CLLocationCoordinate2D)cord{
    self = [super init];
    if (self){
        _coordinate = cord;
        _title = name;
    }
    return self;
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[MFBAnnotation class]]) {
        if ((self.coordinate.latitude == [(MFBAnnotation *)object coordinate].latitude)&&
            (self.coordinate.longitude == [(MFBAnnotation*) object coordinate].longitude)&&
            ([self.title isEqualToString:[(MFBAnnotation*) object title]])
            )
        return YES;
    }
    return NO;
}

- (NSUInteger)hash {
    NSString *hashstring = [[NSString alloc] initWithFormat:@"%f%f%@", self.coordinate.latitude,
                                                                       self.coordinate.longitude,
                                                                       self.title];
    return [hashstring hash];
}
    
-(MKPinAnnotationView *)annotationView
{
    MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"MyAnnotation"];
    
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
    annotationView.pinTintColor = _color;
    
    UIButton *drawRouteBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    UIButton *infoBtn = [UIButton buttonWithType:UIButtonTypeInfoLight];
    
    drawRouteBtn.tag = 1;
    infoBtn.tag = 2;
    
    annotationView.rightCalloutAccessoryView = drawRouteBtn;
    annotationView.leftCalloutAccessoryView = infoBtn;
    
    return annotationView;
}

@end
