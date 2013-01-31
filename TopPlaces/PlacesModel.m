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
            return [[self nameForPlace:obj1] compare:[self nameForPlace:obj2]];
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

-(NSString *)nameForPlace:(NSDictionary *)place {
    return [[self dividedContentStringForPlace:place] objectAtIndex:0];
}

-(NSString *)descriptionForPlace:(NSDictionary *)place {
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

-(NSString *) placeNameAtIndex:(NSInteger)index {
    return [self nameForPlace:[self placeAtIndex:index]];
}

-(NSString *) descriptionAtIndex:(NSInteger)index {
    return [self descriptionForPlace:[self placeAtIndex:index]];
}

@end
