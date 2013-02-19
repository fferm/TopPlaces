//
//  TopPlacesTableViewController.h
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-02-12.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopPlacesTableViewControllerDelegate <NSObject>

-(NSString *)cellTitleFor:(id)selectedObject;
-(NSString *)cellDescriptionFor:(id)selectedObject;
-(id)selectedObjectAt:(NSIndexPath *)indexPath;
-(NSString *)cellIdentifier;
-(NSInteger)countForSection:(NSInteger)section;

@end

@interface TopPlacesTableViewController : UITableViewController<TopPlacesTableViewControllerDelegate>

@end
