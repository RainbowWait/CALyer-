//
//  WheelButton.m
//  CALayer
//
//  Created by mac on 2019/10/10.
//  Copyright © 2019 Beijing Zijing Company. All rights reserved.
//

#import "WheelButton.h"

@implementation WheelButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGFloat btnW = self.bounds.size.width;
    CGFloat btnH = self.bounds.size.height;
    CGFloat x = 0;
    CGFloat y = btnH/2.0;
    CGFloat w = btnW;
    CGFloat h = btnH/2.0;
    if (CGRectContainsPoint(CGRectMake(x, y, w, h), point)) {
        return nil;
    } else {
        return [super hitTest:point
                    withEvent:event];
    }
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    UIImage *iconNormalImage = [UIImage imageNamed:@"LuckyAstrology"];
    CGFloat imageWidth = iconNormalImage.size.width/12.0;
    return CGRectMake((contentRect.size.width - imageWidth)/2.0, 20, imageWidth, iconNormalImage.size.height);
}

- (void)setHighlighted:(BOOL)highlighted {
    
}
@end
