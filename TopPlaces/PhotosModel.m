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
        _photos = [self.place photos];
    }
    return _photos;
}

-(Photo *)photoAtIndex:(NSInteger)index {
    return [self.photos objectAtIndex:index];
}
    
-(NSInteger)count {
    return self.photos.count;
}
@end
