//
//  RecentPhotosModel.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-03-10.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "RecentPhotosModel.h"
#import "Entity.h"
#import "UserDefaultsManager.h"
#import "Photo.h"

@implementation RecentPhotosModel

-(Entity *)selectedObjectAt:(NSIndexPath *)indexPath{
    return [UserDefaultsManager photoAtIndex:indexPath.row];
}

-(NSArray *)allObjects {
    NSArray *flickrPhotos = [UserDefaultsManager savedFlickrPhotos];
    NSMutableArray *photos = [NSMutableArray array];
    for (int i = 0; i < flickrPhotos.count; i++) {
        NSDictionary *flickrPhoto = [flickrPhotos objectAtIndex:i];
        [photos addObject:[Photo photoFromFlickrDictionary:flickrPhoto]];
    }
    return [photos copy];
}

-(NSInteger)count {
    return [UserDefaultsManager count];
}

-(void)clear {
    [UserDefaultsManager clear];
    [self.eventTarget needsReload];
}

@end
