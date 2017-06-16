//
//  CAGradientLayerVC.m
//  AnimationDemo
//
//  Created by QinTing on 15/11/1.
//  Copyright © 2015年 vivien. All rights reserved.
//

#import "CAGradientLayerVC.h"

// 将常数转换为度数
#define   DEGREES(degrees)  ((M_PI * (degrees))/ 180.f)

//Color
#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBColorAlpha(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
@interface CAGradientLayerVC ()

//Example
@property (nonatomic, strong) NSTimer         *timer;
@property (nonatomic, strong) CAGradientLayer *faucet;
@property (nonatomic, strong) CAShapeLayer    *circleLayer;


//Example Two
@property (nonatomic, strong) CAGradientLayer    *gradientLayer;
@end

@implementation CAGradientLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 设置背景色
    self.view.backgroundColor = [UIColor colorWithRed:0.878 green:0.878 blue:0.878 alpha:1];
    
    
//    [self createGradientLayerExample];
    
    [self createCradentLayerExampleThree];
//
//    [self createGradientLayerExampleTwo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createGradientLayerExample
{
    
    //基础示例
    self.gradientLayer  = [CAGradientLayer layer];
    self.gradientLayer.bounds =CGRectMake(0, 0, 200, 200);
    self.gradientLayer.position = self.view.center;
    
    self.gradientLayer.borderWidth =0.8f;
    
    [self.view.layer addSublayer:self.gradientLayer];
    
    //设置颜色组
    self.gradientLayer.colors = @[(__bridge id)RGBColor(0x0b, 0xac, 0x56).CGColor,  //0bac56   21cd72
                                  (__bridge id)RGBColor(0x21, 0xcd, 0x72).CGColor,
                                  ];
    //设置颜色渐变方向
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(1,1);
    
    //设置颜色分割点
//    self.gradientLayer.locations =@[@(0.1),@(0.5),@(0.8)];
//    self.gradientLayer.borderWidth =0.8f;
//    
//    [self.view.layer addSublayer:self.gradientLayer];
//    
//    //设置颜色组
//    self.gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
//                                  (__bridge id)[UIColor greenColor].CGColor,
//                                  (__bridge id)[UIColor blueColor].CGColor,
//                                  ];
//    //设置颜色渐变方向
//    self.gradientLayer.startPoint = CGPointMake(0, 0);
//    self.gradientLayer.endPoint = CGPointMake(0,1);
//    
//    //设置颜色分割点
//    self.gradientLayer.locations =@[@(0.1),@(0.5),@(0.8)];
    
    
}

-(void)createCradentLayerExampleThree
{
    //实现色差动画
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"open2.png"]];
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = imageView.bounds;  //不知道为什么用bounds 即使加上center也不行。
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(0, 1);
    
    self.gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                                  (__bridge id)[UIColor redColor].CGColor,
                                  ];
    self.gradientLayer.locations = @[@(0.5f),@(1.0f)];
    
    
    [imageView.layer addSublayer:self.gradientLayer];
    // 创建定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f
                                                  target:self
                                                selector:@selector(timerEvent3)
                                                userInfo:nil
                                                 repeats:YES];
    
//    试试看
    
}
-(void)timerEvent3
{
    //direction color  percent 可以做动画
    
    self.gradientLayer.colors=  @[(__bridge id)[UIColor clearColor].CGColor,
                                 (__bridge id)[UIColor colorWithRed:arc4random()%255/255.f
                                                             green:arc4random()%255/255.f
                                                              blue:arc4random()%255/255.f alpha:1].CGColor
                                ];
    
    self.gradientLayer.locations = @[@(arc4random()%10/10.0f),@(1.0f)];
}
-(void)createGradientLayerExampleTwo
{
    
    self.circleLayer = [CAShapeLayer layer];
    
    // 贝塞尔曲线(创建一个圆)
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(82 , 82)
                                                        radius:80
                                                    startAngle:DEGREES(0)
                                                      endAngle:DEGREES(360)
                                                     clockwise:YES];
    
    // 获取path
    self.circleLayer.path = path.CGPath;
   // self.circleLayer.position = CGPointMake(82, 82);
    
    // 设置填充颜色为透明
    self.circleLayer.fillColor = [UIColor clearColor].CGColor;
    //曲线分段方式
    self.circleLayer.lineDashPattern = @[@10, @10];

    
    self.circleLayer.strokeColor   = [UIColor blackColor].CGColor;  // 边缘线的颜色
    self.circleLayer.lineCap       = kCALineCapSquare;              // 边缘线的类型
    self.circleLayer.lineWidth     = 4.f;                           // 线条宽度
    self.circleLayer.strokeStart   = 0.0f;
    self.circleLayer.strokeEnd     = 1.0f;
    
    // 创建渐变图层
    self.faucet          = [CAGradientLayer layer];
    self.faucet.frame    = CGRectMake(0, 0, 200, 200);
    self.faucet.position = self.view.center;
    
    // 以CAShapeLayer的形状作为遮罩是实现特定颜色渐变的关键
    self.faucet.mask   = self.circleLayer;
    self.faucet.colors = @[(id)[UIColor greenColor].CGColor,
                           (id)[UIColor redColor].CGColor,
                           (id)[UIColor cyanColor].CGColor,
                           (id)[UIColor purpleColor].CGColor,
                           (id)[UIColor yellowColor].CGColor];
    
    // 设定动画时间
    self.faucet.speed = 0.5f;
    
    // 添加到系统图层中
    [self.view.layer addSublayer:self.faucet];
    
    // 创建定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f
                                                  target:self
                                                selector:@selector(timerEvent)
                                                userInfo:nil
                                                 repeats:YES];
}


/**
 *  定时器事件
 */
- (void)timerEvent {
    self.faucet.colors = @[(id)[UIColor colorWithRed:arc4random()%255/255.f
                                               green:arc4random()%255/255.f
                                                blue:arc4random()%255/255.f
                                               alpha:1].CGColor,
                           (id)[UIColor colorWithRed:arc4random()%255/255.f
                                               green:arc4random()%255/255.f
                                                blue:arc4random()%255/255.f
                                               alpha:1].CGColor,
                           (id)[UIColor colorWithRed:arc4random()%255/255.f
                                               green:arc4random()%255/255.f
                                                blue:arc4random()%255/255.f
                                               alpha:1].CGColor,
                           (id)[UIColor colorWithRed:arc4random()%255/255.f
                                               green:arc4random()%255/255.f
                                                blue:arc4random()%255/255.f
                                               alpha:1].CGColor,
                           (id)[UIColor colorWithRed:arc4random()%255/255.f
                                               green:arc4random()%255/255.f
                                                blue:arc4random()%255/255.f
                                               alpha:1].CGColor];
}


@end
