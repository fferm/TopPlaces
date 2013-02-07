//
//  PlacesModel.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-01-30.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "PlacesModel.h"
#import "FlickrFetcher.h"
#import "Place.h"

@interface  PlacesModel()

@property (nonatomic, strong) NSArray *sortedPlaces;

@end

@implementation PlacesModel

@synthesize sortedPlaces = _sortedPlaces;

-(NSArray *)sortedPlaces {
    if (!_sortedPlaces) {
        NSArray *flickrPlaces = [FlickrFetcher topPlaces];
        
        NSMutableArray *mutRet = [[NSMutableArray alloc] initWithCapacity:0];
        
        for (NSDictionary *flickrPlace in flickrPlaces) {
            [mutRet addObject:[Place placeWithFlickrDictionary:flickrPlace]];
        }
        
        _sortedPlaces = [mutRet sortedArrayUsingComparator: ^(id obj1, id obj2) {
            Place *p1 = (Place *)obj1;
            Place *p2 = (Place *)obj2;
            
            return [p1.title compare:p2.title];
        }];
    }
    return _sortedPlaces;
}

-(NSInteger) count {
    return [self.sortedPlaces count];
}

-(Place *)placeAtIndex:(NSInteger)index {
    return [self.sortedPlaces objectAtIndex:index];
}

@end
