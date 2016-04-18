//
//  GradientDetialViewController.m
//  FELayerAnimation
//
//  Created by FlyElephant on 16/4/18.
//  Copyright © 2016年 FlyElephant. All rights reserved.
//

#import "GradientDetialViewController.h"

static  const NSTimeInterval CircleDuration=2.0f;

@interface GradientDetialViewController ()

@property (weak,nonatomic) NSTimer *pushTimer;
@property (assign,nonatomic) CGFloat pushProgress;
@property (strong,nonatomic) CAGradientLayer *pushLayer;

@property (strong,nonatomic) CAGradientLayer *circleLayer;
@property (weak,nonatomic)   NSTimer *circleTimer;

@property (strong,nonatomic) UIImageView *bgImageView;
@property (strong,nonatomic) UIImageView *frontImgView;

@property (strong,nonatomic) CALayer    *imgMaskLayer;
@property (strong,nonatomic) UIView     *imgMaskView;
@property (strong,nonatomic) CAGradientLayer *imgLeftLayer;
@property (strong,nonatomic) CAGradientLayer *imgRightLayer;

@end

@implementation GradientDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    [self setupGradient];
    [self setupGradientPush];
    [self setupCircle];
    [self setupGirl];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.circleTimer invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setup

-(void)setupGradient{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(20, 80, 200, 60)];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    
    gradientLayer.frame = view.bounds;
    gradientLayer.colors = @[(__bridge id)[UIColor blackColor].CGColor,
                             
                             (__bridge id)[UIColor clearColor].CGColor];
    
    gradientLayer.locations = @[@(-1),@(1)];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.type = kCAGradientLayerAxial;
    [view.layer addSublayer:gradientLayer];
    [self.view addSubview:view];
}

-(void)setupGradientPush{
    self.pushLayer= [CAGradientLayer layer];
    self.pushLayer.backgroundColor = [UIColor blueColor].CGColor;
    self.pushLayer.frame    =CGRectMake(240, 80, 120, 100);
    //颜色分割线
    self.pushLayer.locations  = @[@(self.pushProgress-0.1), @(self.pushProgress-0.05), @(self.pushProgress)];
    // 颜色
    self.pushLayer.colors = @[(__bridge id)[UIColor yellowColor].CGColor,
                              (__bridge id)[UIColor purpleColor].CGColor,
                              (__bridge id)[UIColor redColor].CGColor];
    
    self.pushLayer.startPoint = CGPointMake(0, 0);
    self.pushLayer.endPoint   = CGPointMake(1, 0);
    [self.view.layer addSublayer:self.pushLayer];
    
    self.pushTimer=[NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(gradientPush) userInfo:nil repeats:YES];
    self.pushTimer.fireDate=[[NSDate date] dateByAddingTimeInterval:3];
}

-(void)gradientPush{
    self.pushProgress+=0.1;
    if (self.pushProgress >= 1)
    {
        self.pushLayer.locations  = @[@(-0.1), @(-0.05), @(0)];
        [self.pushTimer invalidate];
        return;
    }
    self.pushLayer.locations  = @[@(self.pushProgress-0.1), @(self.pushProgress-0.05), @(self.pushProgress)];
}

-(void)setupCircle{
    CGFloat width=120;
    CGFloat radius=width/2;
    
    CAGradientLayer *circleLayer = [CAGradientLayer layer];
    circleLayer.frame    =CGRectMake(20, 200, width+4, width+4);
    
    
    circleLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                           (__bridge id)[UIColor whiteColor].CGColor,
                           (__bridge id)[UIColor redColor].CGColor];
    // 颜色分割点
    circleLayer.locations  = @[@(-0.2), @(-0.1), @(0)];
    circleLayer.startPoint = CGPointMake(0, 0);
    circleLayer.endPoint   = CGPointMake(1, 0);
    
    CAShapeLayer *shapelayer = [CAShapeLayer layer];
    shapelayer.frame=circleLayer.bounds;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius+2, radius+2)
                                                        radius:radius
                                                    startAngle:0
                                                      endAngle:M_PI*2
                                                     clockwise:YES];
    
    shapelayer.path = path.CGPath;
    
    // 设置填充颜色为透明,若设置为其他颜色将显示渐变层的颜色
    shapelayer.fillColor = [UIColor clearColor].CGColor;
    
    shapelayer.strokeColor = [UIColor redColor].CGColor;
    shapelayer.strokeEnd = 1.0f;
    [self.view.layer addSublayer:circleLayer];
    
    circleLayer.mask = shapelayer;
    
    self.circleLayer=circleLayer;
    
    self.circleTimer=[NSTimer scheduledTimerWithTimeInterval:CircleDuration target:self selector:@selector(gradientCircle) userInfo:nil repeats:YES];
    self.circleTimer.fireDate=[[NSDate date] dateByAddingTimeInterval:2];
}

