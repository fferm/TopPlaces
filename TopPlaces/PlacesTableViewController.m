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
#import "PhotosModel.h"

@interface PlacesTableViewController ()
@end

@implementation PlacesTableViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
}

-(void)initDataSource {
    PlacesModel *model = [[PlacesModel alloc] init];
    self.dataSource = model;
    model.eventTarget = self;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Place *place = [self.dataSource selectedObjectAt:indexPath];
        
        PhotosTableViewController *destination = segue.destinationViewController;
        
        destination.dataSource = [PhotosModel modelForPlace:place];
        destination.title = [NSString stringWithFormat:@"Photos at %@", place.title];
    }
}

#pragma mark - MapViewControllerDelegate
-(NSArray *)annotations {
    return [self.dataSource allObjects];
}

-(UIImage *)calloutImageForAnnotation:(id<MKAnnotation>)annotation {
    return nil;
}

-(NSString *)storyboardIdOfCalloutController{
    return @"photosViewController";
}

-(NSString *)propertyNameToSetModelInNextController{
    return @"place";
}

@end
