//
//  TopPlacesTableViewController.h
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-02-12.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimationHelper.h"

@protocol TopPlacesTableViewControllerDelegate <NSObject>

-(NSString *)cellTitleFor:(id)selectedObject;
-(NSString *)cellDescriptionFor:(id)selectedObject;
-(id)selectedObjectAt:(NSIndexPath *)indexPath;
-(NSString *)cellIdentifier;
-(NSInteger)countForSection:(NSInteger)section;

-(NSInteger)countOfSections;
-(NSString *)sectionHeaderTitle:(NSInteger)section;

@end

@interface TopPlacesTableViewController : UITableViewController<TopPlacesTableViewControllerDelegate>
@property (nonatomic, strong) AnimationHelper *animationHelper;
@end
