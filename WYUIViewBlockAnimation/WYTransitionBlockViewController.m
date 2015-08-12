//
//  WYTransitionBlockViewController.m
//  WYUIViewBlockAnimation
//
//  Created by 武蕴 on 15/8/12.
//  Copyright (c) 2015年 WymanY. All rights reserved.
//

#import "WYTransitionBlockViewController.h"
#import "UIView+Extension.h"

@interface WYTransitionBlockViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong) UIView *greenView;
@property (nonatomic,strong) UIView *redView;
@property (nonatomic,strong) UIView *contanerView;
@property (nonatomic,assign) UIViewAnimationOptions currenOption;
@property (nonatomic,strong) NSArray *tranitionOptionArray;
@property (nonatomic,strong) UIPickerView *pickView;
@end

@implementation WYTransitionBlockViewController

- (NSArray *)tranitionOptionArray
{
    if (_tranitionOptionArray == nil) {
        _tranitionOptionArray = @[@"UIViewAnimationOptionTransitionNone",
                                  @"UIViewAnimationOptionTransitionFlipFromLeft",
                                  @"UIViewAnimationOptionTransitionFlipFromRight",
                                  @"UIViewAnimationOptionTransitionCurlUp",
                                  @"UIViewAnimationOptionTransitionCurlDown",
                                  @"UIViewAnimationOptionTransitionCrossDissolve",
                                  @"UIViewAnimationOptionTransitionFlipFromTop",
                                  @"UIViewAnimationOptionTransitionFlipFromBottom",
                                  ];
    }
    return _tranitionOptionArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *contanerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    contanerView.centerX = self.view.width * 0.5;
    contanerView.centerY = 200;
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
    
    
      UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"options" style:UIBarButtonItemStylePlain target:self action:@selector(switchTransitionOptions)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _currenOption = UIViewAnimationOptionTransitionCurlUp;
    
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
                      duration:0.5
                       options:_currenOption
                    animations:^{
                        [frontView removeFromSuperview];
                        [_contanerView addSubview:backView]; }
                    completion:^(BOOL finished) {
                        
                    }];
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
    return self.tranitionOptionArray.count;
}

#pragma mark -UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = self.tranitionOptionArray[row];
    NSRange range = [title rangeOfString:@"UIViewAnimationOptionTransition"];
    NSUInteger index = range.location+ range.length;
    return [title substringFromIndex:index];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *str = self.tranitionOptionArray[row];
    _currenOption = (UIViewAnimationOptions)[str integerValue];
    _currenOption = row << 20, // default
    [UIView animateWithDuration:0.5 animations:^{
        self.pickView.hidden = YES;
    }];

    
}



@end
