//
//  ViewController.m
//  WYUIViewBlockAnimation
//
//  Created by 武蕴 on 15/8/11.
//  Copyright (c) 2015年 WymanY. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Extension.h"

@interface ViewController ()
@property (nonatomic,strong) UIView *blackView;
@property (nonatomic,strong) UIView *greenView;
@property (nonatomic,strong) UIView *redView;
@property (nonatomic,strong) UIView *contanerView;
@property (nonatomic,assign) CGRect originFrame;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *blakView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    blakView.backgroundColor = [UIColor blackColor];
    self.blackView = blakView;
    [self.view addSubview:blakView];
    
    self.originFrame = self.blackView.frame;
    
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
    
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)animationBegin:(id)sender {
    
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




/*注意在 oc 中 1/3 和 1/ 3.0是不一样的，1/3 为0， 1/3.0 为0.33333*/
/*RelativeStartTime 动画开始时间为总持续时间的百分比   譬如下面动画总时间20，RelativeStartTime = 1/ 3.0，就是在
  20 / 3.0 第6.6 秒开始的*/
/*relativeDuration 动画占总持续时间的百分比  譬如下面动画总时间20，relativeDuration = 1/ 4.0，就是这一段动画的
 持续时间为 20 /4.0，为5s */
- (void)KeyFrameBlockViewAmimation
{
    [UIView animateKeyframesWithDuration:5.0 delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        //
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:1/4.0 animations:^{
            self.blackView.width+= 200;
        }];
        [UIView addKeyframeWithRelativeStartTime:1/3.0 relativeDuration:3/8.0 animations:^{
            self.blackView.x+= 100;
        }];
        [UIView addKeyframeWithRelativeStartTime:2/3.0 relativeDuration:3/8.0
                                      animations:^{
            self.blackView.transform = CGAffineTransformMakeRotation(0.5);
        }];
        
    } completion:nil];
}
- (IBAction)reset:(id)sender {
    self.blackView.transform = CGAffineTransformIdentity;
    self.blackView.frame = _originFrame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
