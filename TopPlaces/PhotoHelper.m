//
//  PhotoHelper.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-02-05.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "PhotoHelper.h"
#import "FlickrFetcher.h"

@implementation PhotoHelper

+(NSString *)titleDataForPhoto:(NSDictionary *)photo {
    return [photo objectForKey:FLICKR_PHOTO_TITLE];
}

+(NSString *)descriptionDataForPhoto:(NSDictionary *)photo {
    //  return [photo objectForKey:FLICKR_PHOTO_DESCRIPTION];
    return [[photo objectForKey:FLICKR_PHOTO_DESCRIPTION] objectForKey:FLICKR_PHOTO_CONTENT];
}



+(NSString *)titleForPhoto:(NSDictionary *)photo {
    NSString *ret = [self titleDataForPhoto:photo];
    if (!ret || ret.length == 0) {
        ret = [self descriptionDataForPhoto:photo];
    }
    if (!ret || ret.length == 0) {
        ret = @"Unknown";
    }
    
    return ret;

}

+ (NSString *)subtitleForPhoto:(NSDictionary *)photo {
    NSString *ret = @"";
    NSString *title = [self titleDataForPhoto:photo];
    if (title && title.length > 0) {
        ret = [self descriptionDataForPhoto:photo];
    }
    return ret;
}

@end
