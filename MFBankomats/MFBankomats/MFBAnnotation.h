//
//  MFBAnnotation.h
//  MFBankomats
//
//  Created by Jullia Sharaeva on 08.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface MFBAnnotation : NSObject<MKAnnotation>
@property(readonly, nonatomic) CLLocationCoordinate2D coordinate;
@property(copy, nonatomic) NSString *title;
-(id)initWithTitle:(NSString*)newTitle location:(CLLocationCoordinate2D)location;
-(MKAnnotationView *)annotationView;

@end
