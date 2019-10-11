//
//  ViewController.m
//  CALayer
//
//  Created by mac on 2019/9/30.
//  Copyright © 2019 Beijing Zijing Company. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"
#define angleRadion(angle) (angle / 180.0 * M_PI)
@interface ViewController ()
@property (nonatomic, strong) CALayer *layer;
@property (nonatomic, strong) UIImageView *img;
@end
static NSInteger i = 1;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    self.view.backgroundColor = [UIColor lightGrayColor];
    // Do any additional setup after loading the view.
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor redColor];
    view.layer.shadowOpacity = 1.0;
    view.layer.shadowColor = [UIColor yellowColor].CGColor;
    view.layer.shadowRadius = 10;
    view.layer.cornerRadius = 50;
    view.layer.borderWidth = 1;
    view.layer.borderColor = [UIColor whiteColor].CGColor;
*/
#if 0
    CALayer *layer = [[CALayer alloc]init];
    layer.frame = CGRectMake(0, 0, 100, 100);
    layer.position = CGPointMake(100, 100);
    layer.anchorPoint = CGPointMake(0.5, 0);
    layer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer];
    self.layer = layer;
#endif
#if 0
    DrawView *drawView = [[DrawView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:drawView];
#endif
#if 1
    self.img = [[UIImageView alloc]initWithFrame:self.view.frame];
    self.img.image = [UIImage imageNamed:@"1"];
    [self.view addSubview:self.img];
#endif
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    /*
    //旋转
//    self.layer.position = CGPointMake(arc4random_uniform(200), arc4random_uniform(200));
    self.layer.transform = CATransform3DMakeRotation(arc4random_uniform(360)/180.0, 0, 0, 1);*/
#pragma mark - CABasicAnimation
    /*
    //创建动画
    CABasicAnimation *ani = [CABasicAnimation animation];
    //描述下修改哪个属性动画
    ani.keyPath = @"position";
    //设置值
    ani.toValue = [NSValue valueWithCGPoint:CGPointMake(250, 500)];
    //设置动画完成时不要移除动画
    ani.removedOnCompletion = NO;
    //设置动画完成时不要移除动画
    ani.fillMode = kCAFillModeForwards;
    //
    [self.layer addAnimation:ani forKey:nil];
    */
#pragma mark - CAKeyframeAnimation
#if 0
    //抖动效果
    CAKeyframeAnimation *keyAni = [CAKeyframeAnimation animation];
    keyAni.keyPath = @"transform.rotation";
    keyAni.repeatCount = MAXFLOAT;
    keyAni.values = @[@(angleRadion(-5)), @(angleRadion(5)), @(angleRadion(-5))];
    [self.layer addAnimation:keyAni forKey:nil];
#endif
#if 0
    //绕着这个区域转动
    CAKeyframeAnimation *ani= [CAKeyframeAnimation animation];
    ani.keyPath = @"position";
    ani.path = [UIBezierPath bezierPathWithRect:CGRectMake(30, 30, 100, 200)].CGPath;
    ani.duration = 1.0;
    ani.repeatCount= MAXFLOAT;
    [self.layer addAnimation:ani forKey:nil];
#endif
    
#if 1
    i++;
    if (i > 4) {
        i = 1;
    }
    self.img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld", i]];
    CATransition *tran = [CATransition animation];
    tran.type = @"rippleEffect";
    [self.img.layer addAnimation:tran forKey:nil];

    
#endif
    
    
    
}


@end
