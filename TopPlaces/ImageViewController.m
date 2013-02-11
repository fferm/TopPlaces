//
//  ImageViewController.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-02-04.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "ImageViewController.h"
#import "Photo.h"

@interface ImageViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation ImageViewController
@synthesize photo = _photo;
@synthesize scrollView = _scrollView;
@synthesize imageView = _imageView;

- (void)setUpImage {
    // Configure scrollView
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = 0.1;
    self.scrollView.maximumZoomScale = 10.0;
    
    self.imageView = [[UIImageView alloc] initWithImage:self.photo.image];
    [self.scrollView addSubview:self.imageView];
    
    // Configure sizes
    self.scrollView.contentSize = self.imageView.image.size;
    CGRect zoomRect = CGRectMake(0.0,
                                 0.0,
                                 self.scrollView.contentSize.width,
                                 self.scrollView.contentSize.height);
    [self.scrollView zoomToRect:zoomRect animated:NO];
}

-(void)setUpNavigationBar {
    self.title = self.photo.title;;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [self setUpImage];
    [self setUpNavigationBar];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}


@end
