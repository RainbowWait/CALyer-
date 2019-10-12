//
//  ParticleView.m
//  CALayer
//
//  Created by mac on 2019/10/12.
//  Copyright © 2019 Beijing Zijing Company. All rights reserved.
//

#import "ParticleView.h"

@interface ParticleView  ()
@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, strong) CAReplicatorLayer *replicatorLayer;
@property (nonatomic, strong) CALayer *subLayer;
@end

@implementation ParticleView

- (void)awakeFromNib {
    [super awakeFromNib];

    
}

- (UIBezierPath *)path {
    if (!_path) {
        _path = [UIBezierPath bezierPath];
    }
    return _path;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.replicatorLayer = [CAReplicatorLayer layer];
        self.replicatorLayer.frame = self.bounds;
        [self.layer addSublayer:self.replicatorLayer];
    }
    return self;
}


- (CALayer *)subLayer {
    if (!_subLayer) {
        CALayer *subLayer = [CALayer layer];
        subLayer.backgroundColor = [UIColor redColor].CGColor;
        subLayer.frame = CGRectMake(0, -1000, 10, 10);
        subLayer.cornerRadius = 5;
        [self.replicatorLayer addSublayer:subLayer];
        _subLayer = subLayer;
    }
    return _subLayer;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint curr = [touch locationInView:self];
    [self.path moveToPoint:curr];
}

static int i = 0;
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    i++;
    UITouch *touch = [touches anyObject];
    CGPoint curr = [touch locationInView:self];
    [self.path addLineToPoint:curr];
    [self setNeedsDisplay];
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self.path stroke];
}

- (void)start {
    CAKeyframeAnimation *ani = [CAKeyframeAnimation animation];
    ani.keyPath = @"position";
    ani.duration = 3.0;
    ani.path = self.path.CGPath;
    ani.repeatCount = MAXFLOAT;
    [self.subLayer addAnimation:ani forKey:nil];
    self.replicatorLayer.instanceDelay = 0.1;
    self.replicatorLayer.instanceCount = i;
    
}

- (void)redraw {
    self.path = nil;
    [self setNeedsDisplay];
    [self.subLayer removeFromSuperlayer];
    self.subLayer = nil;
    
}


@end
