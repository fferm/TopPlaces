//
//  ImageViewController.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-02-04.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "ImageViewController.h"
#import "Photo.h"
#import "AnimationHelper.h"

@interface ImageViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) AnimationHelper *animationHelper;
@end

@implementation ImageViewController
@synthesize photo = _photo;
@synthesize scrollView = _scrollView;
@synthesize imageView = _imageView;
@synthesize animationHelper = _animationHelper;

- (void)setUpImage {
    // Configure scrollView
    self.scrollView.delegate = self;
    self.scrollView.zoomScale = 1.0;
    self.scrollView.minimumZoomScale = 0.1;
    self.scrollView.maximumZoomScale = 10.0;
    
    [self.animationHelper startAnimationOn:self];
    
    dispatch_queue_t downloadQueue = dispatch_queue_create("image downloader", NULL);
    dispatch_async(downloadQueue, ^{
        UIImage *image = self.photo.image;

        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView = [[UIImageView alloc] initWithImage:image];
            [self.scrollView addSubview:self.imageView];
            
            // Configure sizes
            self.scrollView.contentSize = self.imageView.image.size;
            CGRect zoomRect = CGRectMake(0.0,
                                         0.0,
                                         self.scrollView.contentSize.width,
                                         self.scrollView.contentSize.height);
            [self.scrollView zoomToRect:zoomRect animated:NO];
            [self.animationHelper stopAnimation];
        });
    });
}

-(AnimationHelper *)animationHelper {
    if (!_animationHelper) {
        _animationHelper = [[AnimationHelper alloc] init];
    }
    return _animationHelper;
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
