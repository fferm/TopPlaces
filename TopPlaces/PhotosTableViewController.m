//
//  PhotosTableViewController.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-01-31.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "PhotosTableViewController.h"

@interface PhotosTableViewController ()
@end

@implementation PhotosTableViewController

-(void)setDataSource:(id<TopPlacesTableDataSource>)dataSource{
    PhotosModel *mod = dataSource;
    mod.eventTarget = self;
    
    super.dataSource = dataSource;
}

@end
