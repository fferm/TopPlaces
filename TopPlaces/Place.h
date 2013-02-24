//
//  Place.h
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-02-08.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Place : NSObject<MKAnnotation>
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *location;
@property (nonatomic, readonly) NSString *country;
;
-(NSArray *)getPhotos; // of Photo objects

+(NSArray *)topPlaces;
+(NSComparator)comparator;

@end
