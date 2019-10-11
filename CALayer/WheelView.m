//
//  WheelView.m
//  CALayer
//
//  Created by mac on 2019/10/10.
//  Copyright © 2019 Beijing Zijing Company. All rights reserved.
//

#import "WheelView.h"
#import "WheelButton.h"

@interface WheelView ()<CAAnimationDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (nonatomic, strong) WheelButton *lastSelectedBtn;
@property (nonatomic, strong) CADisplayLink *link;
@end

@implementation WheelView

- (CADisplayLink *)link {
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(angleChange:)];
        [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        
    }
    return _link;
}


+ (instancetype)wheelView {
    return [[NSBundle mainBundle]loadNibNamed:@"WheelView" owner:nil options:nil].firstObject;
}

//注意这个方法只是加载xib的时候调用,但是并没有连好线
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        NSLog(@"-------%@", self.img);
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
     NSLog(@"====%@", self.img);
    UIImage *iconNormalImage = [UIImage imageNamed:@"LuckyAstrology"];
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat iconNormalImageWidth = iconNormalImage.size.width/12 * scale;
    CGFloat iconNormalImageHeight = iconNormalImage.size.height * scale;
     UIImage *iconSelectedImage = [UIImage imageNamed:@"LuckyAstrologyPressed"];
    CGFloat iconSelectedImageWidth = iconSelectedImage.size.width/12 * 2;
    CGFloat iconSelectedImageHeight = iconSelectedImage.size.height * 2;
    CGFloat superWidth = self.bounds.size.width;
    CGFloat superHeight = self.bounds.size.height;
    for (NSInteger i = 0; i < 12; i++) {
        WheelButton *button = [WheelButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 68, 143);
        button.layer.position = CGPointMake(superWidth/2.0, superHeight/2.0);
        button.layer.anchorPoint = CGPointMake(0.5, 1);
//        button.backgroundColor = [UIColor redColor];
        [self.img addSubview:button];
        //裁剪图片
        //rect: 裁剪区域
        //裁剪区域是以像素为基准
        CGImageRef normalRef =   CGImageCreateWithImageInRect(iconNormalImage.CGImage, CGRectMake(i * iconNormalImageWidth, 0, iconNormalImageWidth, iconNormalImageHeight));
        [button setImage:[UIImage imageWithCGImage:normalRef] forState:UIControlStateNormal];
        //裁剪图片
        CGImageRef selectedRef =   CGImageCreateWithImageInRect(iconSelectedImage.CGImage, CGRectMake(i * iconSelectedImageWidth, 0, iconSelectedImageWidth, iconSelectedImageHeight));
//        NSLog(@"%@=====",NSStringFromCGSize([UIImage imageWithCGImage:selectedRef].size));
        [button setImage:[UIImage imageWithCGImage:selectedRef] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.transform = CATransform3DMakeRotation(i * 30/180.0 * M_PI, 0, 0, 1);
        [button setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
//        button.backgroundColor = [UIColor colorWithRed:(arc4random_uniform(256)/255.0) green:(arc4random_uniform(256)/255.0) blue:(arc4random_uniform(256)/255.0) alpha:1];
        if (i == 0) {
            [self selectedAction:button];
        }
        
    }
}
- (void)selectedAction: (WheelButton *)sender {
    self.lastSelectedBtn.selected = NO;
    sender.selected = YES;
    self.lastSelectedBtn = sender;
}

- (IBAction)startAction:(id)sender {
    self.link.paused = YES;
    CABasicAnimation *ani = [CABasicAnimation animation];
    ani.delegate = self;
    ani.keyPath = @"transform.rotation";
    ani.toValue = @(M_PI *2 * 3);
//    ani.repeatCount = CGFLOAT_MAX;
    ani.duration = 2;
    [self.img.layer addAnimation:ani forKey:nil];
    //点击哪个星座,就把当前的星座指向中心点上面
    //根据选中的按钮获取旋转的度数,通过transform
    CGFloat angle = atan2(self.lastSelectedBtn.transform.b, self.lastSelectedBtn.transform.a);
    NSLog(@"---%f", angle);
    //旋转转盘
    self.img.transform = CGAffineTransformMakeRotation(-angle);
    

}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.link.paused = NO;
    });
}

//使用定时器,每隔一段时间旋转一个角度,1秒旋转45度
- (void)angleChange: (CADisplayLink *)link {
    CGFloat angle = 45/60.0 * M_PI/180;
    _img.transform = CGAffineTransformRotate(_img.transform, angle);
}

/**
 开始
 */
- (void)start {
    //要用户交互就不能使用核心动画
    /*
    CABasicAnimation *ani = [CABasicAnimation animation];
    ani.keyPath = @"transform.rotation";
    ani.toValue = @(M_PI *2);
    ani.repeatCount = CGFLOAT_MAX;
    ani.duration = 4;
    [self.img.layer addAnimation:ani forKey:nil];
     */
    self.link.paused = NO;
}


/**
 暂停
 */
- (void)pause {
    self.link.paused = YES;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
