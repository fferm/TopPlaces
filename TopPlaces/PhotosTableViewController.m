//
//  PhotosTableViewController.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-01-31.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "PhotosTableViewController.h"

@interface PhotosTableViewController ()

@end

@implementation PhotosTableViewController
@synthesize place = _place;

-(void)setPlace:(Place *)place {
    _place = place;
    self.title = [NSString stringWithFormat:@"Photos at %@", place.title , nil];
}

#pragma mark - TopPlacesTableViewControllerDelegate

-(NSString *)cellIdentifier {
    return @"PhotoCell";
}

-(id)selectedObjectAt:(NSIndexPath *)indexPath {
    return [self.place.photos objectAtIndex:indexPath.row];
}

-(NSInteger)countForSection:(NSInteger)section {
    return [self.place.photos count];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
