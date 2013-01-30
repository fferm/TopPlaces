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

@end

@implementation PlacesModel

@synthesize flickrPlaces = _flickrPlaces;

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

- (NSArray *)flickrPlaces {
    if (!_flickrPlaces) {
        _flickrPlaces = [FlickrFetcher topPlaces];
    }
    return _flickrPlaces;
}

-(NSInteger) count {
    return [self.flickrPlaces count];
}

- (NSDictionary *) placeDataAtIndex:(NSUInteger)idx {
    return [self.flickrPlaces objectAtIndex:idx];
}

- (NSArray *) dividedContentStringAtIndex:(NSInteger)index {
    NSDictionary *place = [self placeDataAtIndex:index];
    NSString *content = [place objectForKey:CONTENT];
    return [content componentsSeparatedByString:@","];
}

-(NSString *) placeNameAtIndex:(NSInteger)index {
    return [[self dividedContentStringAtIndex:index] objectAtIndex:0];
}

-(NSString *) countryNameAtIndex:(NSInteger)index {
    return [[self dividedContentStringAtIndex:index] lastObject];
}

//@property (nonatomic, strong) NSDictionary *placeData;
//@property (nonatomic, strong) NSArray *placeIdsSortedByName;
//@property (nonatomic, strong) NSArray *sortedCities;
//@property (nonatomic, strong) NSDictionary *countryForCity;

//NSInteger placeSort(id obj1, id obj2, void *context);
//- (void) initData;
//@synthesize flickrPlaces = _flickrPlaces;
//@synthesize placeData = _placeData;
//@synthesize placeIdsSortedByName = _placeIdsSortedByName;

//@synthesize sortedCities = _sortedCities;
//@synthesize countryForCity = _countryForCity;

/*
 
 - (NSArray *)placeIdsSortedByName {
 if (!_placeIdsSortedByName) {
 
 }
 return _placeIdsSortedByName;
 }
 
 #define ID_TYPE @"place_id"
 
 - (void) setupPlaceData {
 NSMutableDictionary *work = [[NSMutableDictionary alloc]initWithCapacity:self.flickrPlaces.count];
 for (NSDictionary *flickrPlace in self.flickrPlaces) {
 NSString *placeId = [flickrPlace objectForKey:ID_TYPE];
 [work setObject:flickrPlace forKey:placeId];
 }
 }
*/

/*- (NSArray *)sortedCities {
 if (!_sortedCities) {
 [self initData];
 }
 return _sortedCities;
 }
 
 - (NSDictionary *)countryForCity {
 if (!_countryForCity) {
 [self initData];
 }
 return _countryForCity;
 }*/

/*NSInteger placeSort(id obj1, id obj2, void *context)
 {
 NSString *s1 = obj1;
 NSString *s2 = obj2;
 return [s1 compare:s2];
 }*/

/*- (void) initData {
 NSMutableArray *citiesWork = [[NSMutableArray alloc] initWithCapacity:self.places.count];
 NSMutableDictionary *countryWork = [[NSMutableDictionary alloc] initWithCapacity:self.places.count];
 
 for (NSDictionary *placeDict in self.places) {
 NSString *_content = [placeDict objectForKey:@"_content"];
 NSArray *dividedContent = [_content componentsSeparatedByString:@","];
 
 NSString *city = [dividedContent objectAtIndex:0];
 NSString *country = [dividedContent lastObject];
 
 [citiesWork addObject:city];
 [countryWork setObject:country forKey:city];
 }
 
 _sortedCities = [citiesWork sortedArrayUsingFunction:placeSort context:NULL];
 _countryForCity = [countryWork copy];
 }*/


@end
