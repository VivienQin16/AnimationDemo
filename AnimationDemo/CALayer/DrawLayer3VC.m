//
//  DrawLayer3VC.m
//  AnimationDemo
//
//  Created by Vivien on 15/10/26.
//  Copyright © 2015年 vivien. All rights reserved.
//

#import "DrawLayer3VC.h"
#import "KCView.h"
@implementation DrawLayer3VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    KCView *view=[[KCView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor=[UIColor colorWithRed:249.0/255.0 green:249.0/255.0 blue:249.0/255.0 alpha:1];
    
    
    [self.view addSubview:view];
}

@end
