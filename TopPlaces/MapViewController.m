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
@synthesize places = _places;
@synthesize mapView = _mapView;

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
    [self.mapView addAnnotations:self.places];

    [self updateCenter];
    
    [self.mapView setNeedsDisplay];
}

-(void) updateCenter {
    if (self.mapView.annotations) {
        CLLocationDegrees maxLat, minLat, maxLon, minLon;
        
        for (id<MKAnnotation> annotation in self.mapView.annotations) {
            CLLocationCoordinate2D coord = [annotation coordinate];
            
            if (coord.latitude > maxLat) {
                maxLat = coord.latitude;
            }
            if (coord.latitude < minLat) {
                minLat = coord.latitude;
            }
            
            if (coord.longitude > maxLon) {
                maxLon = coord.longitude;
            }
            
            if (coord.longitude < minLon) {
                minLon = coord.longitude;
            }
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

-(void)setPlaces:(NSArray *)places {
    _places = places;
    [self updateMap];
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
