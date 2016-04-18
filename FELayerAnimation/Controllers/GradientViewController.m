//
//  GradientViewController.m
//  FELayerAnimation
//
//  Created by keso on 16/4/17.
//  Copyright © 2016年 FlyElephant. All rights reserved.
//

#import "GradientViewController.h"
#import "GradientDetialViewController.h"

@interface GradientViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *personImgView;

@property (strong,nonatomic) CAGradientLayer *progressLayer;
@property (strong,nonatomic) CALayer *progressMaskLayer;
@property (weak,nonatomic) NSTimer *timer;
@property (assign,nonatomic) CGFloat progress;
@property (weak,nonatomic) NSTimer *gradientTimer;

@property (strong,nonatomic) CAGradientLayer *progressGradientLayer;

@end

@implementation GradientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *nextItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(goNext)];
    self.navigationItem.rightBarButtonItem=nextItem;
    
    [self setupGradient];
//    [self setupCircle];
//    [self setupGradientCircle];
    [self setupProgressView];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    [self.gradientTimer invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

-(void)goNext{
    GradientDetialViewController *detialController=[[GradientDetialViewController alloc]init];
    [self.navigationController pushViewController:detialController animated:YES];
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
    
    CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame    =CGRectMake(80, 170, 200, 40);
    gradientLayer1.colors = @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor purpleColor].CGColor];
    
    gradientLayer1.locations  = @[@(0.5),@(1.0)];
    gradientLayer1.type = kCAGradientLayerAxial;
    gradientLayer1.startPoint = CGPointMake(0, 0);
    gradientLayer1.endPoint   = CGPointMake(0, 1);
    [self.view.layer addSublayer:gradientLayer1];
    
//    CAGradientLayer *gradientLayer2 = [CAGradientLayer layer];
//    gradientLayer2.frame    =CGRectMake(80, 380, 200, 80);
//    gradientLayer2.colors = @[(__bridge id)[UIColor clearColor].CGColor,(__bridge id)[UIColor purpleColor].CGColor];
//    
//    gradientLayer2.locations  = @[@(0.5),@(1.0)];
//    gradientLayer2.type = kCAGradientLayerAxial;
//    gradientLayer2.startPoint = CGPointMake(0, 0);
//    gradientLayer2.endPoint   = CGPointMake(0, 1);
//    [self.view.layer addSublayer:gradientLayer2];
    
    self.personImgView.clipsToBounds=YES;
    CAGradientLayer *gradientLayer3= [CAGradientLayer layer];
    gradientLayer3.frame    =self.personImgView.bounds;
    gradientLayer3.colors = @[(__bridge id)[UIColor blackColor].CGColor,(__bridge id)[UIColor clearColor].CGColor];
    
    gradientLayer3.locations  = @[@(-2),@(1)];
    gradientLayer3.type = kCAGradientLayerAxial;
    gradientLayer3.startPoint = CGPointMake(0, 0);
    gradientLayer3.endPoint   = CGPointMake(0, 1);
    gradientLayer3.type = kCAGradientLayerAxial;
    [self.personImgView.layer addSublayer:gradientLayer3];
}

-(void)setupProgressView{
    self.progressLayer=[CAGradientLayer layer];
    self.progressLayer.frame=CGRectMake(0, 500, [UIScreen mainScreen].bounds.size.width, 2);
    [self setupProgress:self.progressLayer];
    [self.view.layer addSublayer:self.progressLayer];
    
    self.progressGradientLayer=[CAGradientLayer layer];
    self.progressGradientLayer.frame=CGRectMake(0, 520, [UIScreen mainScreen].bounds.size.width, 2);
    [self setupProgress:self.progressGradientLayer];
    [self.view.layer addSublayer:self.progressGradientLayer];
    
    self.progressMaskLayer=[CALayer layer];
    self.progressMaskLayer.backgroundColor=[UIColor blackColor].CGColor;
    self.progressMaskLayer.frame=CGRectMake(0, 0, 0, 2);

    self.timer=[NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    self.timer.fireDate=[[NSDate date] dateByAddingTimeInterval:2];
    
    self.gradientTimer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(progressGradient) userInfo:nil repeats:YES];
    self.gradientTimer.fireDate=[[NSDate date] dateByAddingTimeInterval:2];
}

-(void)setupProgress:(CAGradientLayer *)layer{
    layer.startPoint=CGPointMake(0.0, 0.5);
    layer.endPoint=CGPointMake(1.0, 0.5);
    
    NSMutableArray *colors = [NSMutableArray array];
    for (NSInteger hue = 0; hue <= 360; hue += 5)
    {
        UIColor * color = [UIColor colorWithHue:1.0 * hue / 360
                                     saturation:1.0
                                     brightness:1.0
                                          alpha:1.0];
        [colors addObject:(id)[color CGColor]];
    }
    layer.colors=[NSArray arrayWithArray:colors];
}

-(void)updateProgress{
    self.progress+=0.1;
    if (self.progress>=1) {
        [self.timer invalidate];
        return;
    }
    CGRect frame=self.progressLayer.bounds;
    frame.size.width=frame.size.width*self.progress;
    self.progressMaskLayer.frame=frame;
    self.progressLayer.mask=self.progressMaskLayer;
}

-(void)progressGradient{
    NSMutableArray * colorArray = [[self.progressGradientLayer colors] mutableCopy];
    UIColor * lastColor = [colorArray lastObject];
    [colorArray removeLastObject];
    [colorArray insertObject:lastColor atIndex:0];
    NSArray * shiftedColors = [NSArray arrayWithArray:colorArray];
    
    [self.progressGradientLayer setColors:shiftedColors];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    [animation setToValue:shiftedColors];
    [animation setDuration:0.1];
    [animation setFillMode:kCAFillModeForwards];
    [animation setDelegate:self];
    [self.progressGradientLayer addAnimation:animation forKey:@"animateGradient"];
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
