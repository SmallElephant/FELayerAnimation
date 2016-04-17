//
//  ViewController.m
//  FELayerAnimation
//
//  Created by keso on 16/4/17.
//  Copyright © 2016年 FlyElephant. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (strong,nonatomic) UIView *bgView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.bgView=[[UIView alloc]initWithFrame:CGRectMake(40, 60, 120, 80)];
//    self.bgView.backgroundColor=[UIColor redColor];
//    [self.view addSubview:self.bgView];
//    
//       NSLog(@"frame:%@--position : %@,anchorPoint :%@",NSStringFromCGRect(self.bgView.frame),NSStringFromCGPoint(self.bgView.layer.position),NSStringFromCGPoint(self.bgView.layer.anchorPoint));
//    self.bgView.layer.anchorPoint=CGPointMake(0, 0);
//    NSLog(@"frame:%@--position : %@,anchorPoint :%@",NSStringFromCGRect(self.bgView.frame),NSStringFromCGPoint(self.bgView.layer.position),NSStringFromCGPoint(self.bgView.layer.anchorPoint));
//    
//    self.bgView.layer.anchorPoint=CGPointMake(1, 1);
//    NSLog(@"frame:%@--position : %@,anchorPoint :%@",NSStringFromCGRect(self.bgView.frame),NSStringFromCGPoint(self.bgView.layer.position),NSStringFromCGPoint(self.bgView.layer.anchorPoint));
//    
//    
//    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(40, 60, 120, 80)];
//    view.backgroundColor=[UIColor greenColor];
//    [self.view addSubview:view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
