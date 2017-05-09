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
@property(nonatomic) CLLocationCoordinate2D coordinate;
@property(copy, nonatomic) NSString *title;
@property(nonatomic) UIColor* isOpen;

-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;
-(instancetype) initWithName:(NSString*)name andCoordinate:(CLLocationCoordinate2D)cord andOpen:(int)isOpen;
-(MKPinAnnotationView *)annotationView;


@end
