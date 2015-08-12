//
//  TransitionImageView.m
//  CITransitionOc
//
//  Created by 武蕴 on 15/8/3.
//  Copyright (c) 2015年 WymanY. All rights reserved.
//

#import "TransitionImageView.h"

@interface TransitionImageView ()
@end
/*性能特特别差特别耗 Cpu 需要转换成 GPU 作图*/
@implementation TransitionImageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _duration = 2.0;
        _filter = [CIFilter filterWithName:@"CICopyMachineTransition"];
        _transitionStartTime = 0.0;
        
    }
    return self;
}

- (void)awakeFromNib
{
    _duration = 3.0;
    _filter = [CIFilter filterWithName:@"CICopyMachineTransition"];
    _transitionStartTime = 0.0;
}

- (void)transitionToImage:(UIImage *)toImage
{
    if (_transitionTimer.valid) {
        [_transitionTimer invalidate];
        self.image = [UIImage imageNamed:@"Photo1.jpg"];
    }
    //Check the origin and target image
    if (nil == toImage || nil == self.image) {
        NSAssert(nil != self.image,@"原图为空");
    }
    
    //Set Extent And Color
    CIVector *extent = [CIVector vectorWithX:0.0 Y:0.0 Z:self.image.size.width * 2 W:self.image.size.height * 2 ];
    CGFloat randmomR = arc4random() % 255;
    CGFloat randmomG = arc4random() % 255;
    CGFloat randmomB = arc4random() % 255;
    
    
    CIColor *color = [CIColor colorWithRed:randmomR / 255.0 green:randmomG/255.0 blue:randmomB/255.0];
    [_filter setValue:extent forKey:kCIInputExtentKey];
    [_filter setValue:color forKey:kCIInputColorKey];
    //SetFilter Parameters
    CIImage *inputImage = [CIImage imageWithCGImage:self.image.CGImage];
    [_filter setValue:inputImage forKey:kCIInputImageKey];
    
    CIImage *inputTargetImage = [CIImage imageWithCGImage:toImage.CGImage];
    [_filter setValue:inputTargetImage forKey:kCIInputTargetImageKey];
    

    //If a transitionTimer already exisit invalidate it when transition in progress
   
    _transitionStartTime = CACurrentMediaTime();
    
    self.transitionTimer = [NSTimer timerWithTimeInterval:1.0/30 target:self selector:@selector(timerFired:) userInfo:toImage repeats:YES];
    [_transitionTimer fire];
    
    [[NSRunLoop mainRunLoop] addTimer:self.transitionTimer forMode:NSDefaultRunLoopMode];
    
}

- (void)timerFired:(NSTimer *)timer
{
    CGFloat time = CACurrentMediaTime();
    
    if (time > _transitionStartTime + _duration) {
        self.image = (UIImage *)timer.userInfo;
        [_transitionTimer invalidate];
    }
    else
    {
        double progress = (time - _transitionStartTime )/_duration;
        [_filter setValue:@(progress) forKey:kCIInputTimeKey];
        CIImage *outPutImage = _filter.outputImage;
        UIImage *image = [UIImage imageWithCIImage:outPutImage];
        self.image = image;
    }
    
}


@end
