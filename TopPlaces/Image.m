//
//  Images.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-02-12.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "Image.h"

static NSMutableDictionary *images = nil;

@implementation Image
@synthesize uiImage = _uiImage;

+(Image *)imageForPhoto:(Photo *)photo {
    Image *image = [[Image alloc] init];
    
    NSData *data = [NSData dataWithContentsOfURL:photo.url];
    UIImage *uiImage = [UIImage imageWithData:data];
    
    image.uiImage = uiImage;
    
    return image;
}

/*+(void)ensureImagesCreated {
    if (!images) {
        images = [NSMutableDictionary dictionary];
    }
}

-(UIImage *)imageForPhoto:(Photo *)photo {
    [self ensureImagesCreated];
    
    return [images objectForKey:photo.photoId];
}

-(void)addImageInPhoto:(Photo *)photo {
    [self ensureImagesCreated];
    
    if (photo.image) {
        [images setObject:photo.image forKey:photo.photoId];
    }
}*/

@end
