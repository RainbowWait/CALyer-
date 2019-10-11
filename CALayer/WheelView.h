//
//  WheelView.h
//  CALayer
//
//  Created by mac on 2019/10/10.
//  Copyright © 2019 Beijing Zijing Company. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WheelView : UIView
+ (instancetype)wheelView;
- (void)start;
- (void)pause;
@end

NS_ASSUME_NONNULL_END
