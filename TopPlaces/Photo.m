//
//  Photo.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-02-07.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "Photo.h"
#import "FlickrFetcher.h"

@interface Photo()

@end
@implementation Photo
@synthesize title = _title;
@synthesize subtitle = _subtitle;
@synthesize flickrDict = _flickrDict;
@synthesize url = _url;
@synthesize image = _image;
@synthesize photoId = _photoId;

-(NSString *)title {
    NSString *ret = [self titleData];
    if (!ret || ret.length == 0) {
        ret = [self descriptionData];
    }
    if (!ret || ret.length == 0) {
        ret = @"Unknown";
    }
    
    return ret;
}

-(NSString *)subtitle {
    NSString *ret = @"";
    if (self.title && self.title.length > 0) {
        ret = [self descriptionData];
    }
    return ret;
}

-(UIImage *)image {
    if (!_image) {
        NSData *data = [NSData dataWithContentsOfURL:self.url];
        _image = [UIImage imageWithData:data];
    }
    return _image;
}

-(NSURL *)url {
    return [FlickrFetcher urlForPhoto:self.flickrDict format:FlickrPhotoFormatOriginal];
}

-(NSString *) photoId{
    return [self.flickrDict objectForKey:FLICKR_PHOTO_ID];
}

+(Photo *)photoFromFlickrDictionary:(NSDictionary *)dict {
    Photo *photo = [[Photo alloc] init];
    photo.flickrDict = dict;
    return photo;
}

-(NSString *)titleData {
    return [self.flickrDict objectForKey:FLICKR_PHOTO_TITLE];
}

-(NSString *)descriptionData {
    return [[self.flickrDict objectForKey:FLICKR_PHOTO_DESCRIPTION] objectForKey:FLICKR_PHOTO_CONTENT];
}


@end
