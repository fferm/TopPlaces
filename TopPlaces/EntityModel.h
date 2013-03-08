//
//  TableModel.h
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-03-09.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TopPlacesTableViewController.h"

@interface EntityModel : NSObject<TopPlacesTableDataSource>
@property (nonatomic, weak) id<ModelEventTarget> eventTarget;

@end
