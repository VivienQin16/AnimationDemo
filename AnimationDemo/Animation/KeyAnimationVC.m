//
//  KeyAnimationVC.m
//  AnimationDemo
//
//  Created by Vivien on 15/10/27.
//  Copyright © 2015年 vivien. All rights reserved.
//

#import "KeyAnimationVC.h"

@interface KeyAnimationVC (){
    CALayer *_layer;
}

@end

@implementation KeyAnimationVC




- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景(注意这个图片其实在根图层)
    UIImage *backgroundImage=[UIImage imageNamed:@"background.jpg"];
    self.view.backgroundColor=[UIColor colorWithPatternImage:backgroundImage];
    
    //自定义一个图层
    _layer=[[CALayer alloc]init];
    _layer.bounds=CGRectMake(0, 0, 10, 20);
    _layer.position=CGPointMake(50, 150);
    _layer.contents=(id)[UIImage imageNamed:@"petal.png"].CGImage;
    [self.view.layer addSublayer:_layer];
    
    //创建动画
    [self translationAnimation];
}

//示例1
#pragma mark 关键帧动画  直线飘落
- (void)translationAnimation{
    //1.创建关键帧动画并设置动画属性
    CAKeyframeAnimation *keyframeAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    //2.设置关键帧,这里有四个关键帧
    NSValue *key1=[NSValue valueWithCGPoint:_layer.position];//对于关键帧动画初始值不能省略
    NSValue *key2=[NSValue valueWithCGPoint:CGPointMake(80, 220)];
    NSValue *key3=[NSValue valueWithCGPoint:CGPointMake(45, 300)];
    NSValue *key4=[NSValue valueWithCGPoint:CGPointMake(55, 400)];
    NSArray *values=@[key1,key2,key3,key4];
    keyframeAnimation.values=values;
    keyframeAnimation.calculationMode = kCAAnimationCubic;
    keyframeAnimation.repeatCount = HUGE_VALF;
    //设置其他属性
    keyframeAnimation.duration=8.0;
    keyframeAnimation.beginTime=CACurrentMediaTime()+2;//设置延迟2秒执行
    
    
    //3.添加动画到图层，添加动画后就会执行动画
    [_layer addAnimation:keyframeAnimation forKey:@"KCKeyframeAnimation_Position"];
}


////贝塞尔曲线
//示例2
//- (void)translationAnimation{
//    //1.创建关键帧动画并设置动画属性
//    CAKeyframeAnimation *keyframeAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
//    
//    //2.设置路径
//    //绘制贝塞尔曲线
//    CGPathRef path=CGPathCreateMutable();
//    CGPathMoveToPoint(path, NULL, _layer.position.x, _layer.position.y);//移动到起始点
//    CGPathAddCurveToPoint(path, NULL, 160, 280, -30, 300, 55, 400);//绘制二次贝塞尔曲线
//    
//    keyframeAnimation.path=path;//设置path属性
//    CGPathRelease(path);//释放路径对象
//    //设置其他属性
//    keyframeAnimation.duration=8.0;
//    keyframeAnimation.beginTime=CACurrentMediaTime()+5;//设置延迟2秒执行
//    
//    
//    //3.添加动画到图层，添加动画后就会执行动画
//    [_layer addAnimation:keyframeAnimation forKey:@"KCKeyframeAnimation_Position"];
//}

@end
