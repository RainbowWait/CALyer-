

//
//  ParticleVC.m
//  CALayer
//
//  Created by mac on 2019/10/12.
//  Copyright © 2019 Beijing Zijing Company. All rights reserved.
//

#import "ParticleVC.h"
#import "ParticleView.h"

@interface ParticleVC ()
@property (nonatomic, strong)ParticleView *particle;
@end

@implementation ParticleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //粒子效果
    self.particle = [[ParticleView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height - 100)];
    self.particle.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.particle];
    
}

- (IBAction)startAction:(UIButton *)sender {
    [self.particle start];
    
}
- (IBAction)redrawAction:(UIButton *)sender {
    [self.particle redraw];
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
