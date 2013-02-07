//
//  PlacesTableViewController.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-01-27.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "PlacesTableViewController.h"
#import "PlacesModel.h"
#import "PhotosTableViewController.h"
#import "Place.h"

@interface PlacesTableViewController ()
@property (nonatomic, strong) PlacesModel *model;
@end

@implementation PlacesTableViewController

@synthesize model = _model;

-(PlacesModel *)model {
    if (!_model) {
        _model = [[PlacesModel alloc] init];
    }
    return _model;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.model count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PlaceCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    Place *place = [self.model placeAtIndex:indexPath.row];
    cell.textLabel.text = place.title;
    cell.detailTextLabel.text = place.subtitle;
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PhotosSegue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Place *place = [self.model placeAtIndex:indexPath.row];
        
        PhotosTableViewController *destination = segue.destinationViewController;
        destination.place = place;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

@end
