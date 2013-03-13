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
#define MAX_SIZE 10 * 1000 * 1000     // 10 MB

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
    NSData *data;
    
    // Check if file already exists
    if ([self.fileManager fileExistsAtPath:path]) {
        // if it does, read and return it
        data = [NSData dataWithContentsOfFile:path];
        
    } else {
        // if it doesn't: download, possibly flush and save
        data = [self downloadImage:photo imageYesCalloutNo:imageYesCalloutNo];

        [self writeData:data atPath:path];

        [self flushDirectory];
    }
    return [UIImage imageWithData:data];
}

-(void)writeData:(NSData *)data atPath:(NSString *)path{
    BOOL isDir;
    if (! ([self.fileManager fileExistsAtPath:[self dirPath] isDirectory:&isDir] && isDir)) {
        BOOL success = [self.fileManager createDirectoryAtPath:[self dirPath] withIntermediateDirectories:YES attributes:nil error:nil];
        if (!success) {
            NSLog(@"Error trying to create directory %@", [self dirPath]);
            return;
        }
    }
    
    BOOL success = [self.fileManager createFileAtPath:path contents:data attributes:nil];
    if (!success) {
        NSLog(@"Error trying to create file %@", path);
        return;
    }
}

-(void)flushDirectory{
    NSArray *fileNames = [self.fileManager contentsOfDirectoryAtPath:[self dirPath] error:nil];
    
    // Get attributes of all files, simultaneously add up sizes to check if we need to do more
    NSMutableDictionary *attributesByFilename = [NSMutableDictionary dictionary];
    
    long long totalSize = 0;
    for (NSString *fileName in fileNames) {
        NSDictionary *attributes = [self.fileManager attributesOfItemAtPath:[[self dirPath] stringByAppendingPathComponent:fileName] error:nil];
        [attributesByFilename setObject:attributes forKey:fileName];
        long long size = [(NSNumber *)[attributes objectForKey:NSFileSize] longLongValue];
        totalSize += size;
    }
    
    if (totalSize < MAX_SIZE) return;
    
    // Sort files by date
    NSMutableArray *fileNamesSortedByDateAscending = [fileNames mutableCopy];
    [fileNamesSortedByDateAscending sortUsingComparator:^NSComparisonResult(id obj1, id obj2){
        NSString *fileName1 = (NSString *)obj1;
        NSString *fileName2 = (NSString *)obj2;
        
        NSDictionary *attributes1 = [attributesByFilename objectForKey:fileName1];
        NSDictionary *attributes2 = [attributesByFilename objectForKey:fileName2];
        
        NSDate *date1 = [attributes1 objectForKey:NSFileCreationDate];
        NSDate *date2 = [attributes2 objectForKey:NSFileCreationDate];
        
        return [date1 compare:date2];
    }];
    
    long long flushNeeded = totalSize - MAX_SIZE;
    long long flushedSoFar = 0;
    for (NSString *fileName in fileNamesSortedByDateAscending) {
        NSDictionary *attributes = [attributesByFilename objectForKey:fileName];
        long long size = [(NSNumber *)[attributes objectForKey:NSFileSize] longLongValue];
        
        [self.fileManager removeItemAtPath:[[self dirPath] stringByAppendingPathComponent:fileName] error:nil];
        
        flushedSoFar += size;

        if (flushedSoFar > flushNeeded) break;
    }
}

-(NSString *)dirPath{
    return [[[self.fileManager URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask].lastObject path] stringByAppendingPathComponent:IMAGE_CACHE_DIR];
}

-(NSString *)pathForPhoto:(Photo *)photo imageYesCalloutNo:(BOOL)imageYesCalloutNo {
    NSString *extension = imageYesCalloutNo ? IMAGE_EXTENSION : CALLOUT_EXTENSION;
    return [[[self dirPath] stringByAppendingPathComponent:photo.photoId] stringByAppendingPathExtension:extension];
}


-(NSData *)downloadImage:(Photo *)photo imageYesCalloutNo:(BOOL)imageYesCalloutNo {
    NSURL *url = imageYesCalloutNo ? photo.url : photo.calloutUrl;
    return [NSData dataWithContentsOfURL:url];
}

@end
