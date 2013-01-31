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
- (NSString *) placeNameAtIndex:(NSInteger)index;
- (NSString *) descriptionAtIndex:(NSInteger)index;
- (NSString *) idAtIndex:(NSInteger)index;

@end
