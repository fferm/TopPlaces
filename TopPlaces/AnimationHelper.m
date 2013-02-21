//
//  AnimationHelper.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-02-21.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "AnimationHelper.h"

@interface AnimationHelper()
@property UIActivityIndicatorView *spinner;

@end

@implementation AnimationHelper
@synthesize spinner = _spinner;

-(void)startAnimationOn:(UIViewController *)viewController {
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:  UIActivityIndicatorViewStyleGray];
    self.spinner.hidesWhenStopped = YES;
    [self.spinner startAnimating];
    
    viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.spinner];
}

-(void)stopAnimation {
    [self.spinner stopAnimating];
}
@end
