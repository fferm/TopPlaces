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

#define CONTENT @"_content"
#define LATITUDE @"latitude"
#define PHOTO_COUNT @"photo_count"
#define PLACE_ID @"place_id"
#define PLACE_TYPE @"place_type"
#define PLACE_TYPE_ID @"place_type_id"
#define URL @"place_url"
#define TIMEZONE "timezone"
#define WOE_NAME "woe_name"
#define WOE_ID "woeid"

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
    NSString *content = [place objectForKey:CONTENT];
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
