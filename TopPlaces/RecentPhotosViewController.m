//
//  RecentPhotosViewController.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-01-29.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "RecentPhotosViewController.h"
#import "UserDefaultsManager.h"

@interface RecentPhotosViewController ()

@end

@implementation RecentPhotosViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (IBAction)clearPressed:(UIBarButtonItem *)sender {
    [UserDefaultsManager clear];
    [self.tableView reloadData];
}

#pragma mark - TopPlacesTableViewControllerDelegate

-(NSString *)cellIdentifier {
    return @"RecentPhoto";
}

-(id)selectedObjectAt:(NSIndexPath *)indexPath {
    return [UserDefaultsManager photoAtIndex:indexPath.row];
}

-(NSInteger)countForSection:(NSInteger)section {
    return [UserDefaultsManager count];
}


@end
