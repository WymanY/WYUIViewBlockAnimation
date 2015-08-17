//
//  WYCIFilterTransitonViewController.m
//  WYUIViewBlockAnimation
//
//  Created by 武蕴 on 15/8/12.
//  Copyright (c) 2015年 WymanY. All rights reserved.
//

#import "WYCIFilterTransitonViewController.h"
#import "TransitionImageView.h"
#import "UIView+BlockGesture.h"

@interface WYCIFilterTransitonViewController ()
{
    NSString *currentImageName;
}
@property (nonatomic,strong) TransitionImageView *imageView;
@end

@implementation WYCIFilterTransitonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TransitionImageView *imageView = [[TransitionImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    imageView.image = [UIImage imageNamed:@"Photo1.jpg"];
    imageView.width = 300;
    imageView.height = 400;
    imageView.y = 100;
    imageView.centerX = self.view.width * 0.5;
    [self.view addSubview:imageView];
    self.imageView = imageView;
    __weak typeof(imageView) weakImageView = imageView;
    
    [imageView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
        currentImageName = ([currentImageName  isEqualToString:@"Photo2.jpg"]) ? @"Photo1.jpg" : @"Photo2.jpg";
        [weakImageView transitionToImage:[UIImage imageNamed:currentImageName]];
    }];
}


@end
