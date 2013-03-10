//
//  RecentPhotosViewController.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-01-29.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "RecentPhotosViewController.h"
#import "RecentPhotosModel.h"

@interface RecentPhotosViewController ()

@end

@implementation RecentPhotosViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
}

-(void)initDataSource {
    RecentPhotosModel *model = [[RecentPhotosModel alloc] init];
    self.dataSource = model;
    model.eventTarget = self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (IBAction)clearPressed:(UIBarButtonItem *)sender {
    RecentPhotosModel *model = self.dataSource;
    [model clear];
}

-(NSArray *)annotations {
    return [self.dataSource allObjects];
}


@end
