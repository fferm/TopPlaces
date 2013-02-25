//
//  TopPlacesPhotosTableViewController.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-02-14.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "TopPlacesPhotosTableViewController.h"
#import "Photo.h"
#import "ImageViewController.h"
#import "UserDefaultsManager.h"

@interface TopPlacesPhotosTableViewController()
@end

@implementation TopPlacesPhotosTableViewController

-(NSString *)cellTitleFor:(id)selectedObject {
    Photo *photo = (Photo *)selectedObject;
    return photo.title;
}

-(NSString *)cellDescriptionFor:(id)selectedObject {
    Photo *photo = (Photo *)selectedObject;
    return photo.subtitle;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ImageSegue"]) {
        ImageViewController *vc = segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Photo *photo = [self selectedObjectAt:indexPath];
        vc.photo = photo;
        
        [UserDefaultsManager addPhotoIfNotAlreadyPresent:photo];
    }
}

@end
