//
//  TopPlacesTableViewController.h
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-02-12.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"
#import "Animator.h"
#import "ModelEventTarget.h"
#import "Entity.h"

@protocol TopPlacesTableDataSource <NSObject>
@optional
-(Entity *)selectedObjectAt:(NSIndexPath *)indexPath;
-(NSArray *)allObjects;

-(NSInteger)count;
-(NSInteger)countForSection:(NSInteger)section;

-(NSInteger)countOfSections;
-(NSString *)sectionHeaderTitle:(NSInteger)section;
@end

@interface TopPlacesTableViewController : UITableViewController<MapViewControllerDelegate, ModelEventTarget>
@property (nonatomic, strong) id<TopPlacesTableDataSource> dataSource;
@property (nonatomic,strong) Animator* animator;
@end
