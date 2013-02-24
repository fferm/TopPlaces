//
//  MapViewController.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-02-21.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "MapViewController.h"
#import "Place.h"

@interface MapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController
@synthesize mapView = _mapView;
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)updateMap {
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView addAnnotations:[self.delegate annotations]];

    [self updateCenter];
    
    [self.mapView setNeedsDisplay];
}

-(void) updateCenter {
    if (self.mapView.annotations && self.mapView.annotations.count > 0) {
        CLLocationDegrees maxLat, minLat, maxLon, minLon;
        
        BOOL firstTime = YES;
        for (id<MKAnnotation> annotation in self.mapView.annotations) {
            CLLocationCoordinate2D coord = [annotation coordinate];
            
            if (firstTime || coord.latitude > maxLat) {
                maxLat = coord.latitude;
            }
            if (firstTime || coord.latitude < minLat) {
                minLat = coord.latitude;
            }
            
            if (firstTime || coord.longitude > maxLon) {
                maxLon = coord.longitude;
            }
            
            if (firstTime || coord.longitude < minLon) {
                minLon = coord.longitude;
            }
            
            firstTime = NO;
        }
        
        CLLocationCoordinate2D center = CLLocationCoordinate2DMake(
                                                                   (maxLat + minLat) / 2.0,
                                                                   (maxLon + minLon) / 2.0);
        
        MKCoordinateSpan span = MKCoordinateSpanMake(maxLat - minLat, maxLon - minLon);
        
        [self.mapView setRegion:MKCoordinateRegionMake(center, span)];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate = self;
    [self updateMap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKAnnotationView *aView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"MapVC"];
    if (!aView) {
        aView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MapVC"];
        aView.canShowCallout = YES;
//        aView.leftCalloutAccessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        // could put a rightCalloutAccessoryView here
    }
    
    aView.annotation = annotation;
//    [(UIImageView *)aView.leftCalloutAccessoryView setImage:nil];
    
    return aView;
}

@end
