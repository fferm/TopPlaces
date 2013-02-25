//
//  PlacesTableViewController.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-01-27.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "PlacesTableViewController.h"
#import "PhotosTableViewController.h"
#import "MapViewController.h"
#import "Place.h"

@interface PlacesTableViewController ()
@property (nonatomic, strong)NSArray *sortedCountries;
@property (nonatomic, strong)NSDictionary *placesByCountry; //Holds an NSArray* with places for a specific country.  Key is country string
@property (nonatomic, strong)NSArray *nonSortedPlaces;
@end

@implementation PlacesTableViewController
@synthesize sortedCountries = _sortedCountries;
@synthesize placesByCountry = _placesByCountry;
@synthesize nonSortedPlaces = _nonSortedPlaces;

-(NSArray *)nonSortedPlaces {
    if (!_nonSortedPlaces) {
        
        [self.animationHelper startAnimationOn:self];
        
        dispatch_queue_t downloadQueue = dispatch_queue_create("places downloader", NULL);
        dispatch_async(downloadQueue, ^{
            NSArray *topPlaces = [Place topPlaces];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.nonSortedPlaces = topPlaces;
                [self.animationHelper stopAnimation];
            });
        });
    }
    return _nonSortedPlaces;
}

-(void)setNonSortedPlaces:(NSArray *)nonSortedPlaces {
    _nonSortedPlaces = nonSortedPlaces;
    _sortedCountries = nil;
    _placesByCountry = nil;
    [self.tableView reloadData];
}

-(NSArray *)sortedCountries {
    if (!_sortedCountries) {
        NSMutableSet *set = [NSMutableSet set];
    
        for (Place *place in self.nonSortedPlaces) {
            [set addObject:place.country];
        }
        
        _sortedCountries = [set allObjects];
        _sortedCountries = [_sortedCountries sortedArrayUsingComparator: ^(id obj1, id obj2) {
            NSString *s1 = (NSString *)obj1;
            NSString *s2 = (NSString *)obj2;
            return [s1 compare:s2];
        }];
    }
    return _sortedCountries;
}

-(NSDictionary *)placesByCountry {
    if (!_placesByCountry) {
        // Fill a mutable copy of the dictionary
        NSMutableDictionary *mutDict = [NSMutableDictionary dictionary];
        for (Place *place in self.nonSortedPlaces) {
            NSMutableArray *mutArray = [mutDict objectForKey:place.country];
            if (!mutArray) {
                mutArray = [NSMutableArray array];
                [mutDict setObject:mutArray forKey:place.country];
            }
            
            [mutArray addObject:place];
        }
        
        // In each country, sort places by title
        for (NSString *country in [mutDict allKeys]) {
            NSMutableArray *mutArray = [mutDict objectForKey:country];
            
            NSArray *placeArray = [mutArray sortedArrayUsingComparator:[Place comparator]];
            
            [mutDict removeObjectForKey:country];
            [mutDict setObject:placeArray forKey:country];
        }

        // Make non-mutable
        _placesByCountry = [mutDict copy];
        
    }
    return _placesByCountry;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PhotosSegue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Place *place = [self selectedObjectAt:indexPath];
        
        PhotosTableViewController *destination = segue.destinationViewController;
        destination.place = place;
    }
}

-(NSArray *)annotations {
    return [self.nonSortedPlaces copy];
}

#pragma mark - TopPlacesTableViewControllerDelegate

-(NSString *)cellTitleFor:(id)selectedObject {
    Place *place = (Place *)selectedObject;
    return place.title;
}

-(NSString *)cellDescriptionFor:(id)selectedObject {
    Place *place = (Place *)selectedObject;
    return place.subtitle;
}

-(NSString *)cellIdentifier {
    return @"PlaceCell";
}

-(id)selectedObjectAt:(NSIndexPath *)indexPath {
    NSString *country = [self.sortedCountries objectAtIndex:indexPath.section];
    NSArray *placesInCountry = [self.placesByCountry objectForKey:country];
    return [placesInCountry objectAtIndex:indexPath.row];
}

-(NSInteger)countForSection:(NSInteger)section {
    NSString *country = [self.sortedCountries objectAtIndex:section];
    NSArray *placesInCountry = [self.placesByCountry objectForKey:country];
    return placesInCountry.count;
}

-(NSInteger)countOfSections {
    return self.sortedCountries.count;
}

-(NSString *)sectionHeaderTitle:(NSInteger)section {
    return [self.sortedCountries objectAtIndex:section];
}


@end
