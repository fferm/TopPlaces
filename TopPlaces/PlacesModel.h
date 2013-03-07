//
//  PlacesModel.h
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-03-07.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TopPlacesTableViewController.h"


@interface PlacesModel : NSObject<TopPlacesTableDataSource>
@property (nonatomic, weak) id<ModelEventTarget> eventTarget;
@end
