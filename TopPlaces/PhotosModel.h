//
//  PhotosModel.h
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-03-08.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Place.h"
#import "TopPlacesTableViewController.h"

@interface PhotosModel : NSObject<TopPlacesTableDataSource>
@property (nonatomic, strong) Place *place;
@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, weak) id<ModelEventTarget> eventTarget;

+(PhotosModel *)modelForPlace:(Place *)place;

@end
