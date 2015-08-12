//
//  WYTransitionLayerViewController.m
//  WYUIViewBlockAnimation
//
//  Created by 武蕴 on 15/8/12.
//  Copyright (c) 2015年 WymanY. All rights reserved.
//

#import "WYTransitionLayerViewController.h"
#import <CoreImage/CoreImage.h>

@interface WYTransitionLayerViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong) UIView *greenView;
@property (nonatomic,strong) UIView *redView;
@property (nonatomic,copy) NSString *currentType;
@property (nonatomic,strong) NSArray *tranitionTypeArray;
@property (nonatomic,strong) UIPickerView *pickView;
@end

@implementation WYTransitionLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    
//    UIView *contanerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    [self.view addSubview:contanerView];
//    self.contanerView = contanerView;
    
    UIView *greenView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    greenView.backgroundColor = [UIColor greenColor];
    self.greenView = greenView;
    
    greenView.centerX = self.view.width * 0.5;
    greenView.centerY = 200;

    [self.view addSubview:greenView];
    
    UIView *redView = [[UIView alloc] initWithFrame:greenView.frame];
    redView.backgroundColor = [UIColor redColor];
    self.redView = redView;
    [self configureButton];
    
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"options" style:UIBarButtonItemStylePlain target:self action:@selector(switchTransitionOptions)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _currentType = @"cube";
    
    
}
/*除了系统的默认的 type 外其它为 私有 api，审核部过
 * The name of the transition. Current legal transition types include
 * fade', `moveIn', `push' and `reveal'. Defaults to `fade'.
 */
- (NSArray *)tranitionTypeArray
{
    if (_tranitionTypeArray == nil) {
        _tranitionTypeArray = @[@"cameraIris",
                                @"cameraIrisHollowOpen",
                                @"cameraIrisHollowClose",
                                @"cube",
                                @"alignedCube",
                                @"fade",
                                @"moveIn",
                                @"oglFlip",
                                @"pageCurl",
                                @"pageUnCurl",
                                @"push",
                                @"reveal",
                                @"rippleEffect",//这个尼玛不知道为什么不起作用了
                                @"suckEffect",
                                @"rotate"
                                  ];
    }
    return _tranitionTypeArray;
}


- (void)switchTransitionOptions
{
    if (_pickView == nil) {
        UIPickerView *pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 216)];
        pickView.centerX  = self.view.width * 0.5;
        pickView.y = self.view.height - pickView.height;
        [self.view addSubview:pickView];
        self.pickView = pickView;
        pickView.dataSource = self;
        pickView.delegate = self;
    }
    self.pickView.hidden = NO;
    
    
    
    
}
#pragma mark -UIPickViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.tranitionTypeArray.count;
}

#pragma mark -UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = self.tranitionTypeArray[row];
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.currentType = self.tranitionTypeArray[row];
    [UIView animateWithDuration:0.4 animations:^{
        self.pickView.hidden = YES;
    }];
    
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

/*
  在使用CATransition时，它的type有“rippleEffect”、“ suckEffect”等值，他们是私有API,一般审核不会过
 
 */
- (void)animationBegin:(id)sender {
    
    UIView *frontView = [self getSepciedView:YES];
    
    
    CATransition *transition = [CATransition animation];
    transition.type = _currentType;
    transition.startProgress = 0;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    /*subtype 是指动画的方向，the legal values are `fromLeft', `fromRight', `fromTop' and
     * `fromBottom'. */
    transition.subtype = @"fromLeft";
    transition.duration = 2.0;
    transition.delegate  = self;
    [frontView.layer addAnimation:transition forKey:@"transition"];

    
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    /*这个待优化，应该让后面的 view 跟着前面的 view 的最后的变化。*/
    if (flag) {
        UIView *frontView = [self getSepciedView:YES];
        UIView *backView = [self getSepciedView:NO];
        [self.view insertSubview:backView aboveSubview:frontView];
        
        [frontView removeFromSuperview];
    }
}
- (UIView *)getSepciedView:(BOOL)isFront
{
    UIView *frontView = nil;
    UIView *backView = nil;
    
    if ([_greenView isDescendantOfView:self.view]) {
        frontView =  _greenView;
        backView =  _redView;
    }
    else
    {
        frontView =  _redView;
        backView =  _greenView;
    }
    if (isFront) {
        return frontView;
    }
    else
    {
        return backView;
    }
}


@end
