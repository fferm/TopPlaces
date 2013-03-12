//
//  Photo.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-02-07.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "Photo.h"
#import "FlickrFetcher.h"
#import "PhotoImageStorageManager.h"

@interface Photo()
@property (nonatomic, readonly) NSString *flickrTitle;
@property (nonatomic, readonly) NSString *flickrDescription;
@property (nonatomic, readonly) PhotoImageStorageManager *imageStorage;

@end
@implementation Photo
@synthesize flickrTitle = _flickrTitle;
@synthesize flickrDescription = _flickrDescription;
@synthesize flickrDict = _flickrDict;
@synthesize photoId = _photoId;
@synthesize imageStorage = _imageStorage;
@synthesize title = _title;
@synthesize subtitle = _subtitle;


-(NSString *)title {
    NSString *ret = self.flickrTitle;
    if (!ret || ret.length == 0) {
        ret = self.flickrDescription;
    }
    if (!ret || ret.length == 0) {
        ret = @"Unknown";
    }
    return ret;
}

-(NSString *)subtitle {
    if (self.flickrTitle && self.flickrTitle.length > 0) {
        return self.flickrDescription;
    } else {
        return @"";
    }
}

-(PhotoImageStorageManager *)imageStorage{
    if (!_imageStorage) {
        _imageStorage = [[PhotoImageStorageManager alloc] init];
    }
    return _imageStorage;
}

-(NSString *)flickrTitle {
    return [self.flickrDict objectForKey:FLICKR_PHOTO_TITLE];
}

-(NSString *)flickrDescription {
    return [[self.flickrDict objectForKey:FLICKR_PHOTO_DESCRIPTION] objectForKey:FLICKR_PHOTO_CONTENT];
}

-(UIImage *)image {
    return [self.imageStorage imageForPhoto:self];
}

-(UIImage *)calloutImage {
    return [self.imageStorage calloutForPhoto:self];
}

-(NSURL *)url {
    return [FlickrFetcher urlForPhoto:self.flickrDict format:FlickrPhotoFormatLarge];
}

-(NSURL *)calloutUrl{
    return [FlickrFetcher urlForPhoto:self.flickrDict format:FlickrPhotoFormatSquare];
}

-(NSString *)photoId{
    return [self.flickrDict objectForKey:FLICKR_PHOTO_ID];
}

+(Photo *)photoFromFlickrDictionary:(NSDictionary *)dict {
    Photo *photo = [[Photo alloc] init];
    photo.flickrDict = dict;
    return photo;
}

-(BOOL)isEqual:(id)object {
    if (! [object isKindOfClass:[Photo class]]) {
        return NO;
    }
    Photo *otherPhoto = (Photo *)object;
    return [self.photoId isEqual:otherPhoto.photoId];
}

-(CLLocationCoordinate2D)coordinate{
    CLLocationCoordinate2D ret;
    ret.latitude = [[self.flickrDict objectForKey:FLICKR_LATITUDE] doubleValue];
    ret.longitude = [[self.flickrDict objectForKey:FLICKR_LONGITUDE] doubleValue];
    
    return ret;
}


@end
