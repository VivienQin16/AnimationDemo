//
//  ViewController.m
//  AnimationDemo
//
//  Created by Vivien on 15/10/26.
//  Copyright © 2015年 vivien. All rights reserved.
//

#import "ViewController.h"
#import "DrawCALayerVC.h"
#import "DrawLayer1VC.h"
#import "DrawLayer2VC.h"
#import "DrawLayer3VC.h"
#import "AnimationVC.h"
#import "KeyAnimationVC.h"
#import "GroupAnimationVC.h"
#import "TransitionAnimationVC.h"
#import "DisplayLinkVC.h"
#import "SubLayerVC.h"
#import "CAGradientLayerVC.h"
#import "EasingAnimationVC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Animation Demo";
    _menu = [[UITableView alloc]initWithFrame:self.view.bounds];
    _menu.delegate = self;
    _menu.dataSource = self;
    [self.view  addSubview:_menu];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 20;
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure
    switch (indexPath.row) {
        case 0: {
            cell.textLabel.text = @"draw calayer";
            cell.detailTextLabel.text = @"点击图片试试";
            break;
        }
        case 1: {
            cell.textLabel.text = @"带阴影效果的圆形图片裁切";
            cell.detailTextLabel.text = @"使用代理方法绘图";
            break;
        }
        case 2: {
            cell.textLabel.text = @"图层的形变";
            cell.detailTextLabel.text = @"showing grid first, nav arrows enabled";
            break;
        }
        case 3: {
            cell.textLabel.text = @"使用自定义图层绘图";
            cell.detailTextLabel.text = @"自己编写一个类继承于CALayer然后在drawInContext:中绘图即可";
            break;
        }
        case 4: {
            cell.textLabel.text = @"Animation";
            cell.detailTextLabel.text = @"基础动画";
            break;
        }
        case 5: {
            cell.textLabel.text = @"关键帧动画";
            cell.detailTextLabel.text = @"CAKeyframeAnimation";
            break;
        }
        case 6: {
            cell.textLabel.text = @"动画组";
            cell.detailTextLabel.text = @"CAAnimationGroup";
            break;
        }
        case 7: {
            cell.textLabel.text = @"转场动画";
            cell.detailTextLabel.text = @"CATransition——图片浏览器";
            break;
        }
        case 8: {
            cell.textLabel.text = @"逐帧动画";
            cell.detailTextLabel.text = @"使用逐帧动画完成动画连续性";
            break;
        }
        case 9: {
            cell.textLabel.text = @"SubLayer";
            cell.detailTextLabel.text = @"CAEmitterLayer和CAShapeLayer示例分开举例";
            break;
        }
        case 10: {
            cell.textLabel.text = @"CAGradientLayer";
            cell.detailTextLabel.text = @"CAGradientLayer和CAShapeLayer搭配使用";
            break;
        }
        case 11: {
            cell.textLabel.text = @"缓动函数使用";
            cell.detailTextLabel.text = @"Animation Easing";
            break;
        }
            
        default: break;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *testVC;
    switch (indexPath.row) {
        case 0: {
            testVC = [[DrawCALayerVC  alloc]init];
            break;
        }
        case 1:
        {
            testVC = [[DrawLayer1VC alloc]init];
            break;
        }
        case 2:
        {
            testVC = [[DrawLayer2VC alloc]init];
            break;
        }
        case 3:
        {
            testVC = [[DrawLayer3VC alloc]init];
            break;
        }
        case 4:
        {
            testVC = [[AnimationVC alloc]init];
            break;
        }
        case 5:
        {
            testVC = [[KeyAnimationVC alloc]init];
            break;
        }
        case 6:
        {
            testVC = [[GroupAnimationVC alloc]init];
            break;
        }
        case 7:
        {
            testVC = [[TransitionAnimationVC alloc]init];
            break;
        }
        case 8:
        {
            testVC = [[DisplayLinkVC alloc]init];
            break;
        }
        case 9:
        {
            testVC = [[SubLayerVC alloc]init];
            break;
        }
        case 10:
        {
            testVC = [[CAGradientLayerVC alloc]init];
            break;
        }
        case 11:
        {
            testVC = [[EasingAnimationVC alloc]init];
            break;
        }
            default: break;
    }

      [self.navigationController pushViewController:testVC animated:YES];
}
@end
