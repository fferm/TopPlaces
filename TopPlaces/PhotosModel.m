//
//  PhotosModel.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-03-08.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "PhotosModel.h"
#import "Photo.h"

@implementation PhotosModel
@synthesize place = _place;
@synthesize photos = _photos;

#pragma mark initialization

+(PhotosModel *)modelForPlace:(Place *)place{
    PhotosModel *ret = [[PhotosModel alloc] init];
    ret.place = place;
    
    return ret;
}

#pragma mark accessors
-(NSArray *)photos {
    if (!_photos) {
        [self.eventTarget willDownload];
        
        dispatch_queue_t downloadQueue = dispatch_queue_create("photos downloader", NULL);
        dispatch_async(downloadQueue, ^{
            NSArray *photos = [self.place getPhotos];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.photos = photos;
                [self.eventTarget didDownload];
            });
        });
    }
    return _photos;
}

-(void)setPhotos:(NSArray *)photos {
    _photos = photos;
    [self.eventTarget needsReload];
}

-(void)setPlace:(Place *)place {
    _place = place;
    [self.eventTarget needsReload];
}

#pragma mark - TopPlacesTableViewControllerDelegate

-(NSString *)cellTitleFor:(id)selectedObject {
    Photo *photo = (Photo *)selectedObject;
    return photo.title;
}

-(NSString *)cellDescriptionFor:(id)selectedObject {
    Photo *photo = (Photo *)selectedObject;
    return photo.subtitle;
}

-(id)selectedObjectAt:(NSIndexPath *)indexPath {
    return [self.photos objectAtIndex:indexPath.row];
}

-(NSInteger)countForSection:(NSInteger)section {
    return [self.photos count];
}

-(NSArray *)allObjects {
    return self.photos;
}

-(NSInteger)countOfSections{
    return 1;
}

-(NSString *)sectionHeaderTitle:(NSInteger)section {
    return nil;
}



@end
