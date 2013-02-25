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
@property (nonatomic, readonly) NSString *flickrTitle;
@property (nonatomic, readonly) NSString *flickrDescription;

@end
@implementation Photo
@synthesize title = _title;
@synthesize subtitle = _subtitle;

@synthesize flickrTitle = _flickrTitle;
@synthesize flickrDescription = _flickrDescription;
@synthesize flickrDict = _flickrDict;
@synthesize url = _url;
@synthesize image = _image;
@synthesize photoId = _photoId;

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

-(NSString *)flickrTitle {
    return [self.flickrDict objectForKey:FLICKR_PHOTO_TITLE];
}

-(NSString *)flickrDescription {
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
