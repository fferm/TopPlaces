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
@property (nonatomic, strong) NSDictionary *flickrDict;

@end
@implementation Photo
@synthesize title = _title;
@synthesize subtitle = _subtitle;
@synthesize flickrDict = _flickrDict;
@synthesize url = _url;

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

-(NSURL *)url {
    return [FlickrFetcher urlForPhoto:self.flickrDict format:FlickrPhotoFormatOriginal];
}

-(id)initWithFlickrDictionary:(NSDictionary *)dict {
    self = [super init];
    
    self.flickrDict = dict;
    
    return self;
}

-(NSString *)titleData {
    return [self.flickrDict objectForKey:FLICKR_PHOTO_TITLE];
}

-(NSString *)descriptionData {
    return [[self.flickrDict objectForKey:FLICKR_PHOTO_DESCRIPTION] objectForKey:FLICKR_PHOTO_CONTENT];
}


@end
