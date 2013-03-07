//
//  PlacesTableViewController.h
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-01-27.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopPlacesTableViewController.h"
#import "PlacesModel.h"


@interface PlacesTableViewController : TopPlacesTableViewController<PlacesModelEventTarget>

@end
