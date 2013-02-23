//
//  Annotation.h
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-02-23.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Place.h"

@interface Annotation : NSObject<MKAnnotation>

+(Annotation *)createWithPlace:(Place *)place;
@end
