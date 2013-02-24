//
//  MapViewController.h
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-02-21.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController<MKMapViewDelegate>
@property (nonatomic, strong) NSArray *places;

@end