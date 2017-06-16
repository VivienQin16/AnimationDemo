//
//  DisplayLinkVC.m
//  AnimationDemo
//
//  Created by Vivien on 15/10/27.
//  Copyright © 2015年 vivien. All rights reserved.
//

#import "DisplayLinkVC.h"
#define IMAGE_COUNT 10
@interface DisplayLinkVC (){
    CALayer *_layer;
    int _index;
    NSMutableArray *_images;
    
}

@end

@implementation DisplayLinkVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景
    self.view.layer.contents=(id)[UIImage imageNamed:@"bg.png"].CGImage;
    
    //创建图像显示图层
    _layer=[[CALayer alloc]init];
    _layer.bounds=CGRectMake(0, 0, 87, 32);
    _layer.position=CGPointMake(160, 284);
    [self.view.layer addSublayer:_layer];
    
    //由于鱼的图片在循环中会不断创建，而10张鱼的照片相对都很小
    //与其在循环中不断创建UIImage不如直接将10张图片缓存起来
    _images=[NSMutableArray array];
    for (int i=0; i<10; ++i) {
        NSString *imageName=[NSString stringWithFormat:@"fish%i.png",i];
        UIImage *image=[UIImage imageNamed:imageName];
        [_images addObject:image];
    }
    
    //定义时钟对象           //CADisplayLink默认每秒运行60次
    CADisplayLink *displayLink=[CADisplayLink displayLinkWithTarget:self selector:@selector(step)];
    //添加时钟对象到主运行循环
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
}
/**
 *   iOS的定时器NSTimer定时更新图片来可达到逐帧动画的效果。这种方式确实可以解决UIImageView一次性加载大量图片的问题，而且让播放过程可控。
    唯一的缺点就是定时器方法调用有时可能会因为当前系统执行某种比较占用时间的任务造成动画连续性出现问题
 
     CADisplayLink是一个计时器，但是同NSTimer不同的是，CADisplayLink的刷新周期同屏幕完全一致。例如在iOS中屏幕刷新周期是60次/秒，CADisplayLink刷新周期同屏幕刷新一致也是60次/秒，这样一来使用它完成的逐帧动画（又称为“时钟动画”）完全感觉不到动画的停滞情况。
 *
 *  @param 每秒接近60次
 *
 *  @return
 */


#pragma mark 每次屏幕刷新就会执行一次此方法(每秒接近60次)
- (void)step{
    //定义一个变量记录执行次数
    static int s = 0;
    //每秒执行6次
    if (++s%10 == 0) {
        UIImage *image = _images[_index];
        _layer.contents = (id)image.CGImage;//更新图片
        _index = (_index+1)%IMAGE_COUNT;
    }
}
@end
