//
//  EasingAnimationVC.m
//  AnimationDemo
//
//  Created by Vivien on 15/11/4.
//  Copyright © 2015年 vivien. All rights reserved.
//

#import "EasingAnimationVC.h"
#import "YXEasing.h"


@interface EasingAnimationVC()
{
    UIImageView *imageview;
}

@end
@implementation EasingAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    imageview = [[UIImageView alloc] initWithFrame:CGRectMake(100, 0, 60 , 60)];
    imageview.image        = [UIImage imageNamed:@"ball.png"];
    imageview.contentMode  = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageview];
    
    
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animation];
    keyFrameAnimation.keyPath = @"position";
    keyFrameAnimation.duration = 2.0f;
    keyFrameAnimation.values =    [YXEasing calculateFrameFromPoint:imageview.center
                                                            toPoint:CGPointMake(100+30, 320 / 2.f + 240)
                                                               func: BounceEaseInOut //CubicEaseOut  //  BounceEaseOut
                                                         frameCount:30*2];  //frameCount的意思为：生成多少帧
    
    // 添加动画
    imageview.center = CGPointMake(100+30, 320 / 2.f + 240);// CGPointMake(320 / 2.f, 320 / 2.f + 240);
    [imageview.layer addAnimation:keyFrameAnimation forKey:nil];
    
    
    // 创建定时器
//    [NSTimer scheduledTimerWithTimeInterval:1.f
//                                                  target:self
//                                                selector:@selector(timerEvent)
//                                                userInfo:nil
//                                                 repeats:YES];
    
}

-(void)timerEvent{
    
        CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animation];
        keyFrameAnimation.keyPath = @"position";
        keyFrameAnimation.duration = 3.0f;
        keyFrameAnimation.values =    [YXEasing calculateFrameFromPoint:imageview.center
                                                                toPoint:CGPointMake(100+30, 320 / 2.f + 240)
                                                                   func:ElasticEaseOut  //easeOutElastic  BounceEaseOut //ElasticEaseOut  //CubicEaseIn
                                                             frameCount:30*2];  //frameCount的意思为：生成多少帧
    
        [imageview.layer addAnimation:keyFrameAnimation forKey:nil];

}


@end
