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

-(void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
}

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
    return @"RecentPhoto";
}

-(id)selectedObjectAt:(NSIndexPath *)indexPath {
    return [UserDefaultsManager photoAtIndex:indexPath.row];
}

-(NSInteger)count {
    return [UserDefaultsManager count];
}


@end
