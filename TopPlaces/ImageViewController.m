//
//  ImageViewController.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-02-04.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation ImageViewController
@synthesize scrollView = _scrollView;

-(void)viewDidLoad {
    [super viewDidLoad];

    // Remove old imageView?
    NSData *data = [NSData dataWithContentsOfURL:self.imageUrl];
    UIImage *image = [UIImage imageWithData:data];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self.scrollView addSubview:imageView];
    
    self.scrollView.contentSize = imageView.bounds.size;
}

@end
