//
//  PlacesModel.h
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-01-30.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlacesModel : NSObject

- (NSInteger) count;
- (NSString *) titleAtIndex:(NSInteger)index;
- (NSString *) subtitleAtIndex:(NSInteger)index;
- (NSDictionary *) placeAtIndex:(NSInteger)index;

+ (NSString *)titleForPlace:(NSDictionary *)place;

@end
