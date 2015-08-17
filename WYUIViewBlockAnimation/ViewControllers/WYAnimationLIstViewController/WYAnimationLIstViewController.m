//
//  WYAnimationLIstViewController.m
//  WYUIViewBlockAnimation
//
//  Created by 武蕴 on 15/8/12.
//  Copyright (c) 2015年 WymanY. All rights reserved.
//

#import "WYAnimationLIstViewController.h"
#import "WYKeyframeAnimationViewController.h"
#import "WYTransitionBlockViewController.h"
#import "WYTransitionLayerViewController.h"
#import "WYCIFilterTransitonViewController.h"
static NSString *const kcellIdentifier = @"cellIdentifier";

@interface WYAnimationLIstViewController ()
@property (nonatomic,strong) NSArray *items;

- (NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UIViewController *)viewControllerForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@implementation WYAnimationLIstViewController

- (NSArray *)items
{
    if (_items == nil) {
        _items = @[@[@"关键帧动画",[WYKeyframeAnimationViewController class]],
                   @[@"view block 转场",[WYTransitionBlockViewController class]],
                   @[@"layer 转场",[WYTransitionLayerViewController class]],
                   @[@"使用滤镜转场",[WYCIFilterTransitonViewController class]],
//                   @[@"keyFrame AnimationBlock",@"keyFrameAnimationBlock"],
                   ];
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.items[indexPath.row] firstObject];
}

- (UIViewController *)viewControllerForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.items[indexPath.row] lastObject] new];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kcellIdentifier    forIndexPath:indexPath];
    cell.textLabel.text = [_items[indexPath.row] firstObject];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [self viewControllerForRowAtIndexPath:indexPath];
    vc.title = [self titleForRowAtIndexPath:indexPath];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
