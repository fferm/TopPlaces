//
//  PhotosTableViewController.h
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-01-31.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Place.h"
#import "TopPlacesTableViewController.h"

@interface PhotosTableViewController : TopPlacesTableViewController
@property (nonatomic, strong) Place *place;

@end
