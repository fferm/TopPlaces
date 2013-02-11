//
//  UserDefaultsManager.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-02-11.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "UserDefaultsManager.h"

#define RECENT_PHOTOS @"RecentPhotos"

@implementation UserDefaultsManager

+(void)addPhoto:(Photo *)photo {
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSMutableArray *defaults = [[userDef objectForKey:RECENT_PHOTOS] mutableCopy];
    if (!defaults) {
        defaults = [NSMutableArray arrayWithCapacity:1];
    }
    
    [defaults insertObject:photo.flickrDict atIndex:0];
    
    [userDef setObject:[defaults copy] forKey:RECENT_PHOTOS];
    [userDef synchronize];
}

+(NSArray *)savedFlickrPhotos {
    return [[NSUserDefaults standardUserDefaults] objectForKey:RECENT_PHOTOS];
}

+(Photo *)photoAtIndex:(NSInteger)index {
    return [Photo photoFromFlickrDictionary:[[self savedFlickrPhotos] objectAtIndex:index]];
}

+(NSInteger)count {
    return [self savedFlickrPhotos].count;
}

+(void)clear {
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSMutableArray *defaults = [[userDef objectForKey:RECENT_PHOTOS] mutableCopy];

    [defaults removeAllObjects];
    
    [userDef setObject:[defaults copy] forKey:RECENT_PHOTOS];
    [userDef synchronize];
}

@end
