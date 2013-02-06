//
//  PhotosModel.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-01-31.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "PhotosModel.h"
#import "FlickrFetcher.h"
#import "PlacesModel.h"

@interface PhotosModel()
@property (nonatomic, strong) NSArray *photos;
@end

@implementation PhotosModel
@synthesize place = _place;
@synthesize photos = _photos;

-(NSArray *)photos {
    
    if (!_photos) {
        NSMutableArray *work = [[NSMutableArray alloc] init];
        NSArray *flickrPhotos = [FlickrFetcher photosInPlace:self.place maxResults:50];
        for (NSDictionary *dict in flickrPhotos) {
            Photo *photo = [[Photo alloc] initWithFlickrDictionary:dict];
            [work addObject:photo];
        }
        return [work copy];
        
    }
    return _photos;
}

-(Photo *)photoAtIndex:(NSInteger)index {
    return [self.photos objectAtIndex:index];
}
    
-(NSInteger)count {
    return self.photos.count;
}

-(NSString *)placeTitle {
    return [PlacesModel titleForPlace:self.place];
}
@end
