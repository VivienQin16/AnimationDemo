//
//  AnimationVC.m
//  AnimationDemo
//
//  Created by Vivien on 15/10/26.
//  Copyright © 2015年 vivien. All rights reserved.
//

#import "AnimationVC.h"
@interface AnimationVC (){
    CALayer *_layer;
    CGPoint fromValue;
    
    UIImageView *_imageView;

}

@end
@implementation AnimationVC


/**
 *  示例1
 *
 */
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    self.view.backgroundColor = [UIColor whiteColor];
//    //创建图像显示控件
//    _imageVie = [UIImageView alloc]initWithImage:[UIImage imageNamed:@"ball.png"]];
//    _imageView.center=CGPointMake(160, 150);
//    [self.view addSubview:_imageView];
//}
//
//#pragma mark 点击事件
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    UITouch *touch=touches.anyObject;
//    CGPoint location= [touch locationInView:self.view];
//    /*创建弹性动画
//     damping:阻尼，范围0-1，阻尼越接近于0，弹性效果越明显
//     velocity:弹性复位的速度
//     */
//    [UIView animateWithDuration:5.0 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
//        _imageView.center=location; //CGPointMake(160, 284);
//    } completion:nil];
//}


//示例2 通过block和静态方法实现动画控制
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景
    UIImage *backgroundImage=[UIImage imageNamed:@"background.jpg"];
    self.view.backgroundColor=[UIColor colorWithPatternImage:backgroundImage];
    
    //创建图像显示控件
    _imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"petal.png"]];
    _imageView.center=CGPointMake(50, 150);
    [self.view addSubview:_imageView];
}

#pragma mark 点击事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=touches.anyObject;
    CGPoint location= [touch locationInView:self.view];
    //方法1：block方式
    /*开始动画，UIView的动画方法执行完后动画会停留在重点位置，而不需要进行任何特殊处理
     duration:执行时间
     delay:延迟时间
     options:动画设置，例如自动恢复、匀速运动等
     completion:动画完成回调方法
     */
        [UIView animateWithDuration:5.0 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            _imageView.center=location;
        } completion:^(BOOL finished) {
            NSLog(@"Animation end.");
        }];
    
    //方法2：静态方法
    //开始动画
//    [UIView beginAnimations:@"KCBasicAnimation" context:nil];
//    [UIView setAnimationDuration:5.0];
    //[UIView setAnimationDelay:1.0];//设置延迟
    //[UIView setAnimationRepeatAutoreverses:NO];//是否回复
    //[UIView setAnimationRepeatCount:10];//重复次数
    //[UIView setAnimationStartDate:(NSDate *)];//设置动画开始运行的时间
    //[UIView setAnimationDelegate:self];//设置代理
    //[UIView setAnimationWillStartSelector:(SEL)];//设置动画开始运动的执行方法
    //[UIView setAnimationDidStopSelector:(SEL)];//设置动画运行结束后的执行方法
    
    _imageView.center=location;
    
    
    //开始动画
//    [UIView commitAnimations];
    
    //方法示例3:UIView 关键帧  有点问题
    [UIView animateKeyframesWithDuration:5.0 delay:0 options: UIViewAnimationOptionCurveLinear| UIViewAnimationOptionCurveLinear animations:^{
        //第二个关键帧（准确的说第一个关键帧是开始位置）:从0秒开始持续50%的时间，也就是5.0*0.5=2.5秒
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
            _imageView.center=CGPointMake(80.0, 220.0);
        }];
        //第三个关键帧，从0.5*5.0秒开始，持续5.0*0.25=1.25秒
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.25 animations:^{
            _imageView.center=CGPointMake(45.0, 300.0);
        }];
        //第四个关键帧：从0.75*5.0秒开始，持所需5.0*0.25=1.25秒
        [UIView addKeyframeWithRelativeStartTime:0.75 relativeDuration:0.25 animations:^{
            _imageView.center=CGPointMake(55.0, 400.0);
        }];
        
    } completion:^(BOOL finished) {
        NSLog(@"Animation end.");
    }];
    
}



/********
 
 由UIView  封装的动画
************/


//示例3

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    UIImage *image=[UIImage imageNamed:@"open2.png"];
//    UIImageView *imageView=[[UIImageView alloc]init];
//    imageView.image=image;
//    imageView.frame=CGRectMake(120, 140, 80, 80);
//    [self.view addSubview:imageView];
//    
//    //两秒后开始一个持续一分钟的动画
//    [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//        imageView.frame=CGRectMake(80, 100, 160, 160);
//    } completion:nil];
//}




/**
 *  图层动画的本质就是将图层内部的内容转化为位图经硬件操作形成一种动画效果，其实图层本身并没有任何的变化
 *
 *  @return <#return value description#>
 */

