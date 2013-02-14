//
//  PhotosTableViewController.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-01-31.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "PhotosTableViewController.h"
#import "ImageViewController.h"
#import "Photo.h"
#import "UserDefaultsManager.h"

@interface PhotosTableViewController ()

@end

@implementation PhotosTableViewController
@synthesize place = _place;

-(Photo *)photoAtIndexPath:(NSIndexPath *)indexPath {
    return [self.place.photos objectAtIndex:indexPath.row];
}

-(void)setPlace:(Place *)place {
    _place = place;
    self.title = [NSString stringWithFormat:@"Photos at %@", place.title , nil];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ImageSegue"]) {
        ImageViewController *vc = segue.destinationViewController;

        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Photo *photo = [self photoAtIndexPath:indexPath];
        vc.photo = photo;
        
        [UserDefaultsManager addPhotoIfNotAlreadyPresent:photo];
    }
}

#pragma mark - TopPlacesTableViewControllerDelegate

-(NSString *)titleFor:(id)selectedObject {
    Photo *photo = (Photo *)selectedObject;
    return photo.title;
}

-(NSString *)descriptionFor:(id)selectedObject {
    Photo *photo = (Photo *)selectedObject;
    return photo.subtitle;
}

-(NSString *)cellIdentifier {
    return @"PhotoCell";
}

-(id)selectedObjectAt:(NSIndexPath *)indexPath {
    return [self photoAtIndexPath:indexPath];
}

-(NSInteger)count {
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
