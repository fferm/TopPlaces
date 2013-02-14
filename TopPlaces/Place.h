//
//  Place.h
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-02-08.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Place : NSObject
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *description;
@property (nonatomic, readonly) NSArray *photos; // of Photo objects

+(NSArray *)sortedPlaces;

-(void)resetPhotos;

@end
