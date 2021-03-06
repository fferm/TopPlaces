//
//  UserDefaultsManager.h
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-02-11.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

@interface UserDefaultsManager : NSObject

+(void)addPhotoIfNotAlreadyPresent:(Photo *)photo;
+(Photo *)photoAtIndex:(NSInteger)index;
+(void)clear;
+(NSArray *)savedFlickrPhotos;
+(NSInteger)count;
@end
