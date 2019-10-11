//
//  RepeatLayerVC.m
//  CALayer
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 Beijing Zijing Company. All rights reserved.
//

#import "RepeatLayerVC.h"

@interface RepeatLayerVC ()
@property (weak, nonatomic) IBOutlet UIView *layerView;
@end

@implementation RepeatLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CAReplicatorLayer *layer = [CAReplicatorLayer layer];
    layer.backgroundColor = [UIColor orangeColor].CGColor;
    layer.frame = self.layerView.bounds;
    [self.layerView.layer addSublayer:layer];
    CALayer *subLayer = [CALayer layer];
    subLayer.frame = CGRectMake(0, 0, 30, 150);
    subLayer.anchorPoint = CGPointMake(0.5, 1);
    subLayer.position = CGPointMake(15, layer.bounds.size.height);
    subLayer.backgroundColor = [UIColor blueColor].CGColor;
    [layer addSublayer:subLayer];
    layer.instanceCount = 7;
    layer.instanceDelay = 0.1;
//    layer.instanceColor = [UIColor redColor].CGColor;
    //设置复制子层偏移量,不包括原始层,相对于原始层x偏移
    layer.instanceTransform = CATransform3DMakeTranslation(45, 0, 0);
    CABasicAnimation *ani = [CABasicAnimation animation];
    ani.keyPath = @"transform.scale.y";
    ani.duration = 0.5;
    ani.toValue = @0.1;
    ani.repeatCount = MAXFLOAT;
    // 设置动画反转
    ani.autoreverses = YES;
    [subLayer addAnimation:ani forKey:nil];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
