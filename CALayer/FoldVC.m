//
//  FoldVC.m
//  CALayer
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 Beijing Zijing Company. All rights reserved.
//

#import "FoldVC.h"

@interface FoldVC ()
@property (weak, nonatomic) IBOutlet UIImageView *topImg;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImg;
@property (weak, nonatomic) IBOutlet UIView *panView;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@end

@implementation FoldVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //通过contentsRect
    self.topImg.layer.contentsRect = CGRectMake(0, 0, 1, 0.5);
    self.topImg.layer.anchorPoint = CGPointMake(0.5, 1);
    self.bottomImg.layer.contentsRect = CGRectMake(0, 0.5, 1, 0.5);
    self.bottomImg.layer.anchorPoint = CGPointMake(0.5, 0);
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bottomImg.bounds;
//    gradient.locations = @[];
    gradient.colors = @[(id)[UIColor clearColor].CGColor, (id)[UIColor blackColor].CGColor];
    gradient.opacity = 0;
    self.gradientLayer = gradient;
    [self.bottomImg.layer addSublayer:gradient];
}
- (IBAction)panAction:(UIPanGestureRecognizer *)sender {
    CGPoint point = [sender translationInView:self.panView];
    // 旋转角度,往下逆时针旋转
    CGFloat angle = -point.y / 200.0 * M_PI;
    NSLog(@"%f",angle);
    CATransform3D transfrom = CATransform3DIdentity;
    // 增加旋转的立体感，近大远小,d：距离图层的距离
    transfrom.m34 = -1 /200.0;
    self.gradientLayer.opacity = point.y / 200.0;
    transfrom = CATransform3DRotate(transfrom, angle, 1, 0, 0);
    self.topImg.layer.transform = transfrom;
    if (sender.state == UIGestureRecognizerStateEnded) {
        // 弹簧效果的动画
        // SpringWithDamping:弹性系数,越小，弹簧效果越明显
        [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.topImg.layer.transform = CATransform3DIdentity;
            self.gradientLayer.opacity = 0;
        } completion:^(BOOL finished) {
            
        }];
    }
    
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
