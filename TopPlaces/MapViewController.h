//
//  MapViewController.h
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-02-21.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@protocol MapViewControllerDelegate <NSObject>
@optional
-(NSArray *)annotations;
-(UIImage *)calloutImageForAnnotation:(id<MKAnnotation>)annotation;

@end

@interface MapViewController : UIViewController<MKMapViewDelegate>
@property (nonatomic, strong) id<MapViewControllerDelegate> delegate;

@end
