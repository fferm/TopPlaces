//
//  PhotosModel.h
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-01-31.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"
#import "Place.h"

@interface PhotosModel : NSObject
@property (nonatomic, strong) Place *place;

-(NSInteger)count;
-(Photo *)photoAtIndex:(NSInteger)index;
@end
