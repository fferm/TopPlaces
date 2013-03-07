//
//  ModelEventTarget.h
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-03-08.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ModelEventTarget <NSObject>
-(void)willDownload;
-(void)didDownload;
-(void)needsReload;
@end
