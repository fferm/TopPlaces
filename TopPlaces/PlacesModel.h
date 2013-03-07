//
//  PlacesModel.h
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-03-07.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TopPlacesTableViewController.h"

@protocol PlacesModelEventTarget <NSObject>
-(void)willDownload;
-(void)didDownload;
-(void)needsReload;
@end

@interface PlacesModel : NSObject<TopPlacesTableDataSource>
@property (nonatomic, weak) id<PlacesModelEventTarget> eventTarget;
@end
