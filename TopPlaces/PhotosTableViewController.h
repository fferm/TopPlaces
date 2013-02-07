//
//  PhotosTableViewController.h
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-01-31.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotosModel.h"
#import "Place.h"

@interface PhotosTableViewController : UITableViewController
@property (nonatomic, strong) Place *place;

@end
