//
//  ViscousEffectView.m
//  CALayer
//
//  Created by mac on 2019/10/14.
//  Copyright © 2019 Beijing Zijing Company. All rights reserved.
//

#import "ViscousEffectView.h"

@interface ViscousEffectView ()
@property (nonatomic, strong) UIView *smallView;
@property (nonatomic, assign) CGFloat smallRadius;
@property (nonatomic, strong) CAShapeLayer *shareLayer;
@end

@implementation ViscousEffectView
static CGFloat maxDistance = 70;

- (UIView *)smallView {
    if (!_smallView) {
        _smallView = [[UIView alloc]initWithFrame:self.bounds];
        _smallView.backgroundColor = self.backgroundColor;
        _smallView.layer.cornerRadius = self.bounds.size.width/2.0;
        self.smallRadius = _smallView.layer.cornerRadius;
        [self.superview insertSubview:_smallView belowSubview:self];

    }
    return _smallView;
}

- (CAShapeLayer *)shareLayer {
    if (!_shareLayer) {
        _shareLayer = [CAShapeLayer layer];
        [_shareLayer setFillColor:self.backgroundColor.CGColor];
        [self.superview.layer insertSublayer:_shareLayer below:self.layer];
    }
    return _shareLayer;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUp];
}

- (void)setUp {
    self.layer.cornerRadius = self.bounds.size.width/2.0;
    self.titleLabel.font = [UIFont systemFontOfSize:11];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureAction:)];
    [self addGestureRecognizer:pan];
    self.smallView.center = self.center;
}

- (void)panGestureAction: (UIPanGestureRecognizer *)pan {
    CGPoint tran = [pan translationInView:self];
    CGPoint center = self.center;
    center.x += tran.x;
    center.y += tran.y;
    self.center = center;
    [pan setTranslation:CGPointZero inView:self];
    CGFloat distance = [self getRadiusDistance:self.smallView.center bigPoint:self.center];
    NSLog(@"%f",distance);
    CGFloat smallRadius = self.smallRadius - distance/10;
    self.smallView.bounds = CGRectMake(0, 0, smallRadius * 2, smallRadius * 2);
    self.smallView.layer.cornerRadius = smallRadius;
//    NSLog(@"%@",NSStringFromCGRect(self.smallView.frame));
    if (distance > 0 && distance < maxDistance && self.smallView.hidden == NO) {
        self.shareLayer.hidden = NO;
        self.shareLayer.path = [self pathWithBigCirCleView:self smallCirCleView:self.smallView].CGPath;
    }
    if (distance > maxDistance) {
        self.smallView.hidden = YES;
        [self.shareLayer removeFromSuperlayer];
        self.shareLayer = nil;
    }
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        if (distance > maxDistance) {
            NSMutableArray *imagesArray = [NSMutableArray array];
            for (NSInteger i = 1; i < 9; i++) {
                [imagesArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",i]]];
            }
            UIImageView *img = [[UIImageView alloc]initWithFrame:self.bounds];
//            img.center = self.center;
            img.animationImages = imagesArray;
            img.animationDuration = 0.5;
            img.animationRepeatCount = 1;
            [img startAnimating];
            [self addSubview:img];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.smallView.hidden = NO;
                [self.shareLayer removeFromSuperlayer];
                self.shareLayer = nil;
                [self removeFromSuperview];
                [self.smallView removeFromSuperview];
            });
        } else {
            [self.shareLayer removeFromSuperlayer];
            self.shareLayer = nil;
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
                self.center = self.smallView.center;
            } completion:^(BOOL finished) {
                self.smallView.hidden = NO;
                [self.shareLayer removeFromSuperlayer];
                self.shareLayer = nil;
            }];
        }
    }
    
}


//获取两个圆之间圆心的距离
- (CGFloat)getRadiusDistance: (CGPoint)smallPoint bigPoint: (CGPoint)bigPoint {
    CGFloat x = bigPoint.x - smallPoint.x;
    CGFloat y = bigPoint.y - smallPoint.y;
    CGFloat distance = sqrt(x * x + y * y);
    return distance;
}

//描述两圆之间的矩形路径
- (UIBezierPath *)pathWithBigCirCleView:(UIView *)bigCirCleView  smallCirCleView:(UIView *)smallCirCleView {
    CGPoint smallPoint = smallCirCleView.center;
    CGFloat x1 = smallPoint.x;
    CGFloat y1 = smallPoint.y;
    CGFloat r1 = smallCirCleView.bounds.size.width/2.0;
    CGPoint bigPoint = bigCirCleView.center;
    CGFloat x2 = bigPoint.x;
    CGFloat y2 = bigPoint.y;
    CGFloat r2 = bigCirCleView.bounds.size.width/2.0;
    CGFloat d = [self getRadiusDistance:smallPoint bigPoint:bigPoint];
    CGFloat sinθ = (x2 - x1)/d;
    CGFloat cosθ = (y2 - y1)/d;
    CGPoint pointA = CGPointMake(x1 -r1 * cosθ , y1 + r1 * sinθ);
    CGPoint pointB = CGPointMake(x1 + r1 * cosθ, y1 - r1 * sinθ);
    CGPoint pointC = CGPointMake(x2 + r2 * cosθ, y2 - r2 * sinθ);
    CGPoint pointD = CGPointMake(x2 - r2 * cosθ, y2 + r2 * sinθ);
    CGPoint pointO = CGPointMake(pointA.x + sinθ * d/2, pointA.y + cosθ * d/2);
    CGPoint pointP = CGPointMake(pointB.x + sinθ * d/2, pointB.y + cosθ * d/2);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:pointA];
    [path addLineToPoint:pointB];
    [path addQuadCurveToPoint:pointC controlPoint:pointP];
    [path addLineToPoint:pointD];
    [path addQuadCurveToPoint:pointA controlPoint:pointO];
    return path;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
