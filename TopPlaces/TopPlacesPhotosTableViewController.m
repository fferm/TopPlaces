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

    NSString *ret = photo.title;
    if (!ret || ret.length == 0) {
        ret = photo.description;
    }
    if (!ret || ret.length == 0) {
        ret = @"Unknown";
    }
    
    return ret;
}

-(NSString *)cellDescriptionFor:(id)selectedObject {
    Photo *photo = (Photo *)selectedObject;
    if (photo.title && photo.title.length > 0) {
        return photo.description;
    } else {
        return @"";
    }
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
