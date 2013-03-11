//
//  PhotoImageStorageManager.h
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-03-11.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

@interface PhotoImageStorageManager : NSObject
-(UIImage *)imageForPhoto:(Photo *)photo;
-(UIImage *)calloutForPhoto:(Photo *)photo;
@end
