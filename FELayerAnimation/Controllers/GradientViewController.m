//
//  GradientViewController.m
//  FELayerAnimation
//
//  Created by keso on 16/4/17.
//  Copyright © 2016年 FlyElephant. All rights reserved.
//

#import "GradientViewController.h"

@interface GradientViewController ()

@end

@implementation GradientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupGradient];
    [self setupCircle];
    [self setupGradientCircle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setup

-(void)setupGradient{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame    =CGRectMake(80, 80, 200, 80);
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                          (__bridge id)[UIColor greenColor].CGColor,
                          (__bridge id)[UIColor yellowColor].CGColor,
                          (__bridge id)[UIColor blueColor].CGColor];
    
    gradientLayer.locations  = @[@(0.2), @(0.4), @(0.6),@(0.8)];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint   = CGPointMake(0, 1);
    [self.view.layer addSublayer:gradientLayer];
}


-(void)setupCircle{
    
    CGFloat circleRadius=50;
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.frame=CGRectMake(50, 200, circleRadius*2, circleRadius*2);
    circleLayer.lineDashPattern=[NSArray arrayWithObjects:[NSNumber numberWithInt:M_PI*circleRadius],
                                 [NSNumber numberWithInt:10],[NSNumber numberWithInt:M_PI*circleRadius-20],[NSNumber numberWithInt:10],nil];
    [self setCircleLayer:circleLayer radius:circleRadius];
    [self.view.layer addSublayer:circleLayer];
}

-(void)setupGradientCircle{
    CGFloat radius=50;
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.backgroundColor = [UIColor blueColor].CGColor;
    gradientLayer.frame    =CGRectMake(200, 200, radius*2, radius*2);
    
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                          (__bridge id)[UIColor greenColor].CGColor];
    gradientLayer.locations  = @[@(-0.2), @(0)];
//    gradientLayer.locations  = @[@(0)];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint   = CGPointMake(1, 0);
    
//    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius)
//                                                        radius:radius
//                                                    startAngle:0
//                                                      endAngle:M_PI*2
//                                                     clockwise:YES];
//    gradientLayer.path = path.CGPath;
    
    CABasicAnimation* locationAnim = [CABasicAnimation animationWithKeyPath:@"locations"];
    locationAnim.fromValue = @[@(-0.2),@(0)];
    locationAnim.toValue   = @[@(1.0),@(1.2)];
    locationAnim.duration  = 2.0;
    [gradientLayer addAnimation:locationAnim forKey:nil];
    [self.view.layer addSublayer:gradientLayer];
}

-(void)setCircleLayer:(CAShapeLayer *)layer radius:(CGFloat)radius{
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor redColor].CGColor;
    
    layer.strokeStart=0.0f;
    layer.strokeEnd =1.0f;
    layer.lineWidth =1.0;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius)
                                                        radius:radius
                                                    startAngle:0
                                                      endAngle:M_PI*2
                                                     clockwise:YES];
    layer.path = path.CGPath;
}


@end
