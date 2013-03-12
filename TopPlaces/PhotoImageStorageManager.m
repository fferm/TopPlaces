//
//  PhotoImageStorageManager.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-03-11.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "PhotoImageStorageManager.h"
@interface PhotoImageStorageManager()
@property (nonatomic, readonly) NSFileManager *fileManager;
@end
@implementation PhotoImageStorageManager

#define IMAGE_CACHE_DIR @"imageCache"
#define IMAGE_EXTENSION @"full"
#define CALLOUT_EXTENSION @"callout"

-(NSFileManager *)fileManager{
    return [[NSFileManager alloc] init];
}

-(UIImage *)imageForPhoto:(Photo *)photo{
    return [self uiImageForPhoto:photo imageYesCalloutNo:YES];
}

-(UIImage *)calloutForPhoto:(Photo *)photo{
    return [self uiImageForPhoto:photo imageYesCalloutNo:NO];
}

-(UIImage *)uiImageForPhoto:(Photo *)photo imageYesCalloutNo:(BOOL)imageYesCalloutNo{
    NSString *path = [self pathForPhoto:photo imageYesCalloutNo:imageYesCalloutNo];
    
    UIImage *ret;
    
    // Check if file already exists
    if ([self.fileManager fileExistsAtPath:path]) {
        // if it does, read and return it
        NSLog(@"Exists");
    } else {
        // if it doesn't: download, possibly flush and save
        NSData *data = [self downloadImage:photo imageYesCalloutNo:imageYesCalloutNo];
        ret = [UIImage imageWithData:data];
        
        
        // TODO: flush and save
    }
    
    return ret;
}

-(NSString *)dirPath{
    return [[self.fileManager URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask].lastObject path];
}

-(NSString *)pathForPhoto:(Photo *)photo imageYesCalloutNo:(BOOL)imageYesCalloutNo {
    NSString *extension = imageYesCalloutNo ? IMAGE_EXTENSION : CALLOUT_EXTENSION;
    return [[[[self dirPath] stringByAppendingPathComponent:IMAGE_CACHE_DIR] stringByAppendingPathComponent:photo.photoId] stringByAppendingPathExtension:extension];
}


-(NSData *)downloadImage:(Photo *)photo imageYesCalloutNo:(BOOL)imageYesCalloutNo {
    NSURL *url = imageYesCalloutNo ? photo.url : photo.calloutUrl;
    return [NSData dataWithContentsOfURL:url];
}

@end
