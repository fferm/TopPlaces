//
//  PhotosModel.h
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-01-31.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotosModel : NSObject
@property (nonatomic, strong) NSDictionary *place;

-(NSInteger)count;
-(NSString *)titleAtIndex:(NSInteger)index;
-(NSString *)subtitleAtIndex:(NSInteger)index;
-(NSString *)placeTitle;
@end
