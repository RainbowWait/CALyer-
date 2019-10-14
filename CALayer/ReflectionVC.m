//
//  ReflectionVC.m
//  CALayer
//
//  Created by mac on 2019/10/14.
//  Copyright © 2019 Beijing Zijing Company. All rights reserved.
//

#import "ReflectionVC.h"
#import "ReflectionView.h"

@interface ReflectionVC ()
@property (weak, nonatomic) IBOutlet ReflectionView *reflecView;

@end

@implementation ReflectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CAReplicatorLayer *rep = (CAReplicatorLayer *)self.reflecView.layer;
    rep.instanceCount = 2;
    CATransform3D transform = CATransform3DMakeTranslation(0, self.reflecView.bounds.size.height, 0);
    //绕x轴旋转
    rep.instanceTransform = CATransform3DRotate(transform, M_PI, 1, 0, 0);
    rep.instanceAlphaOffset = -0.1;
    rep.instanceRedOffset = -0.1;
    rep.instanceBlueOffset = -0.1;
    rep.instanceGreenOffset = -0.1;
    
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
