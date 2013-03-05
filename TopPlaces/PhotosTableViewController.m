//
//  PhotosTableViewController.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-01-31.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "PhotosTableViewController.h"
#import "Animator.h"

@interface PhotosTableViewController ()
@property (nonatomic, strong) NSArray *photos;
@end

@implementation PhotosTableViewController
@synthesize place = _place;
@synthesize photos = _photos;

-(NSArray *)photos {
    if (!_photos) {

        [self.animator startAnimation];
        
        dispatch_queue_t downloadQueue = dispatch_queue_create("photos downloader", NULL);
        dispatch_async(downloadQueue, ^{
            NSArray *photos = [self.place getPhotos];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.photos = photos;
                [self.animator hideAnimation];
            });
        });
    }
    return _photos;
}

-(void)setPhotos:(NSArray *)photos {
    _photos = photos;
    [self.tableView reloadData];
}

-(void)setPlace:(Place *)place {
    _place = place;
    self.title = [NSString stringWithFormat:@"Photos at %@", place.title , nil];
}

#pragma mark - TopPlacesTableViewControllerDelegate

-(NSString *)cellIdentifier {
    return @"PhotoCell";
}

-(id)selectedObjectAt:(NSIndexPath *)indexPath {
    return [self.photos objectAtIndex:indexPath.row];
}

-(NSInteger)countForSection:(NSInteger)section {
    return [self.photos count];
}

-(NSArray *)annotations {
    return self.photos;
}

@end
