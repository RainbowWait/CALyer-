//
//  SecondViewController.m
//  CALayer
//
//  Created by mac on 2019/10/10.
//  Copyright © 2019 Beijing Zijing Company. All rights reserved.
//

#import "SecondViewController.h"
#import "WheelView.h"

@interface SecondViewController ()
@property (nonatomic, strong) WheelView *wheelView;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.wheelView = [WheelView wheelView];
    [self.view addSubview:self.wheelView];
    self.wheelView.center = self.view.center;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)startAction:(id)sender {
    [self.wheelView start];
}

- (IBAction)pauseAction:(id)sender {
    [self.wheelView pause];
}

@end
