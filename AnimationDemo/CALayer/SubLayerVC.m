//
//  SubLayerVC.m
//  AnimationDemo
//
//  Created by Vivien on 15/10/27.
//  Copyright © 2015年 vivien. All rights reserved.
//

#import "SubLayerVC.h"
@interface SubLayerVC ()

@property (nonatomic, strong) NSTimer      *timer;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CAShapeLayer *shapeLayer3;
@property (nonatomic, strong) CAShapeLayer *circleLayer;

@end

@implementation SubLayerVC




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // [self createCAEmitterLayerExampleOne];
    
    [self createCAEmitterLayerExampleTwo];
    
   
    
    [self createShapeLayerExampleOne];
//    [self  createShapeLayerExampleTwo];
//    [self createShapeLayerExampleThree];
    
    


}

-(void)createShapeLayerExampleOne
{
    //示例1
    // 创建shapeLayer
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.frame         = (CGRect){CGPointMake(0, 0), CGSizeMake(200, 200)};
    _shapeLayer.position      = CGPointMake(200, 250);  //self.view.center;
    _shapeLayer.path          = [self getStar2BezierPath].CGPath;
    _shapeLayer.fillColor     = [UIColor greenColor].CGColor;
    _shapeLayer.strokeColor   = [UIColor redColor].CGColor;
    _shapeLayer.lineWidth     = 2.f;
    [self.view.layer addSublayer:_shapeLayer];
    
    // 创建定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.f
                                              target:self
                                            selector:@selector(pathAnimation)
                                            userInfo:nil
                                             repeats:YES];
}

-(void)createShapeLayerExampleTwo
{
    //示例2
    // 创建椭圆形贝塞尔曲线
    // UIBezierPath *oval = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 200, 100)];
    // 创建矩形贝塞尔曲线
    UIBezierPath *rect = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 200, 100)];
    // 创建圆形贝塞尔曲线
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
    
    // 创建CAShapeLayer
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.bounds         = CGRectMake(0, 0, 200, 50);
    shape.position      =  CGPointMake(120, 100);//self.view.center;
    
    // 显示CAShapeLayer的边界
    shape.borderWidth   = 1.f;
    
    // 禁止内容显示超出CAShapeLayer的frame值
    shape.masksToBounds = YES;
    // 修改贝塞尔曲线的填充颜色
    shape.fillColor     = [UIColor redColor].CGColor;
    // 建立贝塞尔曲线与CAShapeLayer之间的关联
    shape.path = circle.CGPath;
    
    // 添加并显示
    [self.view.layer addSublayer:shape];
}


-(void)createShapeLayerExampleThree
{
    //示例3
    // 创建椭圆形贝塞尔曲线
    UIBezierPath *oval        = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
    
    // 创建CAShapeLayer
    _shapeLayer3               = [CAShapeLayer layer];
    _shapeLayer3.frame         = CGRectMake(0, 0, 100, 100);
    _shapeLayer3.position      = self.view.center;
    
    // 修改CAShapeLayer的线条相关值
    _shapeLayer3.fillColor     = [UIColor clearColor].CGColor;
    _shapeLayer3.strokeColor   = [UIColor redColor].CGColor;
    _shapeLayer3.lineWidth     = 2.f;
    
    //0 是最右侧点，0.25是最下方的点，0.5是最左侧的点，0.75是最顶端的点
    _shapeLayer3.strokeStart   = 0.f;
    _shapeLayer3.strokeEnd     = 0.f;
    
    // 建立贝塞尔曲线与CAShapeLayer之间的关联
    _shapeLayer3.path          = oval.CGPath;
    
    // 添加并显示
    [self.view.layer addSublayer:_shapeLayer3];
    
    // 创建定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.f
                                              target:self
                                            selector:@selector(animationEventTypeTwo)
                                            userInfo:nil
                                             repeats:YES];
    
}


/**
 *  动画效果1
 */
- (void)animationEventTypeOne {
    // 执行隐式动画
    _shapeLayer3.strokeEnd = arc4random() % 100 / 100.f;
}

/**
 *  动画效果2
 */
- (void)animationEventTypeTwo {
    CGFloat valueOne = arc4random() % 100 / 100.f;
    CGFloat valueTwo = arc4random() % 100 / 100.f;
    
    // 执行隐式动画
    _shapeLayer3.strokeStart = valueOne < valueTwo ? valueOne : valueTwo;
    _shapeLayer3.strokeEnd   = valueOne > valueTwo ? valueOne : valueTwo;
}



//示例1函数
/**
 *  执行path的动画
 */
- (void)pathAnimation {
    static int i = 0;
    if (i++ % 2 == 0) {
        CABasicAnimation *circleAnim = [CABasicAnimation animationWithKeyPath:@"path"];
        circleAnim.removedOnCompletion = NO;
        circleAnim.duration            = 1;
        circleAnim.fromValue           = (__bridge id)[self getStar1BezierPath].CGPath;
        circleAnim.toValue             = (__bridge id)[self getStar2BezierPath].CGPath;
        _shapeLayer.path               = [self getStar2BezierPath].CGPath;
        [_shapeLayer addAnimation:circleAnim forKey:@"animateCirclePath"];
    } else {
        CABasicAnimation *circleAnim = [CABasicAnimation animationWithKeyPath:@"path"];
        circleAnim.removedOnCompletion = NO;
        circleAnim.duration            = 1;
        circleAnim.fromValue           = (__bridge id)[self getStar2BezierPath].CGPath;
        circleAnim.toValue             = (__bridge id)[self getStar1BezierPath].CGPath;
        _shapeLayer.path               = [self getStar1BezierPath].CGPath;
        [_shapeLayer addAnimation:circleAnim forKey:@"animateCirclePath"];
    }
}

