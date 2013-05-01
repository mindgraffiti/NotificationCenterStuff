//
//  ScrollViewController.m
//  NotificationCenterStuff
//
//  Created by Thuy Copeland on 4/30/13.
//  Copyright (c) 2013 Thuy Copeland. All rights reserved.
//

#import "ScrollViewController.h"

@interface ScrollViewController ()
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation ScrollViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // loading a basic image into the nib
    UIImage *image = [UIImage imageNamed:@"scooby-doo.jpg"];
    self.imageView = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:self.imageView];
    
    // if you are limiting the size of your scrollView (not going full screen), do this:
    // 1. measure the size of the image 
    CGSize size = self.imageView.frame.size;
    // 2. set the content size based on the image
    self.scrollView.contentSize = size;
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}


@end
