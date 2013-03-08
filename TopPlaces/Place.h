//
//  Place.h
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-02-08.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Entity.h"

@interface Place : Entity
@property (nonatomic, readonly) NSString *country;

-(NSArray *)getPhotos; // of Photo objects

+(NSArray *)topPlaces;
+(NSComparator)comparator;

@end
