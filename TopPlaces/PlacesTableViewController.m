//
//  PlacesTableViewController.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-01-27.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "PlacesTableViewController.h"
#import "PhotosTableViewController.h"
#import "Place.h"

@interface PlacesTableViewController ()
@property (nonatomic, strong)NSArray *places;
@end

@implementation PlacesTableViewController
@synthesize places = _places;

-(NSArray *)places {
    if (!_places) {
        _places  = [Place sortedPlaces];
    }
    return _places;
}

#pragma mark - TopPlacesTableViewControllerDelegate

-(NSString *)titleFor:(id)selectedObject {
    Place *place = (Place *)selectedObject;
    return place.title;
}

-(NSString *)descriptionFor:(id)selectedObject {
    Place *place = (Place *)selectedObject;
    return place.subtitle;
}

-(NSString *)cellIdentifier {
    return @"PlaceCell";
}

-(id)selectedObjectAt:(NSIndexPath *)indexPath {
    return [self.places objectAtIndex:indexPath.row];
}

-(NSInteger)count {
    return [self.places count];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PhotosSegue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Place *place = [self.places objectAtIndex:indexPath.row];
        
        PhotosTableViewController *destination = segue.destinationViewController;
        destination.place = place;
    }
}


@end
