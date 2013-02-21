//
//  PhotosTableViewController.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-01-31.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "PhotosTableViewController.h"

@interface PhotosTableViewController ()
@property (nonatomic, strong) NSArray *photos;
@end

@implementation PhotosTableViewController
@synthesize place = _place;
@synthesize photos = _photos;

-(NSArray *)photos {
    if (!_photos) {
        
        [self.animationHelper startAnimationOn:self];
        
        dispatch_queue_t downloadQueue = dispatch_queue_create("photos downloader", NULL);
        dispatch_async(downloadQueue, ^{
            NSArray *photos = [self.place getPhotos];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.photos = photos;
                [self.animationHelper stopAnimation];
            });
        });
    }
    return _photos;
}

-(void)setPhotos:(NSArray *)photos {
    _photos = photos;
    [self.tableView reloadData];
}

-(void)setPlace:(Place *)place {
    _place = place;
    self.title = [NSString stringWithFormat:@"Photos at %@", place.title , nil];
}

#pragma mark - TopPlacesTableViewControllerDelegate

-(NSString *)cellIdentifier {
    return @"PhotoCell";
}

-(id)selectedObjectAt:(NSIndexPath *)indexPath {
    return [self.photos objectAtIndex:indexPath.row];
}

-(NSInteger)countForSection:(NSInteger)section {
    return [self.photos count];
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