-(void)gradientCircle{
    CABasicAnimation *rotationAnim = [CABasicAnimation animationWithKeyPath:@"locations"];
    rotationAnim.fromValue = @[@(-0.2), @(-0.1), @(0)];
    rotationAnim.toValue   = @[@(1.0), @(1.1), @(1.2)];
    rotationAnim.duration  = CircleDuration;
    [self.circleLayer addAnimation:rotationAnim forKey:@"rotationAnim"];
}

-(void)setupGirl{
    CGSize screenSize=[[UIScreen mainScreen] bounds].size;
    CGRect imgRect=CGRectMake(0, 360,screenSize.width, screenSize.height-360);
    self.bgImageView=[[UIImageView alloc]initWithFrame:imgRect];
    self.bgImageView.image=[UIImage imageNamed:@"Girl"];
    self.bgImageView.contentMode=UIViewContentModeScaleAspectFill;
    self.bgImageView.clipsToBounds=YES;
    [self.view addSubview:self.bgImageView];
    
    self.frontImgView=[[UIImageView alloc]initWithFrame:imgRect];
    self.frontImgView.image=[UIImage imageNamed:@"Girl1"];
    self.frontImgView.contentMode=UIViewContentModeScaleAspectFill;
    self.frontImgView.clipsToBounds=YES;
    [self.view addSubview:self.frontImgView];
    

    self.imgMaskLayer= [CAGradientLayer layer];
    self.imgMaskLayer.frame    =self.frontImgView.bounds;
    self.imgMaskLayer.backgroundColor=[UIColor clearColor].CGColor;
    
    self.frontImgView.layer.mask=self.imgMaskLayer;
    
    self.imgLeftLayer=[CAGradientLayer layer];
    self.imgLeftLayer.frame = CGRectMake(0, 0, screenSize.width/2, screenSize.height*3);
    self.imgLeftLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                           (__bridge id)[UIColor blackColor].CGColor];
    self.imgLeftLayer.locations =@[@(0.5)];
    self.imgLeftLayer.startPoint =CGPointMake(0.5, 0.3);
    self.imgLeftLayer.endPoint = CGPointMake(0.5, 0.6);
    
    [self.imgMaskLayer addSublayer:self.imgLeftLayer];
    
    
    self.imgRightLayer=[CAGradientLayer layer];
    self.imgRightLayer.frame = CGRectMake(screenSize.width/2, 0, screenSize.width/2, screenSize.height*3);
    self.imgRightLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                                 (__bridge id)[UIColor blackColor].CGColor];
    self.imgRightLayer.locations =@[@(0.5)];
    self.imgRightLayer.startPoint =CGPointMake(0.5, 0.3);
    self.imgRightLayer.endPoint = CGPointMake(0.5, 0.6);
    [self.imgMaskLayer addSublayer:self.imgRightLayer];
    
    [self setupShimmer];
    
}


-(void)setupShimmer{
    CGSize screenSize=[[UIScreen mainScreen] bounds].size;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(CircleDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CABasicAnimation *basicAnimation=[CABasicAnimation animationWithKeyPath:@"position"];
        basicAnimation.fromValue=[NSValue valueWithCGPoint:self.imgLeftLayer.position];
        basicAnimation.toValue=[NSValue valueWithCGPoint:CGPointMake(self.imgLeftLayer.position.x,-screenSize.height)];
        basicAnimation.duration=1.5f;
        basicAnimation.removedOnCompletion=false;
        basicAnimation.fillMode=kCAFillModeForwards;
        [self.imgLeftLayer addAnimation:basicAnimation forKey:@"LeftPosition"];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((CircleDuration+1.5)* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CABasicAnimation *basicAnimation=[CABasicAnimation animationWithKeyPath:@"position"];
        basicAnimation.fromValue=[NSValue valueWithCGPoint:self.imgRightLayer.position];
        basicAnimation.toValue=[NSValue valueWithCGPoint:CGPointMake(self.imgRightLayer.position.x,-screenSize.height/2)];
        basicAnimation.duration=1.5;
        basicAnimation.removedOnCompletion=false;
        basicAnimation.fillMode=kCAFillModeForwards;
        [self.imgRightLayer addAnimation:basicAnimation forKey:@"RightPosition"];
    });
}



@end
