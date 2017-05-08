//
//  MFBAnnotation.m
//  MFBankomats
//
//  Created by Jullia Sharaeva on 08.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "MFBAnnotation.h"

@implementation MFBAnnotation
-(id)initWithTitle:(NSString *)newTitle location:(CLLocationCoordinate2D)location
{
    self = [super init];
    if (self)
    {
        _title = newTitle;
        _coordinate = location;
    }
    return self;

}

-(MKAnnotationView *)annotationView
{
    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"MyAnnotation"];
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
    annotationView.image = [UIImage imageNamed:@"ico"];
    return annotationView;
}
@end
