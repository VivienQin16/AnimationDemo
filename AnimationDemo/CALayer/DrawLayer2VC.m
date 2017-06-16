//
//  DrawLayer2VC.m
//  AnimationDemo
//
//  Created by Vivien on 15/10/26.
//  Copyright © 2015年 vivien. All rights reserved.
//

#import "DrawLayer2VC.h"
#define PHOTO_HEIGHT 150
@implementation DrawLayer2VC

//事实上如果仅仅就显示一张图片在图层中当然没有必要那么麻烦，直接设置图层contents就可以了，不牵涉到绘图也就没有倒立的问题了

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGPoint position= CGPointMake(160, 200);
    CGRect bounds=CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT);
    CGFloat cornerRadius=PHOTO_HEIGHT/2;
    CGFloat borderWidth=2;
    
    //阴影图层
    CALayer *layerShadow=[[CALayer alloc]init];
    layerShadow.bounds=bounds;
    layerShadow.position=position;
    layerShadow.cornerRadius=cornerRadius;
    layerShadow.shadowColor=[UIColor grayColor].CGColor;
    layerShadow.shadowOffset=CGSizeMake(2, 1);
    layerShadow.shadowOpacity=1;
    layerShadow.borderColor=[UIColor whiteColor].CGColor;
    layerShadow.borderWidth=borderWidth;
    [self.view.layer addSublayer:layerShadow];
    
    //容器图层
    CALayer *layer=[[CALayer alloc]init];
    layer.bounds=bounds;
    layer.position=position;
    layer.backgroundColor=[UIColor redColor].CGColor;
    layer.cornerRadius=cornerRadius;
    layer.masksToBounds=YES;
    layer.borderColor=[UIColor whiteColor].CGColor;
    layer.borderWidth=borderWidth;
    //设置内容（注意这里一定要转换为CGImage）
    UIImage *image=[UIImage imageNamed:@"photo.jpg"];
    //    layer.contents=(id)image.CGImage;
    [layer setContents:(id)image.CGImage];
    
    //添加图层到根图层
    [self.view.layer addSublayer:layer];
}


/**
 *   两种不同的方法实现旋转
 */

//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor greenColor];
//    
//    CGPoint position= CGPointMake(160, 200);
//    CGRect bounds=CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT);
//    CGFloat cornerRadius=PHOTO_HEIGHT/2;
//    CGFloat borderWidth=2;
//    
//    //阴影图层
//    CALayer *layerShadow=[[CALayer alloc]init];
//    layerShadow.bounds=bounds;
//    layerShadow.position=position;
//    layerShadow.cornerRadius=cornerRadius;
//    layerShadow.shadowColor=[UIColor grayColor].CGColor;
//    layerShadow.shadowOffset=CGSizeMake(2, 1);
//    layerShadow.shadowOpacity=1;
//    layerShadow.borderColor=[UIColor whiteColor].CGColor;
//    layerShadow.borderWidth=borderWidth;
//    [self.view.layer addSublayer:layerShadow];
//    
//    //容器图层
//    CALayer *layer=[[CALayer alloc]init];
//    layer.bounds=bounds;
//    layer.position=position;
//    layer.backgroundColor=[UIColor redColor].CGColor;
//    layer.cornerRadius=cornerRadius;
//    layer.masksToBounds=YES;
//    layer.borderColor=[UIColor whiteColor].CGColor;
//    layer.borderWidth=borderWidth;
//    
//    //利用图层形变解决图像倒立问题
//    layer.transform=CATransform3DMakeRotation(M_PI, 1, 0, 0);
//    
//    //设置图层代理
//    layer.delegate=self;
//    
//    //添加图层到根图层
//    [self.view.layer addSublayer:layer];
//    
//    //调用图层setNeedDisplay,否则代理方法不会被调用
//    [layer setNeedsDisplay];
//}
//
//#pragma mark 绘制图形、图像到图层，注意参数中的ctx时图层的图形上下文，其中绘图位置也是相对图层而言的
//-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
//    //    NSLog(@"%@",layer);//这个图层正是上面定义的图层
//    UIImage *image=[UIImage imageNamed:@"photo.jpg"];
//    //注意这个位置是相对于图层而言的不是屏幕
//    CGContextDrawImage(ctx, CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT), image.CGImage);
//}


@end
