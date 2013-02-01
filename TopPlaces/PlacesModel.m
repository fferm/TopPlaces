//
//  PlacesModel.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-01-30.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "PlacesModel.h"
#import "FlickrFetcher.h"

@interface  PlacesModel()

@property (nonatomic, strong) NSArray *flickrPlaces;
@property (nonatomic, strong) NSArray *sortedPlaces;

@end

@implementation PlacesModel

@synthesize flickrPlaces = _flickrPlaces;
@synthesize sortedPlaces = _sortedPlaces;

-(NSArray *)flickrPlaces {
    if (!_flickrPlaces) {
        _flickrPlaces = [FlickrFetcher topPlaces];
    }
    return _flickrPlaces;
}

-(NSArray *)sortedPlaces {
    if (!_sortedPlaces) {
        _sortedPlaces = [self.flickrPlaces sortedArrayUsingComparator: ^(id obj1, id obj2) {
            return [[self titleForPlace:obj1] compare:[self titleForPlace:obj2]];
        }];
    }
    return _sortedPlaces;
}

-(NSInteger) count {
    return [self.flickrPlaces count];
}

-(NSDictionary *)placeAtIndex:(NSInteger)index {
    return [self.sortedPlaces objectAtIndex:index];
}

-(NSArray *) dividedContentStringForPlace:(NSDictionary *)place {
    NSString *content = [place objectForKey:FLICKR_PLACE_NAME];
    return [content componentsSeparatedByString:@","];
}

-(NSString *)titleForPlace:(NSDictionary *)place {
    return [[self dividedContentStringForPlace:place] objectAtIndex:0];
}

-(NSString *)subtitleForPlace:(NSDictionary *)place {
    NSMutableArray *desc = [[self dividedContentStringForPlace:place] mutableCopy];
    [desc removeObjectAtIndex:0];

    NSString *ret = @"";
    BOOL afterFirst = NO;
    for (NSString *subString in desc) {
        if (afterFirst) {
            ret = [ret stringByAppendingString:@","];
        }
        ret = [ret stringByAppendingString:subString];
        afterFirst = YES;
    }
  
    return ret;
}

-(NSString *) titleAtIndex:(NSInteger)index {
    return [self titleForPlace:[self placeAtIndex:index]];
}

-(NSString *) subtitleAtIndex:(NSInteger)index {
    return [self subtitleForPlace:[self placeAtIndex:index]];
}
@end
