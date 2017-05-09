//
//  MFBMapViewDelegate.m
//  MFBankomats
//
//  Created by Jullia Sharaeva on 09.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//
#import <MapKit/MapKit.h>

#import "MFBMapViewDelegate.h"
#import "MFBAnnotation.h"

#import "MFBGetDataFromGoogle.h"


@implementation MFBMapViewDelegate

-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[MFBAnnotation class]])
    {
        MFBAnnotation *myLocation = (MFBAnnotation*) annotation;
        
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"MyAnnotation"];
        
        if(annotationView == nil)
            annotationView = myLocation.annotationView;
        else
            annotationView.annotation = annotation;
        return annotationView;
    }
    else
        return nil;
    
}


-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    
    NSLog(@"regionDidChangeAnimated");
    NSLog(@"loadData");
    
    
    //newRegion = mapView.region;
    //NSLog(@"regionDidChangeAnimated");
    //CLLocationCoordinate2D centre = [mapView centerCoordinate];
    
//    MKCoordinateRegion newRegion = mapView.region;
//
//    if (_mapRegion.span.latitudeDelta != newRegion.span.latitudeDelta ||
//        _mapRegion.span.longitudeDelta != newRegion.span.longitudeDelta)
//        NSLog(@"The zoom has changed");
//    
    
    //[self loadDataforName:@"sberbank" andCord:centre];

//    [_service getDataforName:@"sberbank" andCord:centre andComplition:^(NSArray *data) {
//        [mapView addAnnotations:data];
//    }];
}

//-(void)loadDataforName:(NSString*)name andCord:(CLLocationCoordinate2D)cord{
//
//    [_service getDataforName:name andCord:(CLLocationCoordinate2D)cord andComplition:^(NSArray *data) {
//        [_mapView addAnnotations:data];
//    }];
//}


- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    NSLog(@"regionWillChangeAnimated");
//    _mapRegion = mapView.region;
}

- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView{
    NSLog(@"mapViewWillStartLoadingMap");
}
- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView{
    NSLog(@"mapViewDidFinishLoadingMap");
}
- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error{
    NSLog(@"mapViewDidFailLoadingMap");
}

- (void)mapViewWillStartRenderingMap:(MKMapView *)mapView{
    NSLog(@"mapViewWillStartRenderingMap");
}
- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered NS_AVAILABLE(10_9, 7_0){
    NSLog(@"mapViewDidFinishRenderingMap");
}

// mapView:viewForAnnotation: provides the view for each annotation.
// This method may be called for all or some of the added annotations.
// For MapKit provided annotations (eg. MKUserLocation) return nil to use the MapKit provided annotation view.

// mapView:didAddAnnotationViews: is called after the annotation views have been added and positioned in the map.
// The delegate can implement this method to animate the adding of the annotations views.
// Use the current positions of the annotation views as the destinations of the animation.

#if TARGET_OS_IPHONE
// mapView:annotationView:calloutAccessoryControlTapped: is called when the user taps on left & right callout accessory UIControls.
#endif

//- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view NS_AVAILABLE(10_9, 4_0);
//- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view NS_AVAILABLE(10_9, 4_0);

- (void)mapViewWillStartLocatingUser:(MKMapView *)mapView NS_AVAILABLE(10_9, 4_0){
    NSLog(@"mapViewWillStartLocatingUser");

}
- (void)mapViewDidStopLocatingUser:(MKMapView *)mapView NS_AVAILABLE(10_9, 4_0)
{
    NSLog(@"mapViewDidStopLocatingUser");

}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation NS_AVAILABLE(10_9, 4_0)
{
    NSLog(@"didUpdateUserLocation");

}
- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error NS_AVAILABLE(10_9, 4_0){
    NSLog(@"didFailToLocateUserWithError");

}



@end
