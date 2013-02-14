//
//  PhotosTableViewController.h
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-01-31.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Place.h"
#import "TopPlacesPhotosTableViewController.h"

@interface PhotosTableViewController : TopPlacesPhotosTableViewController
@property (nonatomic, strong) Place *place;

@end
