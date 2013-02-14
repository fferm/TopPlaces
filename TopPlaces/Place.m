//
//  Place.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-02-08.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "Place.h"
#import "FlickrFetcher.h"
#import "Photo.h"

@interface Place()
@property (nonatomic, strong) NSDictionary *flickrDict;
@end

@implementation Place
@synthesize flickrDict = _flickrDict;
@synthesize title = _title;
@synthesize description = _description;
@synthesize photos = _photos;

+(Place *)placeWithFlickrDictionary:(NSDictionary *)dict {
    Place *place = [[Place alloc] init];
    
    place.flickrDict = dict;
    
    return place;
}

+(NSArray *)sortedPlaces {
    NSArray *flickrPlaces = [FlickrFetcher topPlaces];
    
    NSMutableArray *mutRet = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSDictionary *flickrPlace in flickrPlaces) {
        [mutRet addObject:[Place placeWithFlickrDictionary:flickrPlace]];
    }
    
    return [mutRet sortedArrayUsingComparator: ^(id obj1, id obj2) {
        Place *p1 = (Place *)obj1;
        Place *p2 = (Place *)obj2;
        
        return [p1.title compare:p2.title];
    }];
}

-(NSArray *) dividedContentString {
    NSString *content = [self.flickrDict objectForKey:FLICKR_PLACE_NAME];
    return [content componentsSeparatedByString:@","];
}

-(NSString *)title {
        return [[self dividedContentString] objectAtIndex:0];
}

-(NSString *)description {
    NSMutableArray *desc = [[self dividedContentString] mutableCopy];
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

-(NSArray *)photos {
    if (!_photos) {
        [self resetPhotos];
    }
    return _photos;
}

-(void)resetPhotos {
    NSArray *flickrArray = [FlickrFetcher photosInPlace:self.flickrDict maxResults:50];
    NSMutableArray *mutRet = [NSMutableArray array];
    
    for (NSDictionary *flickrPhoto in flickrArray) {
        [mutRet addObject:[Photo photoFromFlickrDictionary:flickrPhoto]];
    }
    _photos = [mutRet copy];
}

@end
