
//
//  Son.m
//  CALayer
//
//  Created by mac on 2019/10/12.
//  Copyright © 2019 Beijing Zijing Company. All rights reserved.
//

#import "Son.h"

@implementation Son
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"%@", NSStringFromClass([self class]));
        NSLog(@"%@", [super class]);
    }
    return self;
}
@end
