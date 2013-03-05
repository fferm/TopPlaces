//
//  AnimationHelper.h
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-02-21.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Animator : NSObject

+(Animator *)createForViewController:(UIViewController *)vc;

-(void)startAnimation;
-(void)hideAnimation;

@end
