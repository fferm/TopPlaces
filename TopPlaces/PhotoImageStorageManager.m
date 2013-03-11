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

-(NSFileManager *)fileManager{
    return [[NSFileManager alloc] init];
}

-(UIImage *)imageForPhoto:(Photo *)photo{
    // Check if file already exists
    if ([self photoAlreadyExists:photo]) {
        // if it does, read and return it
        
    } else {
        // if it doesn't: download, possibly flush and save
        
    }

    
    NSLog(@"photoPath: %@", [self pathForPhoto:photo]);
    NSLog(@"calloutPath: %@", [self pathForCallout:photo]);
    
    return nil;
}

-(UIImage *)calloutForPhoto:(Photo *)photo{
    NSLog(@"Callout URL: %@", photo.calloutUrl);
    return nil;
}

-(BOOL)photoAlreadyExists:(Photo *)photo{
    
    return NO;
}

-(NSString *)dirPath{
    return [[self.fileManager URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask].lastObject path];
}

-(NSString *)pathForPhoto:(Photo *)photo{
    return [[[self dirPath] stringByAppendingPathComponent:photo.photoId] stringByAppendingPathExtension:@"full"];
}

-(NSString *)pathForCallout:(Photo *)photo{
    return [[[self dirPath] stringByAppendingPathComponent:photo.photoId] stringByAppendingPathExtension:@"callout"];
}

-(NSData *)downloadFromUrl:(NSURL *)url {
    return [NSData dataWithContentsOfURL:url];
}


/*if (!_calloutImage) { // Har medvetet valt att inte cacha denna bild, då det ändå behöver ändras då inga bilder skall lagras i minnet
    NSURL *photoUrl = [FlickrFetcher urlForPhoto:self.flickrDict format:FlickrPhotoFormatSquare];
    NSData *data = [NSData dataWithContentsOfURL:photoUrl];
    _calloutImage = [UIImage imageWithData:data];
}
return _calloutImage;
}

-(UIImage *)createUIImage {
    if (!images) {          // images verkar inte vara en medlemsvariabel utan skapas när denna kod körs första gången.
        // Detta behöver ändå ändras då inga bilder skall lagras i minnet, så jag gör ingenting nu
        images = [NSMutableDictionary dictionary];
    }
    
    UIImage *ret = [images objectForKey:self.photoId];
    
    if (!ret) {
        NSData *data = [NSData dataWithContentsOfURL:self.url];
        ret = [UIImage imageWithData:data];
        
        if (ret) {
            [images setObject:ret forKey:self.photoId];
        }
    }
    
    return ret;
}*/

@end
