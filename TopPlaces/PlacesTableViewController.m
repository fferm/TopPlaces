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
    if ([segue.identifier isEqualToString:@"PhotosSegue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Place *place = [self selectedObjectAt:indexPath];
        
        PhotosTableViewController *destination = segue.destinationViewController;
        destination.place = place;
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
