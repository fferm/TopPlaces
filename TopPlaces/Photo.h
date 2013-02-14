//
//  Photo.h
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-02-07.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Image;

@interface Photo : NSObject
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *description;
@property (nonatomic, readonly) NSURL *url;
@property (nonatomic, readonly) UIImage *image;
@property (nonatomic, readonly) NSString *photoId;
@property (nonatomic, strong) NSDictionary *flickrDict;

+(Photo *)photoFromFlickrDictionary:(NSDictionary *)dict;

@end
