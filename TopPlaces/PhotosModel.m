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
#import "PhotoHelper.h"

@interface PhotosModel()
@property (nonatomic, strong) NSArray *flickrPhotos;
@end

@implementation PhotosModel
@synthesize place = _place;
@synthesize flickrPhotos = _flickrPhotos;

-(NSArray *)flickrPhotos {
    if (!_flickrPhotos) {
        _flickrPhotos = [FlickrFetcher photosInPlace:self.place maxResults:50];
    }
    return _flickrPhotos;
}

-(NSDictionary *)photoAtIndex:(NSInteger)index {
    return [self.flickrPhotos objectAtIndex:index];
}
    
-(NSInteger)count {
    return self.flickrPhotos.count;
}

-(NSString *)titleAtIndex:(NSInteger)index {
    NSDictionary *photo = [self photoAtIndex:index];
    return [PhotoHelper titleForPhoto:photo];
}

-(NSString *)subtitleAtIndex:(NSInteger)index {
    NSDictionary *photo = [self photoAtIndex:index];
    return [PhotoHelper subtitleForPhoto:photo];
}

-(NSString *)placeTitle {
    return [PlacesModel titleForPlace:self.place];
}
@end
