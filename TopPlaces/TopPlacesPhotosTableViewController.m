//
//  TopPlacesPhotosTableViewController.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-02-14.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "TopPlacesPhotosTableViewController.h"
#import "ImageViewController.h"

@interface TopPlacesPhotosTableViewController()
@end

@implementation TopPlacesPhotosTableViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segue"]) {
        ImageViewController *vc = segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Photo *photo = (Photo *)[self.dataSource selectedObjectAt:indexPath];
        vc.photo = photo;
    }
}

-(UIImage *)calloutImageForAnnotation:(id<MKAnnotation>)annotation {
    Photo *photo = annotation;
    return photo.calloutImage;
}

#pragma mark - MapViewControllerDelegate
-(NSArray *)annotations{
    return [self.dataSource allObjects];
}
-(NSString *)storyboardIdOfCalloutController {
    return @"imageViewController";
}

-(NSString *)propertyNameToSetModelInNextController {
    return @"photo";
}



@end
