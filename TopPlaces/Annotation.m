//
//  Annotation.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-02-23.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "Annotation.h"

@interface Annotation()
@property (nonatomic, strong) Place *place;
@end

@implementation Annotation
@synthesize place = _place;

+(Annotation *)createWithPlace:(Place *)place{
    Annotation *ret = [[Annotation alloc] init];
    ret.place = place;
    return ret;
}

-(CLLocationCoordinate2D)coordinate{
    NSNumber *lat = self.place.latitude;
    NSNumber *lon = self.place.longitude;
    
    CLLocationCoordinate2D ret;
    ret.latitude = [lat doubleValue];
    ret.longitude = [lon doubleValue];
    
    return ret;
}
@end
