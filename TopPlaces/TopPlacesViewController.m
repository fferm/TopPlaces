//
//  TopPlacesViewController.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-01-27.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "TopPlacesViewController.h"
#import "FlickrFetcher.h"

@interface TopPlacesViewController ()

@end

@implementation TopPlacesViewController

- (IBAction)fetchButtonClicked:(UIButton *)sender forEvent:(UIEvent *)event {
    NSArray *response = [FlickrFetcher topPlaces];
    for (id item in response) {
        NSLog(@"%@", item);
    }
    
}


@end
