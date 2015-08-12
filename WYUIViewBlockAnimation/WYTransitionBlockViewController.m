//
//  WYTransitionBlockViewController.m
//  WYUIViewBlockAnimation
//
//  Created by 武蕴 on 15/8/12.
//  Copyright (c) 2015年 WymanY. All rights reserved.
//

#import "WYTransitionBlockViewController.h"
#import "UIView+Extension.h"

@interface WYTransitionBlockViewController ()
@property (nonatomic,strong) UIView *greenView;
@property (nonatomic,strong) UIView *redView;
@property (nonatomic,strong) UIView *contanerView;
@end

@implementation WYTransitionBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIView *contanerView = [[UIView alloc] initWithFrame:CGRectMake(200, 200, 100, 100)];
    [self.view addSubview:contanerView];
    self.contanerView = contanerView;
    
    UIView *greenView = [[UIView alloc] initWithFrame:contanerView.bounds];
    greenView.backgroundColor = [UIColor greenColor];
    self.greenView = greenView;
    [contanerView addSubview:greenView];
    
    UIView *redView = [[UIView alloc] initWithFrame:contanerView.bounds];
    redView.backgroundColor = [UIColor redColor];
    self.redView = redView;
    
    [self configureButton];
    
    
    
    
}
- (void)configureButton
{
    UIButton *animateBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 22)];
    animateBtn.centerX = self.view.width * 0.5;
    animateBtn.centerY = self.view.height - 60;
    [animateBtn setTitle:@"animate" forState:UIControlStateNormal];
    [animateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [animateBtn addTarget:self action:@selector(animationBegin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:animateBtn];
}


- (void)animationBegin:(id)sender {
    
    //    [self KeyFrameBlockViewAmimation];
    [self TransiotonViewBlockAnimation];
    
}

/*Transition View Block*/
- (void)TransiotonViewBlockAnimation
{
    
    UIView *frontView = nil;
    UIView *backView = nil;
    
    if ([_greenView isDescendantOfView:_contanerView]) {
        frontView =  _greenView;
        backView =  _redView;
    }
    else
    {
        frontView =  _redView;
        backView =  _greenView;
    }
    
    [UIView transitionWithView:_contanerView
                      duration:0.2
                       options:UIViewAnimationOptionTransitionCurlDown
                    animations:^{
                        [frontView removeFromSuperview];
                        [_contanerView addSubview:backView]; }
                    completion:^(BOOL finished) {
                        
                    }];
}


@end