/**
 *  贝塞尔曲线1
 *
 *  @return 贝塞尔曲线
 */
-(UIBezierPath *)getStar1BezierPath {
    //// Star Drawing
    UIBezierPath* starPath = [UIBezierPath bezierPath];
    [starPath moveToPoint: CGPointMake(22.5, 2.5)];
    [starPath addLineToPoint: CGPointMake(28.32, 14.49)];
    [starPath addLineToPoint: CGPointMake(41.52, 16.32)];
    [starPath addLineToPoint: CGPointMake(31.92, 25.56)];
    [starPath addLineToPoint: CGPointMake(34.26, 38.68)];
    [starPath addLineToPoint: CGPointMake(22.5, 32.4)];
    [starPath addLineToPoint: CGPointMake(10.74, 38.68)];
    [starPath addLineToPoint: CGPointMake(13.08, 25.56)];
    [starPath addLineToPoint: CGPointMake(3.48, 16.32)];
    [starPath addLineToPoint: CGPointMake(16.68, 14.49)];
    [starPath closePath];
    
    return starPath;
}
/**
 *  贝塞尔曲线2
 *
 *  @return 贝塞尔曲线
 */
-(UIBezierPath *)getStar2BezierPath {
    //// Star Drawing
    UIBezierPath* starPath = [UIBezierPath bezierPath];
    [starPath moveToPoint: CGPointMake(22.5, 2.5)];
    [starPath addLineToPoint: CGPointMake(32.15, 9.21)];
    [starPath addLineToPoint: CGPointMake(41.52, 16.32)];
    [starPath addLineToPoint: CGPointMake(38.12, 27.57)];
    [starPath addLineToPoint: CGPointMake(34.26, 38.68)];
    [starPath addLineToPoint: CGPointMake(22.5, 38.92)];
    [starPath addLineToPoint: CGPointMake(10.74, 38.68)];
    [starPath addLineToPoint: CGPointMake(6.88, 27.57)];
    [starPath addLineToPoint: CGPointMake(3.48, 16.32)];
    [starPath addLineToPoint: CGPointMake(12.85, 9.21)];
    [starPath closePath];
    
    return starPath;
}



/********
 CAEmitterLayer 粒子发生器
 **************/
//CAEmitterLayer  示例1
-(void)createCAEmitterLayerExampleOne
{
    
    
    //create particle emitter layer
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = self.view.bounds;
    [self.view.layer addSublayer:emitter];
    //configure emitter
    emitter.renderMode = kCAEmitterLayerBackToFront;  //kCAEmitterLayerAdditive;
    emitter.emitterPosition = CGPointMake(emitter.frame.size.width / 2.0, emitter.frame.size.height / 2.0);
    
    //create a particle template
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id)[UIImage imageNamed:@"petal.png"].CGImage;
    cell.birthRate = 150;
    cell.lifetime = 5.0;
    cell.color = [UIColor colorWithRed:1 green:0.5 blue:0.1 alpha:1.0].CGColor;
    cell.alphaSpeed = -0.4;
    cell.velocity = 50;
    cell.velocityRange = 50;
    cell.emissionRange = M_PI * 2.0;
    
    //add particle template to emitter
    emitter.emitterCells = @[cell];
    
}

//示例2
-(void)createCAEmitterLayerExampleTwo
{
    
    CAEmitterLayer *mortor = [CAEmitterLayer layer];
    //emitterPosition指定emitter的位置
    mortor.emitterPosition = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height*(0.75));
    //renderMode定义粒子的渲染方式
    mortor.renderMode = kCAEmitterLayerAdditive;
    //birthRate让粒子每秒产生4次
    mortor.birthRate = 4;
    [self.view.layer addSublayer:mortor];
    
    CAEmitterCell *rocket = [CAEmitterCell emitterCell];
    //定义粒子的内容
    rocket.contents =(__bridge id)[UIImage imageNamed:@"petal.png"].CGImage;
    //emissionLongitude和emissionLatitude指定经纬度
    rocket.emissionLongitude = -M_PI /2;
    rocket.emissionLatitude = 0;
    //lifetime 粒子的存活时间 1.6秒
    rocket.lifetime = 1.6;
    //birhRate定义每秒生成100个，与CAEmitterLayer的birthRate相乘，最终的粒子数辆400个每秒。
    rocket.birthRate = 100;
    //velcity指定了初速度
    rocket.velocity = 400;
    //velcityRange设置初速度在300到500之间浮动
    rocket.velocityRange = 100;
    //yAcceleration指定了沿y轴250的加速度，用于给粒子减速
    rocket.yAcceleration= 250;
    rocket.emissionRange = M_PI /4;
    //color设置了粒子的颜色，并设置了每个色值的浮动范围，用于生成所有颜色的烟火。
    rocket.color = CGColorCreateCopy([UIColor colorWithRed:.5 green:.5 blue:.5 alpha:.5].CGColor);
    rocket.redRange = 0.5;
    rocket.greenRange= 0.5;
    rocket.blueRange = 0.5;
    //最后设置了名称，以后可以再次引用它。
    [rocket setName:@"rocket"];
    
    mortor.emitterCells = [NSArray arrayWithObjects:rocket, nil];
}



@end
