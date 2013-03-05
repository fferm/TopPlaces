//
//  AnimationHelper.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-02-21.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "Animator.h"

@interface Animator()
@property (nonatomic, strong) UIViewController *vc;
@property (nonatomic, strong) UIActivityIndicatorView* spinner;
@property (nonatomic, strong) UIBarButtonItem *spinnerItem;
@end

@implementation Animator
@synthesize vc = _vc;
@synthesize spinner = _spinner;
@synthesize spinnerItem = _spinnerItem;

+(Animator *)createForViewController:(UIViewController *)vc {
    Animator *ret = [[Animator alloc] init];
    ret.vc = vc;
    
    return ret;
}

-(UIActivityIndicatorView *)spinner {
    if (!_spinner) {
        _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _spinner;
}

-(UIBarButtonItem *)spinnerItem {
    if (!_spinnerItem) {
        _spinnerItem = [[UIBarButtonItem alloc] initWithCustomView:self.spinner];
    }
    return _spinnerItem;
}

-(void)startAnimation {
    [self.spinner startAnimating];
    
    NSMutableArray *mutItems = [self.vc.navigationItem.rightBarButtonItems mutableCopy];
    if (!mutItems) mutItems = [NSMutableArray array];
    [mutItems insertObject:self.spinnerItem atIndex:0];
    self.vc.navigationItem.rightBarButtonItems = [mutItems copy];
}

-(void)hideAnimation {
    [self.spinner stopAnimating];

    NSMutableArray *mutItems = [self.vc.navigationItem.rightBarButtonItems mutableCopy];
    if (!mutItems) mutItems = [NSMutableArray array];
    [mutItems removeObject:self.spinnerItem];
    self.vc.navigationItem.rightBarButtonItems = [mutItems copy];
}

@end
