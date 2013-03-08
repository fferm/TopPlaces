//
//  PhotosModel.h
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-03-08.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Place.h"
#import "EntityModel.h"

@interface PhotosModel : EntityModel
@property (nonatomic, strong) Place *place;

+(PhotosModel *)modelForPlace:(Place *)place;

@end
