//
//  PhotosModel.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-01-31.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "PhotosModel.h"
#import "FlickrFetcher.h"

@interface PhotosModel()
@property (nonatomic, strong) NSArray *flickrPhotos;
@end

@implementation PhotosModel
@synthesize place = _place;
@synthesize flickrPhotos = _flickrPhotos;

#define TITLE @"title"
#define DESCRIPTION @"description"
#define CONTENT @"_content"

-(NSArray *)flickrPhotos {
    if (!_flickrPhotos) {
        _flickrPhotos = [FlickrFetcher photosInPlace:self.place maxResults:50];
        NSLog(_flickrPhotos.description);
    }
    return _flickrPhotos;
}

-(NSInteger)count {
    return self.flickrPhotos.count;
}

-(NSString *)titleDataForPhoto:(NSDictionary *)photo {
    return [photo objectForKey:TITLE];
}

-(NSString *)descriptionDataForPhoto:(NSDictionary *)photo {
    return [[photo objectForKey:DESCRIPTION] objectForKey:CONTENT];
}

-(NSString *)titleAtIndex:(NSInteger)index {
    NSDictionary *photo = [self.flickrPhotos objectAtIndex:index];
    
    NSString *ret = [self titleDataForPhoto:photo];
    if (!ret || ret.length == 0) {
        ret = [self descriptionDataForPhoto:photo];
    }
    if (!ret || ret.length == 0) {
        ret = @"Unknown";
    }
    
    return ret;
}

-(NSString *)subtitleAtIndex:(NSInteger)index {
    NSDictionary *photo = [self.flickrPhotos objectAtIndex:index];

    NSString *ret = @"";
    NSString *title = [self titleDataForPhoto:photo];
    if (title && title.length > 0) {
        ret = [self descriptionDataForPhoto:photo];
    }
    return ret;
}
@end
