//
//  ImageViewController.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-02-04.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation ImageViewController
@synthesize scrollView = _scrollView;
@synthesize imageView = _imageView;

-(void)viewDidLoad {
    [super viewDidLoad];

    // Hook up things
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = 0.1;
    self.scrollView.maximumZoomScale = 10.0;
    
    // Add image
    NSData *data = [NSData dataWithContentsOfURL:self.imageUrl];
    UIImage *image = [UIImage imageWithData:data];
    
    self.imageView = [[UIImageView alloc] initWithImage:image];
    [self.scrollView addSubview:self.imageView];
    
    // Configure with image
    self.scrollView.contentSize = self.imageView.bounds.size;
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}


@end
