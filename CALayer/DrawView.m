//
//  DrawView.m
//  CALayer
//
//  Created by mac on 2019/10/9.
//  Copyright © 2019 Beijing Zijing Company. All rights reserved.
//

#import "DrawView.h"

@interface DrawView()
@property (nonatomic, strong) UIImageView *img;
@property (nonatomic, strong) UIBezierPath *path;
@end



@implementation DrawView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.img = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
        [self addSubview:self.img];
        self.backgroundColor = [UIColor whiteColor];
        self.img.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currP = [touch locationInView:self];
    UIBezierPath *bezi = [UIBezierPath bezierPath];
    [bezi moveToPoint:currP];
    self.path = bezi;
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

        UITouch *touch = [touches anyObject];
        CGPoint currP = [touch locationInView:self];
    [self.path addLineToPoint:currP];
    [self setNeedsDisplay];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CAKeyframeAnimation *keyAni = [CAKeyframeAnimation animation];
    keyAni.keyPath = @"position";
    keyAni.path = self.path.CGPath;
    keyAni.duration = 1.0;
    keyAni.repeatCount= 1;//MAXFLOAT;
    //设置动画完成时不要移除动画
    keyAni.removedOnCompletion = NO;
    //设置动画完成时不要移除动画
    keyAni.fillMode = kCAFillModeForwards;
    [self.img.layer addAnimation:keyAni forKey:nil];
    
    
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self.path stroke];
}

@end
