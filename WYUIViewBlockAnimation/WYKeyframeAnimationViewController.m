//
//  ViewController.m
//  WYUIViewBlockAnimation
//
//  Created by 武蕴 on 15/8/11.
//  Copyright (c) 2015年 WymanY. All rights reserved.
//

#import "WYKeyframeAnimationViewController.h"
#import "UIView+Extension.h"

@interface WYKeyframeAnimationViewController ()
@property (nonatomic,strong) UIView *blackView;
@property (nonatomic,assign) CGRect originFrame;
@end

@implementation WYKeyframeAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *blakView = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    blakView.backgroundColor = [UIColor blackColor];
    self.blackView = blakView;
    [self.view addSubview:blakView];
    
    self.originFrame = self.blackView.frame;
    
    [self configureButtons];
}
- (void)configureButtons
{
    UIButton *animateBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 100, 22)];
    animateBtn.centerX = self.view.width * 0.5;
    animateBtn.centerY = self.view.height - 60;
    [animateBtn setTitle:@"animate" forState:UIControlStateNormal];
    [animateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [animateBtn addTarget:self action:@selector(animationBegin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:animateBtn];
    
    UIButton *resetBtn = [[UIButton alloc] initWithFrame:animateBtn.frame];
    resetBtn.y = animateBtn.y + animateBtn.height + 10 ;
    [resetBtn setTitle:@"reset" forState:UIControlStateNormal];
    [resetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [resetBtn addTarget:self action:@selector(reset:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetBtn];
    
    
}
- (void)animationBegin:(id)sender {
    
    [self KeyFrameBlockViewAmimation];
    
}


/*注意在 oc 中 1/3 和 1/ 3.0是不一样的，1/3 为0， 1/3.0 为0.33333*/
/*RelativeStartTime 动画开始时间为总持续时间的百分比   譬如下面动画总时间20，RelativeStartTime = 1/ 3.0，就是在
  20 / 3.0 第6.6 秒开始的*/
/*relativeDuration 动画占总持续时间的百分比  譬如下面动画总时间20，relativeDuration = 1/ 4.0，就是这一段动画的
 持续时间为 20 /4.0，为5s */
- (void)KeyFrameBlockViewAmimation
{
    //防止反复点击
    [self cacellCurrentAnimation];
    
    [UIView animateKeyframesWithDuration:5.0 delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        //
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:1/4.0 animations:^{
            self.blackView.width+= 50;
        }];
        [UIView addKeyframeWithRelativeStartTime:1/3.0 relativeDuration:3/8.0 animations:^{
            self.blackView.x+= 100;
        }];
        [UIView addKeyframeWithRelativeStartTime:2/3.0 relativeDuration:1/3.0
                                      animations:^{
            self.blackView.transform = CGAffineTransformMakeRotation(1);
        }];
        
    } completion:nil];
}
- (void)reset:(id)sender {
    [self cacellCurrentAnimation];

}

- (void)cacellCurrentAnimation
{
    [UIView animateWithDuration:0.0
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.blackView.transform = CGAffineTransformIdentity;
                         self.blackView.frame = _originFrame;}
                     completion:^(BOOL finished){}
     ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