//示例3
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    //设置背景(注意这个图片其实在根图层)
//    UIImage *backgroundImage=[UIImage imageNamed:@"background.jpg"];
//    self.view.backgroundColor=[UIColor colorWithPatternImage:backgroundImage];
//    
//    //自定义一个图层
//    _layer=[[CALayer alloc]init];
//    _layer.bounds=CGRectMake(0, 64, 10, 20);
//    _layer.position=CGPointMake(50, 150);
//    _layer.contents=(id)[UIImage imageNamed:@"petal.png"].CGImage;
//    [self.view.layer addSublayer:_layer];
//    
//    fromValue = _layer.position;
//    
//
//}
//
//#pragma mark 点击事件
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    UITouch *touch=touches.anyObject;
//    CGPoint location= [touch locationInView:self.view];
//    //创建并开始动画
//    CAAnimation *animation = [_layer animationForKey:@"KCBasicAnimation_Translation"];
//    if (animation) {
//        if (_layer.speed==0) {
//            [self animationResume];
//            
//        }else
//        {
//            [self animationPause];
//        }
//        
//    }
//    else{
//        [self translatonAnimation:location];
//        
//        [self rotationAnimation];
//    }
//    
//    
//}
//
//
//#pragma mark 移动动画
//-(void)translatonAnimation:(CGPoint)location{
//    //1.创建动画并指定动画属性
//    CABasicAnimation *basicAnimation=[CABasicAnimation animationWithKeyPath:@"position"];
//    
//    
//    
//    //2.设置动画属性初始值和结束值
//   // basicAnimation.fromValue=[NSNumber numberWithInteger:50];//可以不设置，默认为图层初始状态
//    basicAnimation.fromValue = [NSValue valueWithCGPoint:fromValue];
//    basicAnimation.toValue=[NSValue valueWithCGPoint:location];
//    
//    //设置其他动画属性
//    basicAnimation.duration=5.0;//动画时间5秒
//   // basicAnimation.repeatCount=HUGE_VALF;//设置重复次数,HUGE_VALF可看做无穷大，起到循环动画的效果
//   // basicAnimation.removedOnCompletion=NO;//运行一次是否移除动画
//    
//    
//     basicAnimation.delegate=self;
//     //存储当前位置在动画结束后使用
//     [basicAnimation setValue:[NSValue valueWithCGPoint:location] forKey:@"KCBasicAnimationLocation"];
//    
//    //3.添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
//    [_layer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Translation"];
//   // _layer.position = location;
//}
//
//
////
////真正起到暂停动画和恢复动画的其实是动画速度的调整，媒体时间偏移量以及恢复时的开始时间设置主要为了让动画更加连贯。
////
////
//-(void)animationResume
//{
//    //获得暂停的时间
//    CFTimeInterval beginTime = CACurrentMediaTime() - _layer.timeOffset;
//    NSLog(@"beginTime:%f,CACurrentMediaTime():%f",beginTime,CACurrentMediaTime());
//    //设置偏移量
//    _layer.timeOffset = 0;
//    //设置开始时间
//    //layer的beginTime是指其父级对象的时间线上的某个时间
//    _layer.beginTime = beginTime;
//    //设置动画速度，开始运动
//    _layer.speed= 1.0;
//    
//}
//-(void)animationPause
//{
//    //取得指定图层动画的媒体时间，后面参数用于指定子图层，这里不需要
//    CFTimeInterval interval = [_layer convertTime:CACurrentMediaTime() fromLayer:nil];
//    NSLog(@"interval:%f,CACurrentMediaTime():%f",interval,CACurrentMediaTime());
//    //设置时间偏移量，保证暂停时停留在旋转的位置
//    [_layer setTimeOffset:interval];
//    //速度设置为0，暂停动画
//    _layer.speed = 0;
//}
//
//
//
//
//
//
//#pragma mark - 动画代理方法
//#pragma mark 动画开始
//-(void)animationDidStart:(CAAnimation *)anim{
//  //  NSLog(@"animation(%@) start.\r_layer.frame=%@",anim,NSStringFromCGRect(_layer.frame));
//  //  NSLog(@"%@",[_layer animationForKey:@"KCBasicAnimation_Translation"]);//通过前面的设置的key获得动画
//}
//
//#pragma mark 动画结束
//-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
//    
//   // NSLog(@"animation(%@) stop.\r_layer.frame=%@",anim,NSStringFromCGRect(_layer.frame));
//    
//    //开启事务
//    [CATransaction begin];
//    //禁用隐式动画
//    [CATransaction setDisableActions:YES];
//    //在动画结束后重新设置了position，而position是可动画属性.所以再动画完成后，会重新从起点运动到终点。
//    _layer.position=[[anim valueForKey:@"KCBasicAnimationLocation"] CGPointValue];
//    
//    //提交事务
//    [CATransaction commit];
//    
//    fromValue = _layer.position;
//}
//
///**********
// 
//  任何Layer的animatable属性的设置都应该属于某个CA事务(CATransaction),事务的作用是为了保证多个animatable属性的变化同时进行,不管是同一个layer还是不同的layer之间的.CATransaction也分两类,显式的和隐式的,当在某次RunLoop中设置一个animatable属性的时候,如果发现当前没有事务,则会自动创建一个CA事务,在线程的下个RunLoop开始时自动commit这个事务,如果在没有RunLoop的地方设置layer的animatable属性,则必须使用显式的事务.
// 
// 
// 事务可以嵌套.当事务嵌套时候,只有当最外层的事务commit了之后,整个动画才开始.
// 
// *************/
//
//#pragma mark 旋转动画
//-(void)rotationAnimation{
//    //1.创建动画并指定动画属性
//    CABasicAnimation *basicAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    
//    //2.设置动画属性初始值、结束值
//    basicAnimation.fromValue=[NSNumber numberWithInt:M_PI_2];
//    basicAnimation.toValue=[NSNumber numberWithFloat:M_PI_2*3];
//    
//    //设置其他动画属性
//    basicAnimation.duration=6.0;
//    basicAnimation.autoreverses=true;//旋转后再旋转到原来的位置
//    
//    
//    //4.添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
//    [_layer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Rotation"];
//}



@end
