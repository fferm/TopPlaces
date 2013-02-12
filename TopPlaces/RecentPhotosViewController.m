//
//  RecentPhotosViewController.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-01-29.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "RecentPhotosViewController.h"
#import "Photo.h"
#import "UserDefaultsManager.h"
#import "ImageViewController.h"

@interface RecentPhotosViewController ()

@end

@implementation RecentPhotosViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

-(Photo *)photoAtIndexPath:(NSIndexPath *)indexPath {
    return [UserDefaultsManager photoAtIndex:indexPath.row];
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

- (IBAction)clearPressed:(UIBarButtonItem *)sender {
    [UserDefaultsManager clear];
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [UserDefaultsManager count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RecentPhoto";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Photo *photo = [UserDefaultsManager photoAtIndex:indexPath.row];
    cell.textLabel.text = photo.title;
    cell.detailTextLabel.text = photo.subtitle;
    
    return cell;
}

@end
