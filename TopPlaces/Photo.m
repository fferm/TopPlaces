//
//  Photo.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-02-07.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "Photo.h"
#import "FlickrFetcher.h"

static NSMutableDictionary *images = nil;

@interface Photo()
@end
@implementation Photo
@synthesize title = _title;
@synthesize description = _description;
@synthesize flickrDict = _flickrDict;
@synthesize url = _url;
@synthesize image = _image;
@synthesize photoId = _photoId;

-(NSString *)title {
    return [self.flickrDict objectForKey:FLICKR_PHOTO_TITLE];
}

-(NSString *)description {
    return [[self.flickrDict objectForKey:FLICKR_PHOTO_DESCRIPTION] objectForKey:FLICKR_PHOTO_CONTENT];
}

-(UIImage *)image {
    if (!_image) {
        _image = [self createUIImage];
    }
    return _image;
}

-(UIImage *)createUIImage {
    if (!images) {
        images = [NSMutableDictionary dictionary];
    }
    
    UIImage *ret = [images objectForKey:self.photoId];

    if (!ret) {
        NSData *data = [NSData dataWithContentsOfURL:self.url];
        ret = [UIImage imageWithData:data];

        if (ret) {
            [images setObject:ret forKey:self.photoId];
        }
    }

    return ret;
}

-(NSURL *)url {
    return [FlickrFetcher urlForPhoto:self.flickrDict format:FlickrPhotoFormatLarge];
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
