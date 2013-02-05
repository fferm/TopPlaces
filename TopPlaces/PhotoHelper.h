//
//  PhotoHelper.h
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-02-05.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoHelper : NSObject

+(NSString *)titleForPhoto:(NSDictionary *)photo;
+(NSString *)subtitleForPhoto:(NSDictionary *)photo;
@end
