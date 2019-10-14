//
//  ReflectionView.m
//  CALayer
//
//  Created by mac on 2019/10/14.
//  Copyright © 2019 Beijing Zijing Company. All rights reserved.
//

#import "ReflectionView.h"

@implementation ReflectionView
//复制层的view的主层:复制层
+ (Class)layerClass {
    return [CAReplicatorLayer class];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
